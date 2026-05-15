#!/bin/bash
#SBATCH -N30 --ntasks-per-node=128 -t 168:00:00 --job-name="design_four_helix_bundle" --constraint=rome --partition=ccb --export=ALL

source ~/load_my_modules.sh
source ~/masala_workingcopy/set_up_masala.sh

export OMP_NUM_THREADS=4

export PATH_TO_ROSETTA_BIN=/mnt/home/vmulligan/rosetta_git_workingcopy/Rosetta/main/source/bin/
export ROSETTA_EXTENSION=linuxgccrelease
#export ROSETTAQM_DIRECTORY=/mnt/home/vmulligan/ceph/2023_11_21_rosettaqm_mainchain_potentials/ala/ala_tendegree_mp2_6-311++Gstarstar_pcm_simple_geoopt_hf3c/gamess_comm/
export ROSETTAQM_DIRECTORY=/dev/shm/
export GMS_PATH=/mnt/home/vmulligan/GAMESS/gamess_openmp_2023_09/
export GMS_EXE_VERSION=00
export GAMESS_THREADS=4
export GAMESS_MEMORY=8192
export ROSETTA_THREADS=16
#export GMS_SCRATCH=/mnt/home/vmulligan/ceph/2023_11_21_rosettaqm_mainchain_potentials/ala/ala_tendegree_mp2_6-311++Gstarstar_pcm_simple_geoopt_hf3c/gamess_scratch/
#export GMS_SCRATCH=/scratch/
export GMS_SCRATCH=/dev/shm/

#mpirun -np 2 -N 2 --bind-to none --oversubscribe $PATH_TO_ROSETTA_BIN/rosetta_scripts.cxx11threadmpiserialization.$ROSETTA_EXTENSION @inputs/rosetta2.flags -rosetta_GAMESS_bridge_temp_directory $ROSETTAQM_DIRECTORY -GAMESS_path=$GMS_PATH -GAMESS_executable_version=$GMS_EXE_VERSION -GAMESS_threads $GAMESS_THREADS -GAMESS_memory_megabytes $GAMESS_MEMORY -clean_rosetta_GAMESS_bridge_temp_directory true -multithreading:total_threads $ROSETTA_THREADS >out.log 2>err.log && echo "JOB COMPLETED!"
mpirun -np 960 -N 32 --bind-to none --oversubscribe $PATH_TO_ROSETTA_BIN/rosetta_scripts.cxx11threadmpiserialization.$ROSETTA_EXTENSION @inputs/rosetta.flags -rosetta_GAMESS_bridge_temp_directory $ROSETTAQM_DIRECTORY -GAMESS_path=$GMS_PATH -GAMESS_executable_version=$GMS_EXE_VERSION -GAMESS_threads $GAMESS_THREADS -GAMESS_memory_megabytes $GAMESS_MEMORY -clean_rosetta_GAMESS_bridge_temp_directory true -multithreading:total_threads $ROSETTA_THREADS >out.log 2>err.log && echo "JOB COMPLETED!"
