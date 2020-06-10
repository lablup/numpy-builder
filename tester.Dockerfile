ARG TARGET_BINTAG=manylinux2010_x86_64
ARG TARGET_PYTAG=cp36-cp36m
ARG NUMPY_BRANCH=v1.18.5
ARG PYTHON_VERSION=3.6
FROM numpy-builder:${NUMPY_BRANCH}-${TARGET_PYTAG}-${TARGET_BINTAG} AS builder

ARG PYTHON_VERSION=3.6
FROM python:${PYTHON_VERSION}

RUN pip install -U pip setuptools
COPY --from=builder /root/wheels/*.whl /root/wheels/
RUN pip install --no-index --find-links=/root/wheels numpy
RUN pip install -U matplotlib

COPY test.py /root/test.py
CMD [ "python", "/root/test.py" ]
