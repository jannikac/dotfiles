
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Aliases
alias ls='ls --color=always'
alias vim='nvim'

# Add local pip path to PATH
python3 -m site &> /dev/null && PATH="$PATH:`python3 -m site --user-base`/bin"

# Export LANG veriable to use UTF-8
export LANG=en_US.UTF-8

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

# Load theme
eval "$(starship init zsh)"

# Load plugins
zplugin load zsh-users/zsh-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
zplugin load /zsh-users/zsh-completions
#zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

