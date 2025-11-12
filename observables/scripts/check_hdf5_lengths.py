import h5py, glob, os, sys
from collections import defaultdict
from pprint import pprint

files = sorted(glob.glob("/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/snap_props/v5/halo_0_props-snap_*-v5.hdf5"))
bad = []
for fname in files:
    with h5py.File(fname,'r') as f:
        for gname in f.keys():
            if not isinstance(f[gname], h5py.Group):
                continue
            lens = {}
            for dname, obj in f[gname].items():
                if isinstance(obj, h5py.Dataset):
                    lens[dname] = obj.shape[0] if obj.shape else 1
            if lens and len(set(lens.values())) > 1:
                bad.append((os.path.basename(fname), gname, lens))
for item in bad:
    pprint(item)
if not bad:
    print("No per-file per-group length inconsistencies found.")