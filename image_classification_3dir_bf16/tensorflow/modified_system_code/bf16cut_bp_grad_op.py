# Copyright 2015 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
"""Cuda op Python library."""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import os.path

#import tensorflow as tf
from tensorflow.python.platform.test import is_built_with_cuda
from tensorflow.python.framework.load_library import load_op_library
from tensorflow.python.platform.resource_loader import get_data_files_path

# https://davidstutz.de/implementing-tensorflow-operations-in-c-including-gradients/
# I dont need to do anything here, just pass the gradient
from tensorflow.python.framework import ops
from tensorflow.python.ops import array_ops
from tensorflow.python.ops import sparse_ops


if is_built_with_cuda():
   bf16cut_bp_grad_Op_lib = load_op_library(os.path.join(
      get_data_files_path(), 'bf16cut_bp_grad.so'))

@ops.RegisterGradient("Bf16cutBp")
def bf16cut_bp_grad_Op(op, grad):
    """
    The gradient for `inner_product` using the operation implemented in C++.
    
    :param op: `inner_product` `Operation` that we are differentiating, which we can use
        to find the inputs and outputs of the original op.
    :param grad: gradient with respect to the output of the `inner_product` op.
    :return: gradients with respect to the input of `inner_product`.
    """
    # pass to compute function of cc file, whcih will unzip them in correct number, here I only need the grad
    return bf16cut_bp_grad_Op_lib.bf16cut_bp_grad(grad)
    return grad
