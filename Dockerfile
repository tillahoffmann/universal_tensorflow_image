FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Set up python
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install python
RUN pip3 install --no-cache-dir setuptools \
    && pip3 install --no-cache-dir tensorflow-gpu

# Symlink the stub to the version tensorflow is looking for
# and add the stubs directory to the search path
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig

# Copy the test file
COPY test_tensorflow.py .
