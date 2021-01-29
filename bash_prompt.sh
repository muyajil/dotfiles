#!/bin/bash

# The various escape codes that we can use to color our prompt.
        RED="\[\033[1;31m\]"
     YELLOW="\[\033[1;33m\]"
     PURPLE="\[\033[1;35m\]"
      GREEN="\[\033[1;32m\]"
       BLUE="\[\033[1;34m\]"
       CYAN="\[\033[1;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[1;37m\]"
 DARK_GRAY="\[\033[1;90m\]"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${LIGHT_RED}"
  fi

  # Set arrow icon based on status against remote.
  if [[ ${git_status} = *"ahead"* ]]; then
    remote=" >>>"
    state="${PURPLE}"
  elif [[ ${git_status} = *"behind"* ]]; then
    remote=" <<<"
    state="${PURPLE}"
  else
    remote=""
  fi

  # Get the name of the branch.
  gitsym=$(git symbolic-ref HEAD 2>/dev/null)
  if [[ $? == 0 ]]; then
      branch="${gitsym##refs/heads/}"
  fi

  # Set the final branch string.
  BRANCH="${state}${branch}${remote}${COLOR_NONE}"
}

function set_kube_context()
{
    # Get current context
    CONTEXT=$(cat ~/.kube/config 2>/dev/null | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        KUBE="${YELLOW}${CONTEXT}${COLOR_NONE}"
    fi
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="${BLUE}\$${COLOR_NONE}"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_conda_env () {
  CONDA_ENV="${CYAN}${CONDA_DEFAULT_ENV}${COLOR_NONE}"
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_conda_env

  # Set the NODE_PYTHON_VIRTUALENV variable.
  # set_nodevirtenv

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  set_kube_context

  PROMPT_DIRTRIM=2
  # Set the bash prompt variable.
  PS1="${LIGHT_GREEN}\u@\h${COLOR_NONE} / ${CONDA_ENV} / ${KUBE} / ${BRANCH} / ${BLUE}\w${COLOR_NONE} ${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
