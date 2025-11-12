#!/bin/bash -l
#########################################################
#SBATCH -J track_halo_properties-no_progen

#SBATCH --mail-user=apadawer@uvic.ca
#SBATCH --mail-type=ALL
#SBATCH --account=rrg-babul-ad
#SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/slurm_files/slurm-%j.out
##SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/slurm_files/slurm-%j.out
#########################################################
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=192
#SBATCH --mem=0
#########################################################

##SBATCH --array=1-10%1 # Run a N-job array, 1 job at a time
#########################################################


# ---------------------------------------------------------------------
#echo "Current working directory: `pwd`"
#echo "Starting run at: `date`"
# ---------------------------------------------------------------------
#echo ""
#echo "Job Array ID / Job ID: $SLURM_ARRAY_JOB_ID / $SLURM_JOB_ID"
#echo "Job task $SLURM_ARRAY_TASK_ID / $SLURM_ARRAY_TASK_COUNT"
#echo ""
# ---------------------------------------------------------------------


module load StdEnv/2023 python/3.13

source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate


snap_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/
#/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/
snap_base=snapshot_
caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/
#/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/
caesar_base=caesar_
caesar_suffix=''

# Read target_snap_nums and target_halo_ids from file
progen_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/halo_progen_info_272
#/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/halo_progen_info_272
while IFS=$'\t' read -r -a line; do
    target_snap_nums+="${line[6]} "
    target_halo_ids+="${line[8]} "
done < $progen_file
# target_snap_nums=$(seq 53 1 272)
# target_halo_ids=

sim_model='Simba'

nproc=192
output_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/halo_0_props-v4
#/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/halo_0_props-v2
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
