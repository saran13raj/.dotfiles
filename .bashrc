# Function to print the current git branch if in a repo
git_branch() {
  # Only show branch if in a git repo
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    echo "$branch"
  fi
}

# Define ANSI color codes
red='\e[31m'
blue='\e[38;5;96m'
cyan='\e[36m'
gray='\e[38;5;240m'
reset='\e[0m'
bold='\e[1m'

set_bash_prompt() {
  local exit_code=$?
  local git="$(git_branch)"
  PS1="\n${red}${reset}  ${bold}${blue}\w${reset}${bold} ${cyan} ${git}${reset} ${gray}[\t]${reset} ${red}${exit_code} ✦${reset} "
}

PROMPT_COMMAND=set_bash_prompt


###########################
# for homebrew
export PATH=/opt/homebrew/bin:$PATH

# for nvm
source /opt/homebrew/opt/nvm/nvm.sh
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# for ruby
export GEM_HOME="$HOME/.gem"
# export GEM_HOME="$HOME/lib/ruby/gems/3.3.0/bin"

# for java
export JAVA_HOME=$(/usr/libexec/java_home)

# for android studio
export ANDROID_HOME=$HOME/Library/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# for golang gin
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin

# for libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# for rebenv
# eval "$(rbenv init -)"

# for saran13raj cd
alias saran13raj='cd ~/Desktop/workspace/saran13raj'

# for tmux
alias tkill='tmux kill-server'

# for tmux vim
alias tmuxvim2='~/.config/tmux-vim.sh'
alias tmuxvim='~/.config/tmux-vim2.sh'

# for tmux fzf
alias tfzf='~/.config/tfzf.sh'

# pnpm
export PNPM_HOME="/Users/saran13raj/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# for universal-ctags
alias ctags="/opt/homebrew/Cellar/universal-ctags/p6.2.20250608.0/bin/ctags"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# for solana cli
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"


# for fzf - to use fd
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude node_modules --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# for w3m query
alias '?'='~/.config/query.sh'

# for eza
alias ls='eza -l --icons'

# for ble.sh
source -- ~/.local/share/blesh/ble.sh
