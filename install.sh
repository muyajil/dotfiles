#!/bin/bash
current_dir=$(pwd)
bash_config_path=$current_dir/bash_prompt.sh
echo "source $bash_config_path" >> ~/.bashrc
echo "alias jn=\"jupyter notebook\"" >> ~/.bashrc
echo "source <(kubectl completion bash)" >> ~/.bashrc

sudo apt update
sudo apt install -y git-core python3-dev

wget https://bootstrap.pypa.io/get-pip.py -O ./get-pip.py
python3 ./get-pip.py

sudo -H pip3 install pipenv jupyter jupyter_contrib_nbextensions jupyter_nbextensions_configurator

sudo jupyter contrib nbextension install
sudo jupyter nbextensions_configurator enable
sudo jupyter nbextension enable hinterland/hinterland
sudo jupyter nbextension enable codefolding/main

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
ln -sf /opt/kubectx/completion/kubens.bash $COMPDIR/kubens
ln -sf /opt/kubectx/completion/kubectx.bash $COMPDIR/kubectx
echo "export PATH=/opt/kubectx:\$PATH" >> ~/.bashrc

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt update
sudo apt install -y google-cloud-sdk remmina code guake kubectl htop texmaker
