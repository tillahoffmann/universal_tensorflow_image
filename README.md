# universal_tensorflow_image

Develop tensorflow models with or without a GPU accelerator using the same Docker image. 🥳

Use

* `docker build -t universal-tensorflow-image .` to build the image
* `docker run --rm --runtime=nvidia universal-tensorflow-image python3 test_tensorflow.py` to test tensorflow using the GPU
* `docker run --rm universal-tensorflow-image python3 test_tensorflow.py` to test tensorflow using the CPU

Note that the only difference between the CPU and GPU run is the runtime.

## Background

Docker images for tensorflow commonly come in [two flavours](https://hub.docker.com/r/tensorflow/tensorflow/#optional-features):

* one to develop on machines without a GPU accelerator, e.g. [`cpu.Dockerfile`](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/cpu.Dockerfile),
* and one to develop on machines with a GPU accelerator, e.g. [`gpu.Dockerfile`](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/gpu.Dockerfile).

Maintaining two images in parallel is both cumbersome and increases the risk of discrepancies between different runtime environments.

The [`Dockerfile`](https://github.com/tillahoffmann/universal_tensorflow_image/blob/master/Dockerfile) provides a universal setup so you can use the same image irrespective of whether you're using a GPU or not. It installs [`tensorflow-gpu`](https://pypi.org/project/tensorflow-gpu/) and [symlinks](https://en.wikipedia.org/wiki/Symbolic_link) the required CUDA library stubs to the location where tensorflow expects to find them. That means `tensorflow-gpu` can be used even if you start a container based on the image without using the [nvidia runtime](https://github.com/NVIDIA/nvidia-docker). When you use the nvidia runtime, the stubs are overwritten by the real libraries and you can access the GPU seamlessly.

You may want to stick to a setup with two different images if you care about the size of your images: the universal tensorflow image has the same size as the GPU image. The CPU image is substantially smaller.
