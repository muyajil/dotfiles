#!/bin/zsh

current_dir=$(pwd)

# Add scripts
sudo mkdir /usr/local/bin
sudo cp $current_dir/dcps.py /usr/local/bin/dcps
sudo cp $current_dir/c.sh /usr/local/bin/c

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -f ~/.zshrc

# Execute scripts in ~/.zshrc
cd $HOME/repositories/dotfiles
current_dir=$(pwd)
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
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
curl -fsSL -o $HOME/.oh-my-zsh/custom/themes/bullet-train.zsh-theme http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
curl -fsSL -o $HOME/Downloads/Tomorrow\ Night\ Eighties.terminal https://github.com/chriskempson/tomorrow-theme/raw/master/OS%20X%20Terminal/Tomorrow%20Night%20Eighties.terminal
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install fonts
git clone https://github.com/powerline/fonts.git $HOME/repositories/fonts
mkdir $HOME/repositories/fonts/MesloLGS
curl -fsSL -o $HOME/repositories/fonts/MesloLGS/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fsSL -o $HOME/repositories/fonts/MesloLGS/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fsSL -o $HOME/repositories/fonts/MesloLGS/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fsSL -o $HOME/repositories/fonts/MesloLGS/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
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

# Conda config
conda init zsh
conda config --set changeps1 False

# Configs
current_dir=$(pwd)
mkdir -p $HOME/Library/Application\ Support/Code/User
rm $HOME/Library/Application\ Support/Code/User/settings.json || true
ln -s $current_dir/vs-code-settings.json $HOME/Library/Application\ Support/Code/User/settings.json
mkdir -p $HOME/.ssh
ln -s $current_dir/ssh_config ~/.ssh/config

echo "You need to import the color palette in the downloads folder and set it as default for terminal and choose a powerline font as well"