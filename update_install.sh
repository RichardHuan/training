apt-get update -o Acquire::https::developer.download.nvidia.com::Verify-Peer=false
apt install -y vim  python-setuptools  python-pip python3-pip virtualenv htop  libcupti-dev
ln -s /usr/lib/x86_64-linux-gnu/libcupti.so.7.5.18 /usr/lib/x86_64-linux-gnu/libcupti.so.10.0

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install numpy scipy sklearn tf-nightly-gpu
pip3 install "tensorflow-gpu==1.15.0"
