# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew goes first, so oh-my-zsh plugins already see brew tools
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$HOME/go/bin:$HOME/.local/bin:$PATH

# Autocompletion for edgedb
fpath+=~/.zfunc

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Themes and plugins live outside $ZSH, cloned by `mise bootstrap`
export ZSH_CUSTOM="$HOME/.zsh-custom"

# zsh-completions is loaded through fpath, not as an oh-my-zsh plugin
fpath+=$ZSH_CUSTOM/plugins/zsh-completions/src

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# History: shared between sessions, no duplicates, commands starting
# with a space are not saved
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  kubectl
  docker-compose
)

source $ZSH/oh-my-zsh.sh

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

alias v="nvim"
alias vim="nvim"
alias marta="marta --existing-tab"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf settings
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

export SSH_AUTH_SOCK=$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

eval "$(mise activate zsh)"
eval "$(mise completion zsh)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

eval "$(zoxide init --cmd cd zsh)"
