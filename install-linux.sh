#!/bin/bash
current_dir=$(pwd)

# Add scripts
read -p "Press enter to execute next step: Add scripts to /usr/local/bin..."
sudo cp $current_dir/dcps.py /usr/local/bin/dcps
sudo cp $current_dir/save_env.sh /usr/local/bin/save-env
sudo cp $current_dir/c.sh /usr/local/bin/c
sudo cp $current_dir/add-kernel.sh /usr/local/bin/add-kernel
sudo cp $current_dir/conda-pip-install.sh /usr/local/bin/conda-pip-install


# Execute scripts in ~/.bashrc
read -p "Press enter to execute next step: Source configs in ~/.bashrc..."
if ! grep -q dotfile "$HOME/.bashrc"; then
    bash_config_path=$current_dir/bash_prompt.sh
    aliases_path=$current_dir/aliases.sh
    paths_path=$current_dir/paths.sh
    env_vars_path=$current_dir/env_vars.sh

    echo "# source dotfile scripts" >> ~/.bashrc
    echo "source $bash_config_path" >> ~/.bashrc
    echo "source $aliases_path" >> ~/.bashrc
    echo "source $paths_path" >> ~/.bashrc
    echo "source $env_vars_path" >> ~/.bashrc
fi

# Uninstall unnecessary things
read -p "Press enter to execute next step: Uninstall unneeded packages..."
pkgToRemoveListFull="libreoffice-base \
    libreoffice-base-core \
    libreoffice-calc \
    libreoffice-draw \
    libreoffice-gnome \
    libreoffice-gtk \
    libreoffice-help-en-us \
    libreoffice-impress \
    libreoffice-math \
    libreoffice-ogltrans \
    libreoffice-pdfimport \
    libreoffice-presentation-minimizer \
    libreoffice-writer \
    python3-uno \
    firefox \
    thunderbird \
    docker \
    docker-engine \
    docker.io \
    containerd \
    runc \
    rhythmbox"
pkgToRemoveList=""
for pkgToRemove in $(echo $pkgToRemoveListFull); do
  $(sudo dpkg --status $pkgToRemove &> /dev/null)
  if [[ $? -eq 0 ]]; then
    pkgToRemoveList="$pkgToRemoveList $pkgToRemove"
  fi
done
sudo apt-get --yes --purge remove $pkgToRemoveList
sudo apt autoremove

# Upgrade
read -p "Press enter to execute next step: Upgrade system..."
sudo apt update
sudo apt upgrade
sudo apt autoremove

# Install basic tools
read -p "Press enter to execute next step: Install basic tools..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

read -p "Press enter to execute next step: Add apt repositories..."
# Add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add Kubernetes repository
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"

# Add Google Cloud SDK repository
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb http://packages.cloud.google.com/apt cloud-sdk main"

# Add VS Code repository
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main"

# Add Azure CLI repository
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main"

# Add Chrome repository
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"

# Update and install all needed packages
read -p "Press enter to execute next step: Install main packages..."
sudo apt update
sudo apt install -y \
    git \
    code \
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
    azure-cli \
    kubectl \
    docker-ce \
    docker-ce-cli \
    containerd.io \

# Install Wavebox
curl -fsSL -o /tmp/wavebox.deb https://download.wavebox.app/latest/stable/linux/deb
sudo apt install /tmp/wavebox.deb

# Docker Post Install
sudo usermod -aG docker $USER

# Docker Compose Install
read -p "Press enter to execute next step: Install docker-compose..."
sudo curl -fsSL "https://github.com/docker/compose/releases/download/1.28.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# miniconda
read -p "Press enter to execute next step: Install miniconda..."
curl -fsSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/miniconda.sh -b -p $HOME/miniconda3
# Needed for dcps.py
$HOME/miniconda3/bin/conda install tabulate

# LatexDocker
read -p "Press enter to execute next step: Install latexdocker..."
sudo curl -fsSL -o /usr/local/bin/latexdocker https://raw.githubusercontent.com/blang/latex-docker/master/latexdockercmd.sh
sudo chmod +x /usr/local/bin/latexdocker

# Kubectx & Kubens
read -p "Press enter to execute next step: Install kubectx/kubens..."
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
sudo ln -sf /opt/kubectx/completion/kubens.bash $COMPDIR/kubens
sudo ln -sf /opt/kubectx/completion/kubectx.bash $COMPDIR/kubectx

# Link configs
read -p "Press enter to execute next step: Link configs..."
mkdir -p $HOME/.config/Code/User
rm $HOME/.config/Code/User/settings.json || true
ln -s $current_dir/vs-code-settings.json ~/.config/Code/User/settings.json
mkdir -p $HOME/.ssh
ln -s $current_dir/ssh_config ~/.ssh/config

read -p "Installation finished. Press enter to finish."