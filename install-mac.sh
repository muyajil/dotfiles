#!/bin/zsh

current_dir=$(pwd)

# Add scripts
read -p "Press enter to execute next step: Add scripts to /usr/local/bin..."
sudo cp $current_dir/dcps.py /usr/local/bin/dcps
sudo cp $current_dir/c.sh /usr/local/bin/c

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -f ~/.zshrc

# Execute scripts in ~/.zshrc
zsh_config_path=$current_dir/zsh_config.sh
aliases_path=$current_dir/aliases.sh
paths_path=$current_dir/paths.sh
env_vars_path=$current_dir/env_vars.sh

echo "# source dotfile scripts" >> ~/.zshrc
echo "source $zsh_config_path" >> ~/.zshrc
echo "source $aliases_path" >> ~/.zshrc
echo "source $paths_path" >> ~/.zshrc
echo "source $env_vars_path" >> ~/.zshrc

echo 'export ZSH="$HOME/.oh-my-zsh"' >> ~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc

# Install plugins and themes for zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestiosns
curl -fsSL -o $HOME/.oh-my-zsh/custom/themes/bullet-train.zsh-theme http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme

# Install fonts
git clone https://github.com/powerline/fonts.git $HOME/repositories/fonts
$HOME/repositories/fonts/install.sh

# Install homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Tools
brew install --cask docker visual-studio-code mountain-duck miniconda google-cloud-sdk google-chrome iterm2
brew install node docker-compose

# Needed for dcps.py
conda install tabulate

# Configs
mkdir -p $HOME/Library/Application\ Support/Code/User
rm $HOME/Library/Application\ Support/Code/User/settings.json || true
ln -s $current_dir/vs-code-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
mkdir -p $HOME/.ssh
ln -s $current_dir/ssh_config ~/.ssh/config