# Singularity Container and Docker
Singularity has an interface to import Docker images. That is the reason why we can easily import our existing docker images and run them on the HPC.
# Importing a Docker image
First of all, we should check that our docker image has been pushed to a registry e.g. the gitlab container registry. Then we can download and convert the docker image in a singularity image with the following command:

> Use the parameter --docker-login if the registry is a private one

```
$ singularity pull docker://registry.project-gitlab.ztt.hs-worms.de/pct-ml/simulation-environment
```

A new file, which is the container image, has been created in the current directory.

# Run a singularity container
```
$ singularity run -B /work/HSWO-SIVERT/simulation-output:/output simulation-environment_latest.sif [container-inside-parameters]
```
# HPC Script for SLURM

```
#!/bin/bash
#SBATCH --account=HSWO-SIVERT
#SBATCH -J GateSimulation
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -o logs/GateSimulation-%j.out
#SBATCH -e logs/GateSimulation-%j.err
#SBATCH -t 10
#SBATCH --mail-type=BEGIN,END

echo "Executing on $HOSTNAME"

singularity run -B /work/HSWO-SIVERT/simulation-output:/output simulation-environment_latest.sif -dt -swp -p 100

echo "End of job"
```

# Debug helps
```
# Open a shell
$ singularity shell simulation-environment_latest.sif
# Executing a command
$ singularity exec simulation-environment_latest.sif echo Hello World!
# Mount a folder in the container (works with shell/exec/run/?)
$ singularity shell -B /work/HSWO-SIVERT/simulation-output:/output simulation-environment_latest.sifl
```


# Helpful links
https://sylabs.io/guides/3.0/user-guide/singularity_and_docker.html


# Access a private repo example
To pull from a private docker repo first delete the old image then pull the new one
```
$ rm simulation-environment_latest.sif
$ singularity pull --docker-login docker://registry.project-gitlab.ztt.hs-worms.de/pct-ml/simulation-environment
# As user name and password a deployment token can be used:
#   -> Settings -> Repository -> Deploy Tokens
# Please make a check by read_registry that the "token" has access to the container image.
```
