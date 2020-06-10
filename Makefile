all: py36 py37 py38

py36:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp36-cp36m \
	  --build-arg OPENBLAS_BRANCH=v0.3.9 \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  -t numpy-builder:v1.18.5-cp36-cp36m-manylinux2010_x86_64 .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp36-cp36m \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  --build-arg PYTHON_VERSION=3.6 \
	  -t numpy-tester:v1.18.5-cp36-cp36m-manylinux2010_x86_64 .
	docker run -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:v1.18.5-cp36-cp36m-manylinux2010_x86_64

py37:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp37-cp37m \
	  --build-arg OPENBLAS_BRANCH=v0.3.9 \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  -t numpy-builder:v1.18.5-cp37-cp37m-manylinux2010_x86_64 .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp37-cp37m \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  --build-arg PYTHON_VERSION=3.7 \
	  -t numpy-tester:v1.18.5-cp37-cp37m-manylinux2010_x86_64 .
	docker run -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:v1.18.5-cp37-cp37m-manylinux2010_x86_64

py38:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp38-cp38 \
	  --build-arg OPENBLAS_BRANCH=v0.3.9 \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  -t numpy-builder:v1.18.5-cp38-cp38-manylinux2010_x86_64 .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=manylinux2010_x86_64 \
	  --build-arg TARGET_PYTAG=cp38-cp38 \
	  --build-arg NUMPY_BRANCH=v1.18.5 \
	  --build-arg PYTHON_VERSION=3.8 \
	  -t numpy-tester:v1.18.5-cp38-cp38-manylinux2010_x86_64 .
	docker run -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:v1.18.5-cp38-cp38-manylinux2010_x86_64
