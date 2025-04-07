setopt prompt_subst
autoload -U colors && colors

ZSH_GIT_PROMPT_SHOW_UPSTREAM=0
ZSH_GIT_PROMPT_SHOW_TRACKING_COUNTS=1
ZSH_GIT_PROMPT_SHOW_LOCAL_COUNTS=0
ZSH_GIT_PROMPT_SHOW_STASH=1

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[cyan]%}>"
ZSH_THEME_GIT_PROMPT_SEPARATOR="%{$fg[yellow]%}] %{$fg[cyan]%}<"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[cyan]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[cyan]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[red]%}+"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}Ξ"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

_user_host='%B%(!:%F{red}:%F{green})%n@%m%f%b '
_datetime='%F{red}%D{[%I:%M:%S]}%f '
_cwd='%F{cyan}%3~%f '
_jobs='%F{blue}%(1j:(%j %(2j:jobs:job)%) :)'
_arrow='%B%(?:%F{green}:%F{red})➜%f%b'
PROMPT="${_user_host}${_datetime}${_cwd}${_jobs}\$(gitprompt)
$_arrow "
