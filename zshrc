if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities windows-jannik
zstyle :omz:plugins:ssh-agent lifetime 4h

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install zinit(https://github.com/zdharma/zinit) first!

# Created by newuser for 5.4.2

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# Aliases

alias ls='ls --color=always'
alias vim='nvim'

# Add local pip path to PATH
python3 -m site &> /dev/null && PATH="$PATH:`python3 -m site --user-base`/bin"

# Load completion engine
autoload -Uz compinit
compinit

# Create history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Bind CTRL+{leftarrow, rightarrow, backspace}
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

zinit ice depth=1
zinit light romkatv/powerlevel10k
zplugin load zsh-users/zsh-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
zplugin load /zsh-users/zsh-completions
zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

