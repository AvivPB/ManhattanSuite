#!/bin/bash -l

# Read target_snap_nums and target_halo_ids from file
progen_file=/scratch/aspadawe/snapshots/ManhattanSuite/Simba/simba_9Rvir_1x/halo00000/halo00000/Groups/halo_progen_info_272
while IFS=$'\t' read -r -a line; do
    target_snap_nums_list+="${line[6]} "
    target_halo_ids_list+="${line[8]} "
done < $progen_file

echo $target_snap_nums_list
echo
echo $target_halo_ids_list
echo


val=62
# Convert space-separated lists into arrays
IFS=' ' read -r -a snap_nums_array <<< "$target_snap_nums_list"
IFS=' ' read -r -a halo_ids_array <<< "$target_halo_ids_list"

# Find index of val in snap_nums_array
for i in "${!snap_nums_array[@]}"; do
   if [[ "${snap_nums_array[$i]}" = "${val}" ]]; then
       target_halo_ids="${halo_ids_array[$i]}"
       break
   fi
done

echo $target_halo_ids
