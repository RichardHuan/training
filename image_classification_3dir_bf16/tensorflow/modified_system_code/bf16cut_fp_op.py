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

if is_built_with_cuda():
  _cuda_op_module = load_op_library(os.path.join(
      get_data_files_path(), 'bf16cut_fp.so'))
  #Bf16cutFp must be a camel naming style
  # and when I invoke it in python, I need to seperate cammel head with _
  bf16cut_fp = _cuda_op_module.bf16cut_fp
