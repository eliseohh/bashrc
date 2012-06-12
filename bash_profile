# Prompt (Debian)
#source /usr/local/bin/git-completion.sh

# Prompt (OS X + homebrew)
#source /usr/local/etc/bash_completion.d/git-completion.bash

#PS1="\[\033[31;38m\]\w\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] "
#export GIT_PS1_SHOWDIRTYSTATE=1

# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

#export PS1="\u@\h:\[\e[1;32m\]\w\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] $ "

export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] $ "

alias d='git diff --word-diff $@'
alias s='git status -sb'
alias b='git branch -avv'
alias c='git commit -v $@'
alias co='git checkout'
alias a='git add $@'
alias ai='git add -i'
alias ac='git add .;c $@'
alias lg='git lg'

__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
"
}

__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}

__git_shortcut  a    add
__git_shortcut  b    branch
__git_shortcut  ba   branch -a
__git_shortcut  co   checkout
__git_shortcut  c   commit -v
__git_shortcut  d    diff

#custom aliases
alias ll='ls -alh'
