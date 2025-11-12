#!/bin/bash -l
#########################################################
#SBATCH -J combine_hdf5_files

#SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/slurm_files/snap_props/v5/slurm-%j.out
##SBATCH -o /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00000/Groups/slurm_files/slurm-%j.out

#SBATCH --mail-user=apadawer@uvic.ca
#SBATCH --mail-type=ALL
#SBATCH --account=rrg-babul-ad
#########################################################
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=192
#SBATCH --mem=0
#########################################################

##SBATCH --array=53-272 # Run a N-job array, all simultaneously

#########################################################

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