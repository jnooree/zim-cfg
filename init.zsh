# Most of these came from ohmyzsh/ohmyzsh

for file in "$(dirname "$0")/ohmyzsh/"*.zsh; do
	. "$file"
done

# Shell options
setopt completeinword correctall noflowcontrol interactivecomments \
	longlistjobs printexitvalue transientrprompt
setopt autocd autopushd pushdignoredups pushdminus
setopt cshnullglob extendedglob kshglob numericglobsort rematchpcre
setopt appendhistory extendedhistory histexpiredupsfirst histfindnodups \
	histignorealldups histignoredups histignorespace histnostore \
	histreduceblanks histsavenodups histverify sharehistory

unsetopt nocaseglob

# Keybindings
bindkey "^U" backward-kill-line
bindkey "^[_" redo

# Better "word" detection
WORDCHARS=''

# Highlight settings
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets regexp root)
ZSH_HIGHLIGHT_STYLES[comment]='bold,9'
ZSH_HIGHLIGHT_REGEXP[\bsudo\b]='bold,underline'

# Autocomplete settings
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# fzf
export FZF_DEFAULT_COMMAND='fd -Ht f -E .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd -Ht d -E .git'

export FZF_DEFAULT_OPTS='
--height 40% --reverse --border --inline-info --multi
--color hl:2,hl+:10
--color info:3,prompt:2,spinner:5,pointer:5,marker:6
'

export FZF_COMPLETION_TRIGGER='~~'

fzf_compgen_path() {
		fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
		fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Better SSH/Rsync/SCP Autocomplete
zstyle -s ':completion:*:hosts' hosts _ssh_config
if [[ -r /etc/hosts ]]; then
	_ssh_config+=($(pcregrep -o1 '^\s*[\.\d]+\s+(\S+)' /etc/hosts))
fi
if [[ -r ~/.ssh/config ]]; then
	_ssh_config+=($(pcregrep -io2 '^\s*host(\s+|\s*=\s*)([^\s\*]+\s*$)' ~/.ssh/config))
fi
zstyle ':completion:*:hosts' hosts $_ssh_config
zstyle ':completion:*:(ssh|scp|rsync|ftp|sftp):*:hosts' ignored-patterns \
	'*(.|:)*' loopback broadcasthost
unset _ssh_config

# conda autocomplete settings
zstyle ":conda_zsh_completion:*" use-groups true
zstyle ":conda_zsh_completion:*" show-unnamed true
zstyle ":conda_zsh_completion:*" sort-envs-by-time true
zstyle ":conda_zsh_completion:*" show-global-envs-first true

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=500000
export SAVEHIST=100000

# Add options for less
export LESS='-RM~gi'

# ls options
export QUOTING_STYLE='literal'

# normal grep colors
unset GREP_COLOR GREP_COLORS

# Custom aliases
alias -- -='cd -'

alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
alias -g .......=../../../../../..

alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

# enable diff color if possible.
if command diff --color /dev/null /dev/null &>/dev/null; then
	alias diff='diff --color'
fi

alias md='mkdir -p'
alias rd=rmdir

alias cp='nocorrect cp'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias su='nocorrect su'
alias sudo='nocorrect sudo'
alias env="env | grep -v '^LESS_TERMCAP'"

eval "old$(alias ls)"
alias ls="$oldls -vF"
alias l='ls -lah -B'
unset oldls

alias kssh='ssh -O exit'

alias glogb="git log --oneline --decorate --graph --branches"
alias gsa="git submodule add"
alias gcq="git commit --quiet"

alias tar='tar --disable-copyfile --exclude '\''.DS_Store'\'' --exclude '\''.git*'\'' --exclude '\''*.log'\'
alias taro='command tar'
alias top=htop
alias topo='command top'