ARG TARGET_BINTAG=manylinux2010_x86_64
FROM quay.io/pypa/${TARGET_BINTAG}

ARG OPENBLAS_BRANCH=v0.3.9
RUN git clone -b "${OPENBLAS_BRANCH}" https://github.com/xianyi/OpenBLAS /root/openblas
ARG NUMPY_BRANCH=v1.18.5
RUN git clone -b "${NUMPY_BRANCH}" https://github.com/numpy/numpy /root/numpy

RUN mkdir -p /root/objconv && \
    cd /root/objconv && \
    curl -O "https://raw.githubusercontent.com/MacPython/openblas-libs/master/objconv/source.zip" && \
    unzip source.zip && \
    g++ -O1 -o objconv *.cpp

WORKDIR /root/openblas
ENV CFLAGS=-Wl,-strip-all \
    CXXFLAGS=-Wl,-strip-all \
    FFLAGS=-Wl,-strip-all
RUN make DYNAMIC_ARCH=1 USE_OPENMP=0 NUM_THREADS=64 BINARY=64 INTERFACE64=1 SYMBOLSUFFIX=64_ OBJCONV=/root/objconv/objconv > /dev/null 2>&1 && \
    make PREFIX=/opt/OpenBLAS INTERFACE64=1 SYMBOLSUFFIX=64_ OBJCONV=/root/objconv/objconv install

ARG TARGET_BINTAG=manylinux2010_x86_64
ARG TARGET_PYTAG=cp36-cp36m

WORKDIR /root/numpy
RUN /opt/python/${TARGET_PYTAG}/bin/python -m venv /root/venv-testing
RUN source /root/venv-testing/bin/activate && \
    pip install -U pip setuptools wheel && \
    pip install -U pytest Cython
COPY numpy.site.cfg ./site.cfg
ENV LD_LIBRARY_PATH=/opt/OpenBLAS/lib:/usr/local/lib
RUN ls -l /opt/OpenBLAS/lib
RUN source /root/venv-testing/bin/activate && \
    NPY_USE_BLAS_ILP64=1 NPY_BLAS_ILP64_ORDER=openblas64_ NPY_LAPACK_ILP64_ORDER=openblas64_ pip wheel -w /root/wheels .
RUN for whl in /root/wheels/*.whl; do \
      auditwheel show "$whl"; \
      auditwheel repair "$whl" --plat "${TARGET_BINTAG}" -w /root/wheels/; \
    done; \
    ls -l /root/wheels

COPY entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]
