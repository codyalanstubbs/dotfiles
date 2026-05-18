# ──────────────────────────────────────────────────────────────────────────
# History
# ──────────────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt EXTENDED_HISTORY        # write timestamp + duration
setopt HIST_EXPIRE_DUPS_FIRST  # expire dup entries first when trimming
setopt HIST_IGNORE_DUPS        # skip consecutive duplicates
setopt HIST_IGNORE_SPACE       # skip commands starting with space
setopt HIST_VERIFY             # confirm before running !! / !$ expansions
setopt SHARE_HISTORY           # share history across running shells
setopt INC_APPEND_HISTORY      # append immediately, not on exit

# ──────────────────────────────────────────────────────────────────────────
# Completion
# ──────────────────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive

# ──────────────────────────────────────────────────────────────────────────
# Options
# ──────────────────────────────────────────────────────────────────────────
setopt AUTO_CD                 # type a dir name to cd into it
setopt INTERACTIVE_COMMENTS    # allow `# comments` in interactive shell
setopt NO_BEEP

# ──────────────────────────────────────────────────────────────────────────
# Keybindings
# ──────────────────────────────────────────────────────────────────────────
# Ctrl+R: incremental reverse history search
bindkey '^R' history-incremental-search-backward

# Up/Down: prefix-search history — type `php arti` then ↑ steps through prior
# commands beginning with that prefix.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search    # up arrow
bindkey '^[[B' down-line-or-beginning-search  # down arrow
bindkey '^P'   up-line-or-beginning-search    # Ctrl+P
bindkey '^N'   down-line-or-beginning-search  # Ctrl+N

# ──────────────────────────────────────────────────────────────────────────
# Editor
# ──────────────────────────────────────────────────────────────────────────
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ──────────────────────────────────────────────────────────────────────────
# Prompt — minimal monochrome:  ~/path (git-branch) ❯
# ──────────────────────────────────────────────────────────────────────────
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' %F{244}(%b)%f'
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%F{252}%~%f${vcs_info_msg_0_} %F{248}❯%f '

# ──────────────────────────────────────────────────────────────────────────
# PATH
# ──────────────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/Users/Shared/DBngin/mysql/8.0.33/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"  # pipx (added 2025-05-07)

# ──────────────────────────────────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────────────────────────────────
alias ide="ide.sh"

# ──────────────────────────────────────────────────────────────────────────
# Python venvs
#   mkvenv myvirtualenv  - create
#   venv   myvirtualenv  - activate
#   deactivate           - deactivate
#   rmvenv myvirtualenv  - delete
#   lsvenv               - list
# ──────────────────────────────────────────────────────────────────────────
export VENV_HOME="$HOME/.virtualenvs"
[[ -d $VENV_HOME ]] || mkdir "$VENV_HOME"

lsvenv() { ls -1 "$VENV_HOME"; }

venv() {
  if [ $# -eq 0 ]; then
    echo "Please provide venv name"
  else
    source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [ $# -eq 0 ]; then
    echo "Please provide venv name"
  else
    python3 -m venv "$VENV_HOME/$1"
  fi
}

rmvenv() {
  if [ $# -eq 0 ]; then
    echo "Please provide venv name"
  else
    rm -r "$VENV_HOME/$1"
  fi
}

# ──────────────────────────────────────────────────────────────────────────
# nvm
# ──────────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source /Users/codystubbs/.config/op/plugins.sh

# direnv — auto-loads per-project .envrc on cd. Used by wx to scope
# SENTRY_AUTH_TOKEN to the wx tree only (no biometric prompt on
# unrelated terminals/tmux panes).
eval "$(direnv hook zsh)"
