
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install


# The following lines were added by compinstall

zstyle :compinstall filename '/home/dre/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dre/.oh-my-zsh"

#export TERM="xterm-256color"
#export LANG=en_US.UTF-8

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_MODE='awesome-fontconfig'
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs)

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
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    emoji
    git
    vi-mode
    #zsh-syntax-highlighting
    #zsh-autosuggestions
    z
)

source $ZSH/oh-my-zsh.sh

# source python powerline

if [[ -r /home/dre/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /home/dre/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi

if [[ -r /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

fi

#source ~/.fonts/devicons-regular.sh

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

# alias ohmyzsh="mate ~/.oh-my-zsh"


# z extention for browsing
. ~/z.sh

case $(uname -a) in
	*Microsoft*) unsetopt BG_NICE ;;
esac

#function prompt_char {
#    git branch >/dev/null 2>/dev/null && echo '±' && return
#    hg root >/dev/null 2>/dev/null && echo '☿' && return
#    echo '%(!.!.➜)'
#}
#
#
#function parse_hg_dirty {
#    if [[ -n $(hg status -mard . 2> /dev/null) ]]; then
#        echo "$ZSH_THEME_HG_PROMPT_DIRTY"
#    fi
#}
#
#function get_RAM {
#    free -m | awk '{if (NR==3) print $4}' | xargs -i echo 'scale=1;{}/1000' | bc
#}
#
#function get_nr_jobs() {
#    jobs | wc -l
#}
#
#function get_nr_CPUs() {
#    grep -c "^processor" /proc/cpuinfo
#}
#
#function get_load() {
#    uptime | awk '{print $11}' | tr ',' ' '
#}
#
#PROMPT='%{$fg_bold[green]%}%n@%m %{$fg[cyan]%}%2c %{$fg_bold[blue]%}$(git_prompt_info)$(parse_hg_dirty)%{$fg_bold[blue]%} %{$fg_bold[red]%}$(prompt_char) % %{$reset_color%}'
#
#RPROMPT='%{$fg_bold[red]%}[$(get_nr_jobs), $(get_RAM)G, $(get_load)($(get_nr_CPUs))] %{$fg_bold[green]%}%*%{$reset_color%}'
#
#ZSH_THEME_HG_PROMPT_PREFIX="hg:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

## custom functions
# get me the url of the changes that have just been pushed
gpr() {
      if [ $? -eq 0 ]; then
          github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
          branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
          pr_url=$github_url"/compare/master..."$branch_name
          xdg-open $pr_url;
      else
          echo 'failed to open a pull request.';
      fi
  }
                                   
commands() {
      awk '{a[$2]++}END{for(i in a){print a[i] " " i}}'
  }

# add browser
export BROWSER='/usr/bin/google-chrome-stable'

# Set git text editor
export GIT_EDITOR="nvim"


export NVM_DIR="$HOME/.nvm"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install


# The following lines were added by compinstall
zstyle :compinstall filename '/home/dre/.zshrc'


autoload -Uz compinit
compinit
# End of lines added by compinstall

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dre/.oh-my-zsh"

#export TERM="xterm-256color"
#export LANG=en_US.UTF-8

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_MODE='awesome-fontconfig'
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs)

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
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    emoji
    git
    vi-mode
    #zsh-syntax-highlighting
    #zsh-autosuggestions
    z
)

source $ZSH/oh-my-zsh.sh

# source python powerline
if [[ -r /home/dre/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /home/dre/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# source bash insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

#source ~/.fonts/devicons-regular.sh

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
alias zshconfig="vim ~/.zshrc"
alias cls="clear"
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias gl="git log --oneline --graph"
alias grpo="git remote prune origin"

alias update="source ~/.zshrc"
alias gpp="git pull --prune"
alias gdm="git branch --merged | grep -v '\*' | xargs -n 1 git branch -d"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# z extention for browsing
. ~/z.sh

case $(uname -a) in
	*Microsoft*) unsetopt BG_NICE ;;
esac

#function prompt_char {
#    git branch >/dev/null 2>/dev/null && echo '±' && return
#    hg root >/dev/null 2>/dev/null && echo '☿' && return
#    echo '%(!.!.➜)'
#}
#
#
#function parse_hg_dirty {
#    if [[ -n $(hg status -mard . 2> /dev/null) ]]; then
#        echo "$ZSH_THEME_HG_PROMPT_DIRTY"
#    fi
#}
#
#function get_RAM {
#    free -m | awk '{if (NR==3) print $4}' | xargs -i echo 'scale=1;{}/1000' | bc
#}
#
#function get_nr_jobs() {
#    jobs | wc -l
#}
#
#function get_nr_CPUs() {
#    grep -c "^processor" /proc/cpuinfo
#}
#
#function get_load() {
#    uptime | awk '{print $11}' | tr ',' ' '
#}
#
#PROMPT='%{$fg_bold[green]%}%n@%m %{$fg[cyan]%}%2c %{$fg_bold[blue]%}$(git_prompt_info)$(parse_hg_dirty)%{$fg_bold[blue]%} %{$fg_bold[red]%}$(prompt_char) % %{$reset_color%}'
#
#RPROMPT='%{$fg_bold[red]%}[$(get_nr_jobs), $(get_RAM)G, $(get_load)($(get_nr_CPUs))] %{$fg_bold[green]%}%*%{$reset_color%}'
#
#ZSH_THEME_HG_PROMPT_PREFIX="hg:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

## custom functions
# get me the url of the changes that have just been pushed
gpr() {
      if [ $? -eq 0 ]; then
          github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
          branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
          pr_url=$github_url"/compare/master..."$branch_name
          xdg-open $pr_url;
      else
          echo 'failed to open a pull request.';
      fi
  }
                                   
commands() {
      awk '{a[$2]++}END{for(i in a){print a[i] " " i}}'
  }

# add browser
#export BROWSER='/mnt/c/Tools/Chrome/Application/chrome.exe'
export BROWSER='/usr/bin/google-chrome-stable'
#export CHROME_BIN='/mnt/c/Tools/Chrome/Application/chrome.exe'
export CHROME_BIN='/usr/bin/google-chrome-stable'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

synapse &>/dev/null &

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
