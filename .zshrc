#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000

#------------------------------
# Variables
#------------------------------

# SLRN
export NNTPSERVER='news.gmane.org'

export EDITOR=vim

# Set DE to gnome for chromium
export DE=gnome

# For NPM
export PREFIX=~/.local
export NODE_PATH=~/.local/lib/node_modules/

export PATH=$PATH:/home/jelle/bin/

# Fancier coloring in neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Browser
export BROWSER=chromium

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key

bindkey '^[[3~' delete-char

# Up/Down line history arrow up/down
bindkey '^[[B' down-line-or-history
bindkey '^[[A' up-line-or-search

# Beginning of line also ctrl+e/a ctrl+up/down
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line
bindkey "^[^?" backward-kill-word

# Ctrl+r history search
bindkey "^R" history-incremental-search-backward

# History search (usually up/down key)
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

bindkey "^[[1;5D" emacs-backward-word
bindkey "^[[1;5C" emacs-forward-word

#------------------------------
# History
#------------------------------
setopt extended_history
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_verify


#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias grep="grep --color=always"

# pacman
alias pacup='sudo pacman -Syu '
alias pacs='pacman -Ss'
alias pacins='sudo pacman -S'
alias pacr='sudo pacman -Rs'
alias pacq='pacman -Q'
alias pacu='sudo pacman -U'

_fetchpr() {
    origin=${3:-origin}
    ref=$1
    branch=$2
    program=${funcstack#_fetchpr};
    if (( $# != 2 && $# != 3 )) then
        echo usage:$program id branchname \[remote\];
	return 1
    fi

    if git rev-parse --git-dir &> /dev/null; then
         git fetch $origin $ref && git checkout $branch
    else
	echo 'error: not in git repo'
    fi
}

# Checkout Github PR function
gitpr() {
    github="pull/$1/head:$2"
    _fetchpr $github $2 $3
}

# Checkout Bitbucket PR function
bitpr() {
    bitbucket="refs/pull-requests/$1/from:$2"
    _fetchpr $bitbucket $2 $3
}

# moving in dirs
alias ..="cd .."

#-----------------------------
# Dircolors
#-----------------------------
eval $(dircolors -b $HOME/.dircolors)

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always


#------------------------------
# Functions
#------------------------------
sprunge() {
        if [ -z "$1" ]
then
    curl -s -F 'sprunge=<-' http://sprunge.us
else
    if [ -z "$2" ]
    then
        echo -n "$1:"
        cat "$1" | "$0"
    else
        for i in "$@"
        do
            "$0" "$i"
        done
    fi
fi

}

# svn diff
svndiff() {
  svn diff "${@}" | colordiff | less -R
}

#------------------------------
# Window title
#------------------------------
case $TERM in
    *xterm*|rxvt|rxvt-unicode|rxvt-256color|(dt|k|E)term)
                precmd () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" } 
		preexec () { print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" }
        ;;
    screen)
        precmd () { 
		[[ $a = zsh ]] && print -Pn "\ek$2\e\\" # show the path if no program is running
                [[ $a != zsh ]] && print -Pn "\ek$a\e\\" # if a program is running show that

                # Terminal title
                if [[ -n $STY ]] ; then
                        [[ $a = zsh ]] && print -Pn "\e]2;$SHORTHOST:S\[$WINDOW\]:$2\a"
                        [[ $a != zsh ]] && print -Pn "\e]2;$SHORTHOST:S\[$WINDOW\]:${a//\%/\%\%}\a"
                elif [[ -n $TMUX ]] ; then
                        # We're running in tmux, not screen
                        [[ $a = zsh ]] && print -Pn "\e]2;$SHORTHOST:$2\a"
                        [[ $a != zsh ]] && print -Pn "\e]2;$SHORTHOST:${a//\%/\%\%}\a"
                fi
                }
                preexec () { 
                       # print -Pn "\e]83;title \"$1\"\a" 
                       # print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
                }
        ;; 
esac

#------------------------------
# Prompt
#------------------------------
setprompt () {
        # load some modules
        autoload -U zsh/terminfo # Used in the colour alias below
        # Use colorized output, necessary for prompts and completions.
        autoload -U colors && colors
        setopt prompt_subst

        # make some aliases for the colours: (coud use normal escap.seq's too)
        for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
                eval PR_$color='%{$fg[${(L)color}]%}'
        done
        PR_NO_COLOR="%{$terminfo[sgr0]%}"

        # Check the UID
        if [[ $UID -ge 1000 ]]; then # normal user
                eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
                eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
        elif [[ $UID -eq 0 ]]; then # root
                eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
                eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
        fi      

        # Check if we are on SSH or not  --{FIXME}--  always goes to |no SSH|
        if [[ -z "$SSH_CLIENT"  ||  -z "$SSH2_CLIENT" ]]; then 
                eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
        else 
                eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
        fi
        # set the prompt
        PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_BLUE}%~${PR_CYAN}]${PR_USER_OP}'
        PS2=$'%_>'
}
setprompt

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
