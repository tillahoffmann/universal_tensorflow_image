.PHONY : image bash-cpu bash-gpu test test-cpu test-gpu

IMAGE = universal-tensorflow
CPU = docker run --rm -it $(IMAGE)
GPU = nvidia-docker run --rm -it $(IMAGE)

test : test-cpu test-gpu
	# Run all tests as dependencies

image : $(IMAGE)

$(IMAGE) :
	docker build -t $@ .

bash-cpu : $(IMAGE)
	$(CPU) bash

bash-gpu : $(IMAGE)
	$(GPU) bash

test-cpu : $(IMAGE)
	# Run the test script on the CPU
	! $(CPU) python3 test_tensorflow.py | grep GPU

test-gpu : $(IMAGE)
	# Run the test script on the GPU
	$(GPU) python3 test_tensorflow.py | grep GPU
