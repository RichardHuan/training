# over write the tensorflow
cp core.py /usr/local/lib/python3.5/dist-packages/tensorflow_core/python/keras/layers/core.py
cp /root/ssy/tensorflow_1.15.2/tensorflow/tensorflow/examples/adding_an_op/bf16*.so /usr/local/lib/python3.5/dist-packages/tensorflow_core/python/keras/layers/
cp /root/ssy/tensorflow_1.15.2/tensorflow/tensorflow/examples/adding_an_op/bf16*.py /usr/local/lib/python3.5/dist-packages/tensorflow_core/python/keras/layers/
cp ./bf16*.py /usr/local/lib/python3.5/dist-packages/tensorflow_core/python/keras/layers/
# over write bert code with pgrad
cp attention_layer.py /root/ssy/training/translation/tensorflow/transformer/model/
cp embedding_layer.py /root/ssy/training/translation/tensorflow/transformer/model/
#cp pgrad.py           /root/ssy/training/translation/tensorflow/transformer/model/
