# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi
PATH=$HOME/bin/:$PATH
# append to the history file, don't overwrite it
shopt -s histappend

# Source global definitions
# if [ -f /etc/bashrc ]; then
#    . /etc/bashrc
# fi

if which dircolors > /dev/null 2>&1; then
    eval "$(dircolors -b)"
fi

# standard alias
if [ $(uname) = Linux ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
elif [ $(uname) = FreeBSD ]; then
    alias make=gmake
    if which gnuls > /dev/null 2>&1; then
        alias ls='gnuls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'
    else
        alias ls='ls -G'
    fi
elif [ $(uname) = Darwin ]; then
    alias ls='ls -G'
    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi
    PATH=/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:$PATH
fi


# Some env variables
export PATH=$HOME/bin:$PATH
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/lib/pkgconfig
export LD_LIBRARY_PATH=${HOME}/lib64:${HOME}/lib

export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export PAGER="$(which less) -s"
export BROWSER="$PAGER"

export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;33m'
export LESS="-r"

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -l'
alias ll='ls -l'

if [ $(id -u) -eq 0 ]; then
    MY_PROMPT='\[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]'
else
    MY_PROMPT='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]'
fi

if [ "$(hostname|cut -d. -f1)" == "localhost" ] || hostname|grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' >/dev/null 2>&1; then
    if [ $(uname) = Linux ]; then
        IP=$(/sbin/ifconfig|grep 'inet '|grep -v '127.0.0.1'|head -1|cut -d: -f2|awk '{print $1}')
    elif [ $(uname) = FreeBSD ] || [ $(uname) = Darwin ]; then
        IP=$(/sbin/ifconfig|grep 'inet '|grep -v '127.0.0.1'|head -1|awk '{print $2}')
    fi
    if [ -n $IP ]; then
        MY_PROMPT=$(echo "$MY_PROMPT"|sed s/'\\h'/$IP/)
        unset IP
    fi
fi

PS1="[${MY_PROMPT}]\$ "
if which git >/dev/null 2>&1; then
    parse_git_branch() {
        if ! git rev-parse --git-dir >/dev/null 2>&1; then
            return 0
        fi
        git branch --no-color 2>/dev/null | sed -n '/^\*/s/^\* \(.*\)/ <\1>/p'
    }
    git_branch_color_begin() {
        if ! git rev-parse --git-dir >/dev/null 2>&1; then
            return 0
        fi
        git status 2>/dev/null | grep 'working directory clean' >/dev/null 2>&1
        if [ "$?" -eq 0 ]; then
            echo '[0;32m'
        else
            echo '[0;31m'
        fi
    }
    git_branch_color_end() {
        if ! git rev-parse --git-dir >/dev/null 2>&1; then
            return 0
        fi
        echo '[0m'
    }
    PS1="[${MY_PROMPT}\[\$(git_branch_color_begin)\]\$(parse_git_branch)\[\$(git_branch_color_end)\]]\$ "
fi
unset MY_PROMPT

# screen alias
if which screen > /dev/null 2>&1; then
    alias screen='screen -U'
fi

if [ -f ~/.rvm/scripts/rvm ]; then
    source ~/.rvm/scripts/rvm
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi
export TERM=xterm-color
