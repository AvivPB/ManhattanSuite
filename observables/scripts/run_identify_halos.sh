#!/bin/bash -l

module load StdEnv/2023 python/3.13
source /scratch/aspadawe/manhattan_suite/observables/pyenvs/mansuite-obs/bin/activate

caesar_dir=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00009/halo00009/output/Groups
# /scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_8x/halo00009/Groups
echo $caesar_dir

snap_nums=77
caesar_base=caesar_
caesar_suffix=''

output_file=$caesar_dir/halo_info-snap_${snap_nums}
clear_output_file=--clear_output_file
echo $output_file

target_property=m500c
domain='inside'
target_value_min=1e13
target_value_max=1e17
target_units=Msun

use_contamination=--no-use_contamination
contamination_min=0
contamination_max=0


python identify_halos.py --caesar_dir=$caesar_dir --snap_nums=$snap_nums --caesar_base=$caesar_base --caesar_suffix=$caesar_suffix --output_file=$output_file $clear_output_file --target_property=$target_property --domain=$domain --target_value_min=$target_value_min --target_value_max=$target_value_max --target_units=$target_units $use_contamination --contamination_min=$contamination_min --contamination_max=$contamination_max



########################################################

# main_dir=/scratch/b/babul/aspadawe/snapshots/HyenasC/L0/SimbaC_L1_Calibration/
# sub_dir=halo_3224_og_good/
# #halo_*/
# caesar_dir=caesar_fof/

# # DIRS=$(find $main_dir -type d)

# # --caesar_base=Caesar_$(basename $dir)_

# for dir in $main_dir$sub_dir; do

#         echo $dir
#         echo $(basename $dir)
#         echo

#         /scratch/b/babul/rennehan/for_aviv/python-3.13.5/bin/python identify_halos.py --caesar_dir=$dir$caesar_dir --snap_nums=151 --caesar_base=caesar_ --output_file=/project/b/babul/aspadawe/snapshots/Hyenas/L1/halo_3224/caesar_fof/halo_info --no-clear_output_file --target_property=m500c --target_value_min=1e12 --target_value_max=1e15 --target_units=Msun --use_contamination --contamination_min=0 --contamination_max=0

#         echo
#         echo
# done

# echo 'done'

########################################################
