#!/bin/bash -l

# module load NiaEnv/2022a gcc/11.3.0 openssl/1.1.1k sqlite/3.35.5 hdf5/1.12.3
module load StdEnv/2023 python/3.13

source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate


snap_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/output
snap_base=snapshot_

caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/output/Groups
# echo $caesar_dir

caesar_base=caesar_
caesar_suffix=''

source_snap_nums=272
# target_snap_nums=$(seq 50 1 272)
source_halo_ids=0

n_most=1
nproc=1

output_file=$caesar_dir/halo_progen_info_${source_snap_nums}
clear_output_file=--clear_output_file


python identify_halo_progenitors.py --snap_dir=$snap_dir --snap_base=$snap_base --caesar_dir=$caesar_dir --caesar_base=$caesar_base --caesar_suffix=$caesar_suffix --source_snap_nums=$source_snap_nums --target_snap_nums {272..53} --source_halo_ids $source_halo_ids --n_most=$n_most --nproc=$nproc --output_file=$output_file $clear_output_file