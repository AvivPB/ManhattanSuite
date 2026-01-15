#!/bin/bash -l

module load StdEnv/2023 python/3.13
source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate



output_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00009/Groups/snap_props/v1/halo_0_props-v1
# /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00009/halo00009/output/Groups/snap_props/v1/halo_0_props-v1
# /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/snap_props/v1/halo_0_props-v1
# /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/snap_props/v5/halo_0_props-v5
# clear_output_file=--clear_output_file

halo_types=halo
central_types=central
sim_model='Simba'
mgas=5e6 # L1
# 3.5e7 # L0
mgas_units='Msun'




echo
echo 'CALCULATING HALO PROPERTIES'
echo

python calc_extra_halo_properties-hdf5.py --output_file=$output_file.hdf5 --sim_model=$sim_model --halo_types=$halo_types --central_types=$central_types --mgas=$mgas --mgas_units=$mgas_units

echo
echo 'done'

########################################################
