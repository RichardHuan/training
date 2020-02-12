apt install -y python3-dev python3-pip
pip install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
pip install -U --user keras_applications --no-deps
pip install -U --user keras_preprocessing --no-deps

# install bazel
wget https://github.com/bazelbuild/bazel/releases/download/0.26.1/bazel-0.26.1-installer-linux-x86_64.sh
chmod a+x /root/ssy/training/bazel-0.26.1-installer-linux-x86_64.sh
/root/ssy/training/bazel-0.26.1-installer-linux-x86_64.sh

# check out tf 1.15.2
cd /root/ssy/tensorflow_1.15.2/
git clone https://github.com/tensorflow/tensorflow
cd tensorflow
git checkout v1.15.2



