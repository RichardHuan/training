# SSY
import torch.autograd
from torch.autograd import Function
# SSY
#def float2bf16(xmlp):
#        ssign=torch.sign(xmlp)
#        aabs=torch.abs(xmlp)
#        a=torch.log2(aabs)
#        b_exp=torch.floor(a) # exp value
#        rnd2exp=torch.pow(2,b_exp) # get back the old value rounded to 2 exp
#        mantis=torch.div(aabs,rnd2exp) # mantis
#        m256=torch.mul(mantis,65536)
#        f256=torch.floor(m256)
#        d256=torch.div(f256,65536)
#        res=torch.mul(d256,rnd2exp)
#        return torch.mul(res,ssign)
def float2bf16(xmlp):
        ssign=torch.sign(xmlp)
        aabs=torch.abs(xmlp)
        a=torch.where(aabs==0.0,aabs,torch.log2(aabs))
        b_exp=torch.floor(a) # exp value
        rnd2exp=torch.pow(2,b_exp) # get back the old value rounded to 2 exp
        mantis=torch.div(aabs,rnd2exp) # mantis
        m256=torch.mul(mantis,256)
        f256=torch.floor(m256)
        d256=torch.div(f256,256)
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
        # SSY I can be sure that they are called
        #print("SSY forward bf16cut")
        return float2bf16(tensor)

    @staticmethod
    def backward(ctx, grad_output):
        # We return as many input gradients as there were arguments.
        # Gradients of non-Tensor arguments to forward must be None.
        #return grad_output
        # SSY I can be sure that they are called
        #print("SSY backward bf16cut")
        return float2bf16(grad_output)

