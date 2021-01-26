#!/bin/bash

source $HOME/miniconda3/etc/profile.d/conda.sh

if [ "$#" -ne 1 ]; then
	echo "Usage: add_kernel <KERNEL_NAME>"
	exit 0;
fi;

export ENV_NAME="$1"

conda create -y -n $ENV_NAME ipykernel
source activate $ENV_NAME
python -m ipykernel install --user --name $ENV_NAME
jupyter --paths > /dev/null
echo "Kernel $ENV_NAME installed!"
