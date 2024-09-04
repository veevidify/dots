# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERMINAL=kitty

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#
ZSH_THEME="alien-minimal/alien-minimal"
export AM_PY_SYM=' '
export AM_NODE_SYM=' '
export AM_JAVA_SYM=' '
export AM_ASYNC_L_PROMPT=1
export AM_UPDATE_L_PROMPT=0
export AM_VERSIONS_PROMPT=(NODE PYTHON JAVA)
export AM_ERROR_ON_START_TAG=1
export AM_SHOW_FULL_DIR=1
export AM_THEME=terminal
export USE_NERD_FONT=1
export AM_GIT_SYM=
export AM_GIT_ADD_SYM=''  # Git New Tracked File Symbol
export AM_GIT_DEL_SYM=''  # Git Deleted File Symbol
export AM_GIT_MOD_SYM=''  # Git Modified File Symbol
export AM_GIT_NEW_SYM=''  # Git New Un-tracked File Symbol
export PROMPT_START_TAG='󰉋  '
export PROMPT_END_TAG_COLOR=80
export PROMPT_END_TAG='   ›'
export AM_GIT_UN_TRACKED_COLOR=orange

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

DISABLE_UPDATE_PROMPT=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# zsh-autocomplete
plugins=(
	z
	zsh-syntax-highlighting
	zsh-autosuggestions
	aws
	cp
	kubectl
	npm
	node
	git
	docker
	docker-compose
	yarn
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias docker-compose="docker compose"
#

# load zgen
#source "${HOME}/.zgen/zgen.zsh"

#MNML_USER_CHAR='$'
#MNML_NOMRAL_CHAR='-'
#MNML_INSERT_CHAR='>'

# if the init scipt doesn't exist
#if ! zgen saved; then

  # specify plugins here
  #zgen oh-my-zsh

  # generate the init script from plugins above
#  zgen save
#fi

#zgen load subnixr/minimal


#function powerline_precmd() {
#    PS1="$(powerline-shell --shell zsh $?)"
#}

#function install_powerline_precmd() {
#  for s in "${precmd_functions[@]}"; do
#    if [ "$s" = "powerline_precmd" ]; then
#      return
#    fi
#  done
#  precmd_functions+=(powerline_precmd)
#}

#if [ "$TERM" != "linux" ]; then
#    install_powerline_precmd
#fi

#export KAPISV=$(kubectl config view | grep https | cut -f 2- -d ":" | tr -d " ") > /dev/null 2>&1
#export KTOKEN=$(kubectl describe secret -n kube-system $(kubectl get secrets -n kube-system | grep default | cut -f1 -d ' ') | grep -E '^token' | cut -f2 -d':' | tr -d '\t' | tr -d " ") > /dev/null 2>&1

export CALIBRE_USE_DARK_PALETTE=1

export PATH="$HOME/.poetry/bin:$PATH"
export GPG_TTY=$(tty)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias xclip="xclip -selection c"
alias please="sudo !!"

export AWS_PROFILE=default
source ~/devs/creds

eval "$($HOME/.local/bin/mise activate zsh)"

source ~/scripts/workflow/function.sh
source ~/scripts/workflow/alias.sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$HOME/.local/kitty.app/bin:$PATH"

autoload -U compinit; compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# source ~/.oh-my-zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

fortune | cowsay

