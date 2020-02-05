import numpy as np
import torch
import torch.nn as nn
# SSY
import torch.autograd
from torch.autograd import Function

from mlperf_compliance import mlperf_log

# SSY
def float2bf16(xmlp):
        ssign=torch.sign(xmlp)
        aabs=torch.abs(xmlp)
        a=torch.where(aabs==0.0,aabs,torch.log2(aabs))
        b_exp=torch.floor(a) # exp value
        rnd2exp=torch.pow(2,b_exp) # get back the old value rounded to 2 exp
        mantis=torch.div(aabs,rnd2exp) # mantis
        m256=torch.mul(mantis,2)
        f256=torch.floor(m256)
        d256=torch.div(f256,2)
        res=torch.mul(d256,rnd2exp)
        res1= torch.mul(res,ssign)
        # already debug to remove nan from log(0)
        #print("xmlp "+str(xmlp))
        #print("res1 "+str(res1))
        return res1

class bf16cut(Function):
    @staticmethod
    def forward(ctx, tensor):
        # ctx is a context object that can be used to stash information
        # for backward computation
        return float2bf16(tensor)

    @staticmethod
    def backward(ctx, grad_output):
        # We return as many input gradients as there were arguments.
        # Gradients of non-Tensor arguments to forward must be None.
        #return grad_output
        return float2bf16(grad_output)

class NeuMF(nn.Module):
    def __init__(self, nb_users, nb_items,
                 mf_dim, mf_reg,
                 mlp_layer_sizes, mlp_layer_regs):
        if len(mlp_layer_sizes) != len(mlp_layer_regs):
            raise RuntimeError('u dummy, layer_sizes != layer_regs!')
        if mlp_layer_sizes[0] % 2 != 0:
            raise RuntimeError('u dummy, mlp_layer_sizes[0] % 2 != 0')
        super(NeuMF, self).__init__()
        nb_mlp_layers = len(mlp_layer_sizes)

        mlperf_log.ncf_print(key=mlperf_log.MODEL_HP_MF_DIM)

        # TODO: regularization?
        self.mf_user_embed = nn.Embedding(nb_users, mf_dim)
        self.mf_item_embed = nn.Embedding(nb_items, mf_dim)
        self.mlp_user_embed = nn.Embedding(nb_users, mlp_layer_sizes[0] // 2)
        self.mlp_item_embed = nn.Embedding(nb_items, mlp_layer_sizes[0] // 2)

        mlperf_log.ncf_print(key=mlperf_log.MODEL_HP_MLP_LAYER_SIZES, value=mlp_layer_sizes)
        # SSY creating empty one
        self.mlp = nn.ModuleList()
        # SSY adding layers one by one
        for i in range(1, nb_mlp_layers):
            self.mlp.extend([nn.Linear(mlp_layer_sizes[i - 1], mlp_layer_sizes[i])])  # noqa: E501

        self.final = nn.Linear(mlp_layer_sizes[-1] + mf_dim, 1)

        self.mf_user_embed.weight.data.normal_(0., 0.01)
        self.mf_item_embed.weight.data.normal_(0., 0.01)
        self.mlp_user_embed.weight.data.normal_(0., 0.01)
        self.mlp_item_embed.weight.data.normal_(0., 0.01)

        def golorot_uniform(layer):
            fan_in, fan_out = layer.in_features, layer.out_features
            limit = np.sqrt(6. / (fan_in + fan_out))
            layer.weight.data.uniform_(-limit, limit)

        def lecunn_uniform(layer):
            fan_in, fan_out = layer.in_features, layer.out_features  # noqa: F841, E501
            limit = np.sqrt(3. / fan_in)
            layer.weight.data.uniform_(-limit, limit)
        for layer in self.mlp:
            if type(layer) != nn.Linear:
                continue
            golorot_uniform(layer)
        lecunn_uniform(self.final)

    def forward(self, user, item, sigmoid=False):
        #print("ssy forward NeuMF")
        xmfu = self.mf_user_embed(user)
        xmfi = self.mf_item_embed(item)
        xmf = xmfu * xmfi

        xmlpu = self.mlp_user_embed(user)
        xmlpi = self.mlp_item_embed(item)
        xmlp = torch.cat((xmlpu, xmlpi), dim=1)
        for i, layer in enumerate(self.mlp):
            # SSY can not use it this way, because every operation is recorded to generate derivation
            # but our trick to convert float32 to bf16 is not derivable
            xmlp = bf16cut.apply(xmlp)
            xmlp = layer(xmlp)
            xmlp = nn.functional.relu(xmlp)

        x = torch.cat((xmf, xmlp), dim=1)
        x = self.final(x)
        if sigmoid:
            x = nn.functional.sigmoid(x)
        return x
