import tensorflow as tf
zero_out_module = tf.load_op_library('./zero_out_op_kernel_1.so')
with tf.Session(''):
  a=zero_out_module.zero_out([[1, 2], [3, 4]]).eval()
  print(a)

# Prints
#array([[1, 0], [0, 0]], dtype=int32)
