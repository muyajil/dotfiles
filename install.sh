#!/bin/bash
current_dir=$(pwd)
bash_config_path=$current_dir/bash_prompt.sh
echo "source $bash_config_path" >> ~/.bashrc
echo "alias jn=\"jupyter notebook\"" >> ~/.bashrc
echo "alias vs=\"code .\"" >> ~/.bashrc
echo "alias jl=\"jupyter-lab\"" >> ~/.bashrc
echo "source <(kubectl completion bash)" >> ~/.bashrc

sudo apt update
sudo apt remove libreoffice* firefox
sudo apt autoremove
sudo apt install -y git-core python3-pip code slack-desktop docker.io docker-compose google-chrome-stable guake htop vlc pkgconf

sudo usermod -aG docker $USER

sudo -H pip3 install --upgrade pip
sudo -H pip3 install pipenv jupyterlab

sudo wget -O /usr/local/bin/latexdocker https://raw.githubusercontent.com/blang/latex-docker/master/latexdockercmd.sh
sudo chmod +x /usr/local/bin/latexdocker

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
sudo ln -sf /opt/kubectx/completion/kubens.bash $COMPDIR/kubens
sudo ln -sf /opt/kubectx/completion/kubectx.bash $COMPDIR/kubectx
echo "export PATH=/opt/kubectx:\$PATH" >> ~/.bashrc

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt update
sudo apt install -y google-cloud-sdk kubectl

rm ~/.config/Code/User/settings.json
ln -s $current_dir/vs-code-settings.json ~/.config/Code/User/settings.json
ln -s $current_dir/ssh_config ~/.ssh/config
