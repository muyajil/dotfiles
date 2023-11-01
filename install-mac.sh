#!/bin/zsh

current_dir=$(pwd)

# Add scripts
sudo mkdir /usr/local/bin
sudo cp $current_dir/dcps.py /usr/local/bin/dcps
sudo cp $current_dir/c.sh /usr/local/bin/c
sudo cp $current_dir/conda-pip-install.sh /usr/local/bin/conda-pip-install

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -f ~/.zshrc

# Execute scripts in ~/.zshrc
cd $HOME/repositories/dotfiles
current_dir=$(pwd)
aliases_path=$current_dir/aliases.sh
paths_path=$current_dir/paths.sh
env_vars_path=$current_dir/env_vars.sh
brew_completions=$current_dir/brew_completions.sh

echo "# source dotfile scripts" >> ~/.zshrc
echo "source $aliases_path" >> ~/.zshrc
echo "source $paths_path" >> ~/.zshrc
echo "source $env_vars_path" >> ~/.zshrc
echo "source $brew_completions" >> ~/.zshrc

# Install homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Tools & Software
brew install \
    docker \
    visual-studio-code \
    mountain-duck \
    micromamba \
    google-chrome \
    bitwarden \
    whatsapp \
    signal \
    slack \
    threema \
    plex \
    yt-dlp \
    gh \
    warp

# Needed for dcps.py
conda install tabulate
sudo xattr -d com.apple.quarantine /usr/local/bin/dcps

# Configs
current_dir=$(pwd)
mkdir -p $HOME/Library/Application\ Support/Code/User
rm $HOME/Library/Application\ Support/Code/User/settings.json || true
ln -s $current_dir/vs-code-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
mkdir -p $HOME/.ssh
ln -s $current_dir/ssh_config ~/.ssh/config
