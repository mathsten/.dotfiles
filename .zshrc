# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mathias/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mathias"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(
    git
    vi-mode
    you-should-use $plugins
    #thefuck
)

source $ZSH/oh-my-zsh.sh

bindkey 'jk' vi-cmd-mode

# use the vi navigation keys in menu completion
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
#
# export MANPATH="/usr/local/man:$MANPATH"

# Aliases
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias split_pdf="conda activate pdf; python /home/mathias/drive/Prosjekter/pdf_splitter/split_pdf.py"

IP=$(hostname -I)

# Base16 config
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mathias/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mathias/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mathias/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mathias/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias dotfiles='/usr/bin/git --git-dir=/home/mathias/.dotfiles/ --work-tree=/home/mathias'

alias ca='conda activate'
alias cde='conda deactivate'
alias cl='conda env list'

# ROS
alias eb='nano ~/.bashrc'
alias sb='source ~/.bashrc'
alias gs='git status'
alias gp='git pull'
alias cw='cd ~/catkin_ws'
alias cs='cd ~/catkin_ws/src'
alias cm='cd ~/catkin_ws && catkin_make'
source /opt/ros/melodic/setup.zsh
source ~/catkin_ws/devel/setup.zsh
export ROS_MASTER_URI=http://$IP:11311
export ROS_HOSTNAME=$IP
export EDITOR=vim
export RANGER_LOAD_DEFAULT=FALSE
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR
alias vless="/usr/share/vim/vim80/macros/less.sh"


zet () {
    cmd="ZetNew $1"
    vim -c $cmd
}

#open () {
    #eval "open $1" || eval "eog $1"
#}


export PYTHONPATH=$PYTHONPATH:/home/mathias/epigram/tensorflow/models/research:/home/mathias/epigram/tensorflow/models/research/slim
stty -ixon
#export PAGER="/usr/share/vim/vim80/macros/less.sh"
. /usr/share/autojump/autojump.sh
FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

