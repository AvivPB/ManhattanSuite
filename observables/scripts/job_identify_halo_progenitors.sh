#!/bin/bash -l
#########################################################
#SBATCH -J identify_halo_progenitors

#SBATCH --mail-user=apadawer@uvic.ca
#SBATCH --mail-type=ALL
#SBATCH --account=rrg-babul-ad
#SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00009/halo00009/output/Groups/slurm_files/slurm-%j.out
##SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00009/Groups/slurm_files/slurm-%j.out
#########################################################
#SBATCH --time=1:00:00
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


snap_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00009/halo00009/output
# /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00009
snap_base=snapshot_

caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00009/halo00009/output/Groups
# echo $caesar_dir

caesar_base=caesar_
caesar_suffix=''

source_snap_nums=77
# target_snap_nums=$(seq 50 1 272)
source_halo_ids=0

n_most=1
nproc=192

output_file=$caesar_dir/halo_${source_halo_ids}_snap_${source_snap_nums}_progen_info
clear_output_file=--clear_output_file


echo
echo 'Identifying Progenitors'
echo

python identify_halo_progenitors.py --snap_dir=$snap_dir --snap_base=$snap_base --caesar_dir=$caesar_dir --caesar_base=$caesar_base --caesar_suffix=$caesar_suffix --source_snap_nums=$source_snap_nums --target_snap_nums {77..0} --source_halo_ids $source_halo_ids --n_most=$n_most --nproc=$nproc --output_file=$output_file $clear_output_file

echo
echo 'done'

########################################################
