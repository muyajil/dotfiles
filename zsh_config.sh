ZSH_THEME="powerlevel10k/powerlevel10k"
prompt_conda() {
  prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(conda info | awk '{print $4}' | sed -n '2p')"
}
TERM="xterm-256color"
BULLETTRAIN_PROMPT_ORDER=(
    # time
    status
    custom
    # context
    dir
    screen
    # perl
    # ruby
    conda
    # nvm
    # aws
    # go
    # rust
    # elixir
    git
    # hg
    cmd_exec_time
  )
# BULLETTRAIN_VIRTUALENV_FG=black
plugins=(
    git
    zsh-autosuggestions
    sudo)
# More configuration options for theme https://github.com/caiogondim/bullet-train.zsh