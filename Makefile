BASE_BINTAG := manylinux2010_x86_64
OPENBLAS_BRANCH := v0.3.9
NUMPY_BRANCH := v1.18.5

all: py36 py37 py38

py36: BASE_PYTAG := cp36-cp36m
py36:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg OPENBLAS_BRANCH=${OPENBLAS_BRANCH} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  -t numpy-builder:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  --build-arg PYTHON_VERSION=3.6 \
	  -t numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker run --rm -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG}

py37: BASE_PYTAG := cp37-cp37m
py37:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg OPENBLAS_BRANCH=${OPENBLAS_BRANCH} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  -t numpy-builder:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  --build-arg PYTHON_VERSION=3.7 \
	  -t numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker run --rm -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG}

py38: BASE_PYTAG := cp38-cp38
py38:
	docker build \
	  -f builder.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg OPENBLAS_BRANCH=${OPENBLAS_BRANCH} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  -t numpy-builder:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker build \
	  -f tester.Dockerfile \
	  --build-arg TARGET_BINTAG=${BASE_BINTAG} \
	  --build-arg TARGET_PYTAG=${BASE_PYTAG} \
	  --build-arg NUMPY_BRANCH=${NUMPY_BRANCH} \
	  --build-arg PYTHON_VERSION=3.8 \
	  -t numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG} .
	docker run --rm -v $(shell pwd):/io \
	  --cpuset-cpus=2-3 \
	  -e LD_PRELOAD=/io/libbaihook.ubuntu16.04.x86_64.so \
	  numpy-tester:${NUMPY_BRANCH}-${BASE_PYTAG}-${BASE_BINTAG}

.PHONY: all py36 py37 py38
