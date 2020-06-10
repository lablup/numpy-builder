import os
from pathlib import Path
import shutil

import matplotlib.pyplot as plt
import numpy as np

os.system('pip list')
print(f"numpy version: {np.__version__}")
np.show_config()
print(f"cpu count: {os.cpu_count()}")
print(f"affinity mask: {os.sched_getaffinity(0)}")
plt.scatter([1], [3])
print("pass")

if Path('/io').is_dir():
    for whl in Path('/root/wheels').glob('*manylinux*.whl'):
        print(f"copied {whl} to the host directory mounted at /io")
        shutil.copy(whl, '/io')
