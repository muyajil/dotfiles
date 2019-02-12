#!/bin/bash
current_dir=$(pwd)
bash_config_path=$current_dir/bash_prompt.sh
echo "source $bash_config_path" >> ~/.bashrc

wget https://bootstrap.pypa.io/get_pip.py
python3 get_pip.py

sudo -H pip3 install pipenv jupyter jupyter_contrib_nbextensions jupyter_nbextensions_configurator

sudo jupyter contrib nbextension install
sudo jupyter nbextensions_configurator enable
sudo jupyter nbextension enable hinterland/hinterland
sudo jupyter nbextension enable codefolding/main

sudo apt install git-core gcloud kubectl remmina python3-dev
