import tensorflow as tf
from tensorflow.python.framework import ops
import numpy as np
#from bf import *

#def bf16cut_tf(xmlp):
#  return xmlp

#def bf16cut_tf_(xmlp):
#  ssign=tf.sign(xmlp)
#  aabs=tf.abs(xmlp)
#  a=tf.where(tf.equal(aabs,0.0),aabs,
#     tf.divide(tf.log(aabs),tf.log(2.0)))
#  b_exp=tf.floor(a) # exp value
#  rnd2exp=tf.pow(2.0,b_exp) # get back the old value rounded to 2 exp
#  mantis=tf.divide(aabs,rnd2exp) # mantis
#  m256=tf.multiply(mantis,256.0)
#  f256=tf.floor(m256)
#  d256=tf.divide(f256,256.0)
#  res=tf.multiply(d256,rnd2exp)
#  res1= tf.multiply(res,ssign)
#  return res1
#
#def bf16cut_np_(xmlp):
#  ssign=np.sign(xmlp)
#  aabs=np.abs(xmlp)
#  a=np.where(aabs==0.0,0.0,np.log2(aabs))
#  b_exp=np.floor(a) # exp value
#  rnd2exp=np.power(2.0,b_exp) # get back the old value rounded to 2 exp
#  mantis=np.divide(aabs,rnd2exp) # mantis
#  m256=np.multiply(mantis,256.0)
#  f256=np.floor(m256)
#  d256=np.divide(f256,256.0)
#  res=np.multiply(d256,rnd2exp)
#  res1= np.multiply(res,ssign)
#  return res1

def bf16cut_np(xmlp):
  fp32a = np.asarray(xmlp,dtype=np.float32)
  bits = fp32a.view(np.int32)
  # for bf16 8 bit mantis
  b = np.left_shift(np.right_shift(bits,15),15)
  # for bf12 4 bit mantis
  #b = np.left_shift(np.right_shift(bits,19),19)
  # for bf10 2 bit mantis
  #b = np.left_shift(np.right_shift(bits,21),21)
  # for bf9 1 bit mantis
  #b = np.left_shift(np.right_shift(bits,22),22)
  # for bf8 0 bit mantis
  #b = np.left_shift(np.right_shift(bits,23),23)
  return b.view(np.float32)

def bf16cut_tf(xmlp):
  aabs=tf.abs(xmlp)
  rnd2exp=tf.pow(2.0,tf.floor(tf.where(tf.equal(aabs,0.0),aabs, tf.divide(tf.log(aabs),tf.log(2.0))))) # get back the old value rounded to 2 exp
  # for bf16 8 bit mantis
  return  tf.multiply(tf.multiply(tf.divide(tf.floor(tf.multiply(tf.divide(aabs,rnd2exp),256.0)),256.0),rnd2exp),tf.sign(xmlp))
  # for bf12 4 bit mantis
  #return  tf.multiply(tf.multiply(tf.divide(tf.floor(tf.multiply(tf.divide(aabs,rnd2exp),16.0)),16.0),rnd2exp),tf.sign(xmlp))
  # for bf10 2 bit mantis
  #return  tf.multiply(tf.multiply(tf.divide(tf.floor(tf.multiply(tf.divide(aabs,rnd2exp),4.0)),4.0),rnd2exp),tf.sign(xmlp))
  # for bf9 1 bit mantis
  #return  tf.multiply(tf.multiply(tf.divide(tf.floor(tf.multiply(tf.divide(aabs,rnd2exp),2.0)),2.0),rnd2exp),tf.sign(xmlp))
  # for bf8 0 bit mantis
  #return  tf.multiply(tf.multiply(tf.divide(tf.floor(tf.multiply(tf.divide(aabs,rnd2exp),1.0)),1.0),rnd2exp),tf.sign(xmlp))

#def bf16cut_np_merge(xmlp):
#  aabs=np.abs(xmlp)
#  rnd2exp=np.power(2.0,np.floor(np.where(aabs==0.0,0.0,np.log2(aabs)))) # get back the old value rounded to 2 exp
#  return np.multiply(np.multiply(np.divide(np.floor(np.multiply(np.divide(aabs,rnd2exp),256.0)),256.0),rnd2exp),np.sign(xmlp))


def id_ssy(xmlp):
  return xmlp

def id_ssy_grad(op,grad):
    x = op.inputs[0]
    return grad 

# Actual gradient:
def id_bf16cut_grad(op, grad):
    x = op.inputs[0]
    # must use tf version or else rise no xla compiler error
    return bf16cut_tf(grad )  # add a "small" error just to see the difference:
    #return grad *  x  # add a "small" error just to see the difference:

# Define custom py_func which takes also a grad op as argument:
def py_func(func, inp, Tout, stateful=True, name=None, grad=None):
    
    # Need to generate a unique name to avoid duplicates:
    rnd_name = 'PyFuncGrad' + str(np.random.randint(0, 1E+8))
    
    tf.RegisterGradient(rnd_name)(grad)  # see id_bf16cut_grad for grad example
    g = tf.get_default_graph()
    with g.gradient_override_map({"PyFunc": rnd_name}):
        return tf.py_func(func, inp, Tout, stateful=stateful, name=name)

def id_bf16cut_fp(x, name=None):
    
    with ops.op_scope([x], name, "id_bf16cut_fp") as name:
        #sqr_x = py_func(np.square,
        sqr_x = py_func(bf16cut_np, # must use np version orelse will rise unsupport  data type, change to id_ssy will be as fast as no custom oprator case, so np instead of H2D/D2H is the reason that slow down custom operator
                        [x],
                        [tf.float32],
                        name=name,
                        grad=id_ssy_grad)  # <-- here's the call to the gradient
        return sqr_x[0]

def id_bf16cut_bp(x, name=None):
    
    with ops.op_scope([x], name, "id_bf16cut_bp") as name:
        #sqr_x = py_func(np.square,
        sqr_x = py_func(id_ssy, # must use np version orelse will rise unsupport  data type
                        [x],
                        [tf.float32],
                        name=name,
                        grad=id_bf16cut_grad)  # <-- here's the call to the gradient
        return sqr_x[0]

if __name__ == "__main__":
  with tf.Session() as sess:
    x = tf.constant([0,0,1.123456789, 11.123456789,111.123456789,-1.123456789,-11.123456789,-111.123456789],shape=[2,4])
    y = id_bf16cut(x)
    tf.initialize_all_variables().run()

    print(x.eval())
    print(y.eval())
    print(tf.gradients(y, x)[0].eval())
