#!/bin/bash -l

module load StdEnv/2023 python/3.13

source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate


snap_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/
snap_base=snapshot_
caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/
caesar_base=caesar_
caesar_suffix=''

# Read target_snap_nums and target_halo_ids from file
progen_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/halo_progen_info_272
while IFS=$'\t' read -r -a line; do
    target_snap_nums+="${line[6]} "
    target_halo_ids+="${line[8]} "
done < $progen_file
# target_snap_nums=$(seq 53 1 272)
# target_halo_ids=

sim_model='Simba'

nproc=1
output_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/halo_0_props-v5
clear_output_file=--clear_output_file


echo target_snap_nums:
echo $target_snap_nums
echo

echo target_halo_ids:
echo $target_halo_ids
echo


echo
echo 'CALCULATING HALO PROPERTIES'
echo

python track_halo_properties-hdf5-no_progen.py --snap_dir=$snap_dir --snap_base=$snap_base --caesar_dir=$caesar_dir --caesar_base=$caesar_base --caesar_suffix=$caesar_suffix --target_snap_nums $target_snap_nums --target_halo_ids $target_halo_ids --sim_model=$sim_model --nproc=$nproc --output_file=$output_file.hdf5 $clear_output_file #> $output_file.out

echo
echo 'done'

########################################################
