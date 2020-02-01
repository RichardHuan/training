import tensorflow as tf
from tensorflow.python.framework import ops
import numpy as np
#from bf import *

def bf16cut_tf(xmlp):
  return xmlp

def bf16cut_tf_(xmlp):
  print("xmlp bf16cut_tf "+str(xmlp))
  ssign=tf.sign(xmlp)
  aabs=tf.abs(xmlp)
  a=tf.where(tf.equal(aabs,0.0),aabs,tf.divide(tf.log(aabs),tf.log(2.0)))
  b_exp=tf.floor(a) # exp value
  rnd2exp=tf.pow(2.0,b_exp) # get back the old value rounded to 2 exp
  mantis=tf.divide(aabs,rnd2exp) # mantis
  print("mantis "+str(mantis))
  m256=tf.multiply(mantis,256.0)
  f256=tf.floor(m256)
  d256=tf.divide(f256,256.0)
  res=tf.multiply(d256,rnd2exp)
  res1= tf.multiply(res,ssign)
  print("res1 bf16cut_tf "+str(res1))
  print("res1 shape bf16cut_tf "+str(res1.shape))
  return res1

def bf16cut_np(xmlp):
  return xmlp

def bf16cut_np_(xmlp):
  print("xmlp bf16cut_np "+str(xmlp))
  ssign=np.sign(xmlp)
  aabs=np.abs(xmlp)
  #a=np.divide(np.log(aabs),np.log(2.0))
  a=np.where(aabs==0.0,0.0,np.log2(aabs))
  print("a bf16cut_np "+str(a))
  b_exp=np.floor(a) # exp value
  rnd2exp=np.power(2.0,b_exp) # get back the old value rounded to 2 exp
  mantis=np.divide(aabs,rnd2exp) # mantis
  print("mantis "+str(mantis))
  m256=np.multiply(mantis,256.0)
  f256=np.floor(m256)
  d256=np.divide(f256,256.0)
  res=np.multiply(d256,rnd2exp)
  res1= np.multiply(res,ssign)
  print("res1 bf16cut_np "+str(res1))
  print("res1 shape bf16cut_np "+str(res1.shape))
  return res1

# Define custom py_func which takes also a grad op as argument:
def py_func(func, inp, Tout, stateful=True, name=None, grad=None):
    
    # Need to generate a unique name to avoid duplicates:
    rnd_name = 'PyFuncGrad' + str(np.random.randint(0, 1E+8))
    
    tf.RegisterGradient(rnd_name)(grad)  # see id_bf16cut_grad for grad example
    g = tf.get_default_graph()
    with g.gradient_override_map({"PyFunc": rnd_name}):
        return tf.py_func(func, inp, Tout, stateful=stateful, name=name)

# Def custom square function using np.square instead of tf.square:
def id_bf16cut(x, name=None):
    
    with ops.op_scope([x], name, "Mysquare") as name:
        #sqr_x = py_func(np.square,
        sqr_x = py_func(bf16cut_np, # must use np version orelse will rise unsupport  data type
                        [x],
                        [tf.float32],
                        name=name,
                        grad=id_bf16cut_grad)  # <-- here's the call to the gradient
        return sqr_x[0]

# Actual gradient:
def id_bf16cut_grad(op, grad):
    x = op.inputs[0]
    # must use tf version or else rise no xla compiler error
    return bf16cut_tf(grad )  # add a "small" error just to see the difference:
    #return grad *  x  # add a "small" error just to see the difference:

if __name__ == "__main__":
  with tf.Session() as sess:
    x = tf.constant([0,0,1.123456789, 11.123456789,111.123456789,-1.123456789,-11.123456789,-111.123456789],shape=[2,4])
    y = id_bf16cut(x)
    tf.initialize_all_variables().run()

    print(x.eval())
    print(y.eval())
    print(tf.gradients(y, x)[0].eval())
