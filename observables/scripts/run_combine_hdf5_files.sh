#!/bin/bash

module load StdEnv/2023 python/3.13
source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate

input_dir="/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/snap_props/v5"
output_file="${input_dir}/halo_0_props-v5.hdf5"
pattern="halo_0_props-snap_[53-272]*.hdf5"

echo "Combining HDF5 files..."
python combine_hdf5_files.py "${input_dir}/${pattern}" "${output_file}"

if [ $? -eq 0 ]; then
    echo "Successfully combined files into ${output_file}"
else
    echo "Error combining files"
    exit 1
fi