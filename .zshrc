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
### End of Zinit's installer chunk





# Plugins

# Some zsh libraries
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

# a fast prompt / theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# suggest and complete history commands 
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# completion for docker
zinit wait="1" lucid as="completion" for \
  OMZ::plugins/docker/_docker \
  OMZ::plugins/docker-compose/_docker-compose 

# completion for new *nix tools!
zinit ice mv="*.zsh -> _fzf" as="completion"
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'
zinit ice as="completion"
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/fd/_fd'
zinit ice as="completion"
zinit snippet 'https://github.com/ogham/exa/blob/master/completions/zsh/_exa'

# fast syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# use Alt+S to quickly add sudo
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
bindkey '^[s' sudo-command-line

# quick path jump by `z <keywords>...`
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# tab using fzf
#zinit light Aloxaf/fzf-tab

# Enable auto completion
autoload -Uz compinit; compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Envs
#export http_proxy=''
#export https_proxy=''

# alias
alias ls='exa'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color=auto'
#alias fd='fd-find'
alias bat='bat'
alias x='atool -x'
alias to_clipboard='xsel -i -b'
export FZF_DEFAULT_COMMAND='fd --type f'

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.local/bin:$HOME/app/bin:$HOME/.emacs.d/bin:$PATH"

# zig
export PATH="$HOME/app/zig-0.10.1:$PATH"

gpg-login() {
    export GPG_TTY=$(tty)
    echo "test" | gpg --clearsign > /dev/null 2>&1
}

# keybinding
bindkey -ar '^/' autosuggest-accept

# Functional alias
#alias dim='echo 1 | sudo tee /sys/class/backlight/intel_backlight/brightness'
#alias clash="sudo $HOME/app/clash/clash-pr -f $HOME/app/clash/config.yml"
alias docker-compose='docker compose'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR="code -n --wait"

# From https://serverfault.com/a/1064320
ssh2config() {
  host="$(ssh -G "$@" | sed -n 's/^hostname //p')"
  echo "$host"
  comm -23 <(ssh -G "$@" | sort) <(ssh -G abcddd | sort) | sed 's/^/    /'
  echo ''
}

# >>> xmake >>>
[[ -s "$HOME/.xmake/profile" ]] && source "$HOME/.xmake/profile" # load xmake profile
# <<< xmake <<<

# opam configuration
[[ ! -r /home/origami/.opam/opam-init/init.zsh ]] || source /home/origami/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
