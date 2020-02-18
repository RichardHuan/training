# SSY
import torch.autograd
from torch.autograd import Function
# this file is for copying toy
# SSY /opt/conda/lib/python3.6/site-packages/torch/nn/modulesy
#from torch.nn import Module 
from .module import Module
# SSY

# SSY avoid lots of intermedia result space
def float2bf16(xmlp):
        aabs=torch.abs(xmlp)
        rnd2exp=torch.pow(2,torch.floor(torch.where(aabs==0.0,aabs,torch.log2(aabs)))) # get back the old value rounded to 2 exp
        # SSY BF16 
        # return  torch.mul(torch.mul(torch.div(torch.floor(torch.mul(torch.div(aabs,rnd2exp),256)),256),rnd2exp),torch.sign(xmlp))
        # SSY BF12
        return  torch.mul(torch.mul(torch.div(torch.floor(torch.mul(torch.div(aabs,rnd2exp),16)),16),rnd2exp),torch.sign(xmlp))

class bf16cutfp(Function):
    @staticmethod
    def forward(ctx, tensor):
        return float2bf16(tensor)

    @staticmethod
    def backward(ctx, grad_output):
        return grad_output

class bf16cutbp(Function):
    @staticmethod
    def forward(ctx, tensor):
        return tensor

    @staticmethod
    def backward(ctx, grad_output):
        return float2bf16(grad_output)

class bf16cutfp_mod(Module):
  def __init__(self):
    super(bf16cutfp_mod,self).__init__()

  def forward(self,input):
    return bf16cutfp.apply(input)

class bf16cutbp_mod(Module):
  def __init__(self):
    super(bf16cutbp_mod,self).__init__()

  def forward(self,input):
    return bf16cutbp.apply(input)
