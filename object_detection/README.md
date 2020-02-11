# SSY

## build docker Dockerfile
nvidia-docker build . -t mlperf/object_detection

nvidia-docker run -it --ipc=host -v /root/ssy:/root/ssy --name ssyFRCNN mlperf/object_detection
nvidia-docker start ssyFRCNN
nvidia-docker exec -it ssyFRCNN /bin/bash

# build coco api
cd /root/ssy/
source /root/ssy/training/env.sh
git config --global http.sslVerify false

# this must be exec in host
git clone https://github.com/cocodataset/cocoapi.git \
 && cd cocoapi/PythonAPI \
 && git reset --hard ed842bffd41f6ff38707c4f0968d2cfd91088688

# back to docker
# build cocoapi
cd /root/ssy/cocoapi/PythonAPI/
python setup.py build_ext install
cd /root/ssy/training/object_detection/pytorch/

conda create --name maskrcnn_benchmark
source activate maskrcnn_benchmark

conda install ipython

pip install ninja yacs cython matplotlib

# build torchvision
# back to host 
cd /root/ssy/
git clone https://github.com/pytorch/vision.git
# back to docker
cd /root/ssy/vision
# only v0.2.2 work with pytorch 1.00
git checkout v0.2.2
python setup.py install

# build maskrcnn_benchmark
# back to host
cd /root/ssy/maskrcnn-benchmark/
git clone https://github.com/facebookresearch/maskrcnn-benchmark.git
# back to docker
python setup.py build develop  


# real run
cd /root/ssy/training/object_detection/pytorch/







# 1. Problem
Object detection and segmentation. Metrics are mask and box mAP.

# 2. Directions

### Steps to configure machine

1. Checkout the MLPerf repository
```
mkdir -p mlperf
cd mlperf
git clone https://github.com/mlperf/training.git
```
2. Install CUDA and Docker
```
source training/install_cuda_docker.sh
```
3. Build the docker image for the object detection task
```
cd training/object_detection/
nvidia-docker build . -t mlperf/object_detection
```

4. Run docker container and install code
```
nvidia-docker run -v .:/workspace -t -i --rm --ipc=host mlperf/object_detection \
    "cd mlperf/training/object_detection && ./install.sh"
```
Now exit the docker container (Ctrl-D) to get back to your host.

### Steps to download data
```
# From training/object_detection/
source download_dataset.sh
```

### Steps to run benchmark.
```
nvidia-docker run -v .:/workspace -t -i --rm --ipc=host mlperf/object_detection \
    "cd mlperf/training/object_detection && ./run_and_time.sh"
```

# 3. Dataset/Environment
### Publication/Attribution
Microsoft COCO: Common Objects in Context

### Data preprocessing
Only horizontal flips are allowed.

### Training and test data separation
As provided by MS-COCO (2017 version).

### Training data order
Randomly.

### Test data order
Any order.

# 4. Model
### Publication/Attribution
He, Kaiming, et al. "Mask r-cnn." Computer Vision (ICCV), 2017 IEEE International Conference on.
IEEE, 2017.

We use a version of Mask R-CNN with a ResNet50 backbone.

### List of layers
Running the timing script will display a list of layers.

### Weight and bias initialization
The ResNet50 base must be loaded from the provided weights. They may be quantized.

### Loss function
Multi-task loss (classification, box, mask). Described in the Mask R-CNN paper.

Classification: Smooth L1 loss

Box: Log loss for true class.

Mask: per-pixel sigmoid, average binary cross-entropy loss.

### Optimizer
Momentum SGD. Weight decay of 0.0001, momentum of 0.9.

# 5. Quality
### Quality metric
As Mask R-CNN can provide both boxes and masks, we evaluate on both box and mask mAP.

### Quality target
Box mAP of 0.377, mask mAP of 0.339

### Evaluation frequency
Once per epoch, 118k.

### Evaluation thoroughness
Evaluate over the entire validation set. Use the official COCO API to compute mAP.
