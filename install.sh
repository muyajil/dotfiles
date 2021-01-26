#!/bin/bash
current_dir=$(pwd)

# Add scripts
sudo cp $current_dir/dcps.py /usr/local/bin/dcps
sudo cp $current_dir/save_env.sh /usr/local/bin/save-env
sudo cp $current_dir/c.sh /usr/local/bin/c
sudo cp $current_dir/add_kernel.sh /usr/local/bin/add-kernel

# Execute scripts in ~/.bashrc
bash_config_path=$current_dir/bash_prompt.sh
aliases_path=$current_dir/aliases.sh
paths_path=$current_dir/paths.sh
env_vars_path=$current_dir/env_vars.sh

echo "source $bash_config_path" >> ~/.bashrc
echo "source $aliases_path" >> ~/.bashrc
echo "source $paths_path" >> ~/.bashrc
echo "source $env_vars_path" >> ~/.bashrc

# Uninstall unnecessary things
sudo apt update
sudo apt remove libreoffice* firefox docker docker-engine docker.io containerd runc
sudo apt autoremove

# Install basic tools
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add Kubernetes repository
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main"

# Add Google Cloud SDK repository
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -cs) main"

# Update and install all needed packages
sudo apt update
sudo apt install -y \
    git-core \
    code \
    slack-desktop \
    google-chrome-stable \
    guake \
    htop \
    vlc \
    pkgconf \
    tlp \
    tlp-rdw \
    acpi-call-dkms \
    tp-smapi-dkms \
    acpi-call-dkms \
    google-cloud-sdk \
    kubectl \
    docker-ce \
    docker-ce-cli \
    containerd.io

# Docker Post Install
sudo usermod -aG docker $USER

# miniconda
curl -fsSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/miniconda.sh -b -p $HOME/miniconda3

# LatexDocker
sudo wget -O /usr/local/bin/latexdocker https://raw.githubusercontent.com/blang/latex-docker/master/latexdockercmd.sh
sudo chmod +x /usr/local/bin/latexdocker

# Kubectx & Kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
sudo ln -sf /opt/kubectx/completion/kubens.bash $COMPDIR/kubens
sudo ln -sf /opt/kubectx/completion/kubectx.bash $COMPDIR/kubectx

# Link configs
rm ~/.config/Code/User/settings.json || true
ln -s $current_dir/vs-code-settings.json ~/.config/Code/User/settings.json
ln -s $current_dir/ssh_config ~/.ssh/config
