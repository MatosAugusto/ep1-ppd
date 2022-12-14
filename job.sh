#!/bin/bash
#SBATCH -J pi                       #Job name
#SBATCH -p fast                     #Job partition
#SBATCH -n 1                        #Number of processes
#SBATCH -t 01:30:00                 #Run time (hh:mm:ss)
#SBATCH --cpus-per-task=40          #Number of cpus per process
#SBATCH --output=%x.%j.out         #Name of stdout output file - %j expands to jobId e %x to jobName
#SBATCH --error=%x.%j.err          #Name of stderr ouutput file

echo "* SEQUENTIAL *"
srun singularity run container.sif pi_seq 1000000000



echo "* PTHREAD *"
srun singularity run container.sif pi_pth 1000000000 1
srun singularity run container.sif pi_pth 1000000000 2
srun singularity run container.sif pi_pth 1000000000 5
srun singularity run container.sif pi_pth 1000000000 10
srun singularity run container.sif pi_pth 1000000000 20
srun singularity run container.sif pi_pth 1000000000 40


echo "* OPENMP *"
export OMP_NUM_THREADS=1
srun singularity run container.sif pi_omp 1000000000

export OMP_NUM_THREADS=2
srun singularity run container.sif pi_omp 1000000000

export OMP_NUM_THREADS=5
srun singularity run container.sif pi_omp 1000000000

export OMP_NUM_THREADS=10
srun singularity run container.sif pi_omp 1000000000

export OMP_NUM_THREADS=20
srun singularity run container.sif pi_omp 1000000000

export OMP_NUM_THREADS=40
srun singularity run container.sif pi_omp 1000000000
