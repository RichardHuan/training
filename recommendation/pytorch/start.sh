# real run
#sudo nvidia-docker run -i -t --rm --ipc=host  --entrypoint "bash"   --mount "type=bind,source=$(pwd),destination=/mlperf/experiment"     mlperf/recommendation:v0.5 3
# just start into the vm and delete all result
#sudo nvidia-docker run -i -t --rm --ipc=host  --entrypoint "bash"   --mount "type=bind,source=$(pwd),destination=/mlperf/experiment"     mlperf/recommendation:v0.5

# get into vm , create a named container, and exit with saved result
sudo nvidia-docker run -i -t  --ipc=host  --entrypoint "bash"   --mount "type=bind,source=$(pwd),destination=/mlperf/experiment"  --name ssyNCF   mlperf/recommendation:v0.5 
sudo nvidia-docker start ssyNCF
nvidia-docker exec -it ssyNCF /bin/bash


