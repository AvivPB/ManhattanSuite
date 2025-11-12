#!/bin/bash -l
#########################################################
#SBATCH -J track_halo_properties

#SBATCH --mail-user=apadawer@uvic.ca
#SBATCH --mail-type=ALL
#SBATCH --account=rrg-babul-ad
#SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/slurm_files/slurm-%j.out
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

source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate


snap_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/
snap_base=snapshot_
caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/
caesar_base=caesar_
caesar_suffix=''
source_snap_num=272
target_snap_nums=$(seq 53 1 272)
source_halo_id=0
nproc=192
output_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/halo_"$source_halo_id"_props


echo target_snap_nums:
echo $target_snap_nums


echo
echo 'CALCULATING HALO PROPERTIES'
echo

python track_halo_properties-hdf5.py --snap_dir=$snap_dir --snap_base=$snap_base --caesar_dir=$caesar_dir --caesar_base=$caesar_base --caesar_suffix=$caesar_suffix --source_snap_num=$source_snap_num --target_snap_nums $target_snap_nums --source_halo_id=$source_halo_id --nproc=$nproc --output_file=$output_file.hdf5 --clear_output_file #> $output_file.out

echo
echo 'done'

########################################################
