# numpy-builder
A numpy custom builder for our purpose

This is motivated by [numpy/numpy#16533](https://github.com/numpy/numpy/issues/16533)
where we discovered that manylinux1 builds are faulty under dockerized, CPU-constrained setups.


## How to use

Build manylinux2010-based self-contained numpy wheel packages for Python 3.6, 3.7, and 3.8:
```console
make
```

For individual Python versions,
```console
make py36
make py37
make py38
```
