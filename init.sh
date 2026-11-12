#!/usr/bin/env bash

# Author    Magic Madrigal
# Github    https://github.com/magic-madrigal
#
# Information
# -----------
# Shell script to automate the installation of essential software \O/

# Links
# -----
# - Homebrew Website:       http://brew.sh/
# - iTerm2 Website:         https://www.iterm2.com/
# - iTerm2 Colour Schemes:  http://iterm2colorschemes.com/
# - Fish Shell:             https://fishshell.com/
# - Fisherman:              http://fisherman.sh/
# - Powerline Fonts:        https://github.com/powerline/fonts
# - Node                    https://nodejs.org/en/
# - rbenv                   https://github.com/rbenv/rbenv
# - Better Touch Tool       https://folivora.ai/
# - signal                  https://github.com/signalapp
# - tmux settings           https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

# Configuration
# -------------
REPO_DIR="${HOME}/Repos"
HOMEBREW="https://raw.githubusercontent.com/Homebrew/install/master/install"
COLOUR_THEMES="https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master"

# Add brew cask mac apps here!!! - https://github.com/caskroom/homebrew-cask/tree/master/Casks
brewCaskApps=(
  1password
  1password-cli
  balenaetcher
  bettertouchtool
  dash
  discord
  etrecheckpro
  flux
  font-fira-code
  font-roboto-mono
  google-cloud-sdk
  google-chrome
  grammarly
  iterm2
  mkchromecast
  obsidian
  postman
  rekordbox
  signal
  slack
  spotify
  visual-studio-code
  vlc
  whatsapp
  zoom
)

# Package lists per OS. Names are package names; is_installed() checks the
# package manager, so names don't need to match the command they provide.
macDepPkgs=(
  lolcat
  cowsay
  derailed/k9s/k9s
  fortune
  thefuck
  figlet
  git
  hub
  tmux
  ranger
  highlight
  neofetch
  wget
  atuin
)

macOtherPkgs=(
  irssi
  htop
  gtop
  ncdu
  ollama
)

# Ubuntu/Debian: apt only. atuin, k9s, ollama, gtop are installed by
# linux_extras_install() since they're not in the apt repos.
aptDepPkgs=(
  lolcat
  cowsay
  fortune-mod
  figlet
  git
  hub
  tmux
  ranger
  highlight
  neofetch
  wget
  curl
  unzip
)

aptOtherPkgs=(
  irssi
  htop
  ncdu
)

archDepPkgs=(
  lolcat
  cowsay
  fortune-mod
  figlet
  git
  hub
  tmux
  ranger
  highlight
  fastfetch
  wget
  curl
  unzip
  atuin
  k9s
)

archOtherPkgs=(
  irssi
  htop
  ncdu
  ollama
)

# Nerd Fonts to install (release archive names from github.com/ryanoasis/nerd-fonts)
nerdFonts=(
  FiraCode
  RobotoMono
)

# lolcat/cowsay live in /usr/games on Debian, which isn't always on PATH
export PATH="$PATH:/usr/games"

# Functions
# ---------

# Rainbow output when lolcat is available, plain otherwise
rainbow() {
  if command -v lolcat &>/dev/null; then lolcat; else cat; fi
}

# Cowsay when available, plain otherwise
cow() {
  if command -v cowsay &>/dev/null; then cowsay -f tux; else cat; fi
}

is_auto() {
  [[ $AUTO == "y" || $AUTO == "Y" ]]
}

# Is a package installed? Asks the package manager, falls back to the command name.
is_installed() {
  local pkg="$1"
  case "$PKG_MGR" in
    apt)    dpkg -s "$pkg" &>/dev/null && return 0 ;;
    pacman) pacman -Q "$pkg" &>/dev/null && return 0 ;;
    brew)   brew list "$pkg" &>/dev/null && return 0 ;;
  esac
  hash "${pkg##*/}" 2>/dev/null
}

# Install every package in the given list, prompting unless on auto pilot
install_pkg_list() {
  local i answer
  for i in "$@"; do
    if is_installed "$i"; then
      echo "$i is already insalled ✓"
      continue
    fi

    if is_auto; then
      answer=Y
    else
      echo
      echo "It seems you don't have $i installed."
      echo
      read -p "Install $i ? (y/n) " -n 1 answer
      echo
    fi

    if [[ $answer == "y" || $answer == "Y" ]]; then
      $INSTALL_CMD "$i"
    fi
  done
}

# Ask a y/n question; auto pilot answers yes. Usage: ask "Question?" && do_thing
ask() {
  local answer
  if is_auto; then
    return 0
  fi
  echo
  read -p "$1 (y/n) " -n 1 answer
  echo
  [[ $answer == "y" || $answer == "Y" ]]
}

welcome() {
  echo ' __    __     ______     ______     __     ______    '
  echo '/\ "-./  \   /\  __ \   /\  ___\   /\ \   /\  ___\   '
  echo '\ \ \-./\ \  \ \  __ \  \ \ \__ \  \ \ \  \ \ \____  '
  echo ' \ \_\ \ \_\  \ \_\ \_\  \ \_____\  \ \_\  \ \_____\ '
  echo '  \/_/  \/_/   \/_/\/_/   \/_____/   \/_/   \/_____/ '
  echo '                                                     '
}


homebrew_install() {
  echo
  echo
  echo '     ___           ___           ___           ___           ___           ___           ___           ___     '
  echo '    /\__\         /\  \         /\__\         /\  \         /\  \         /\  \         /\  \         /\__\    '
  echo '   /:/  /        /::\  \       /::|  |       /::\  \       /::\  \       /::\  \       /::\  \       /:/ _/_   '
  echo '  /:/__/        /:/\:\  \     /:|:|  |      /:/\:\  \     /:/\:\  \     /:/\:\  \     /:/\:\  \     /:/ /\__\  '
  echo ' /::\  \ ___   /:/  \:\  \   /:/|:|__|__   /::\~\:\  \   /::\~\:\__\   /::\~\:\  \   /::\~\:\  \   /:/ /:/ _/_ '
  echo '/:/\:\  /\__\ /:/__/ \:\__\ /:/ |::::\__\ /:/\:\ \:\__\ /:/\:\ \:|__| /:/\:\ \:\__\ /:/\:\ \:\__\ /:/_/:/ /\__\'
  echo '\/__\:\/:/  / \:\  \ /:/  / \/__/~~/:/  / \:\~\:\ \/__/ \:\~\:\/:/  / \/_|::\/:/  / \:\~\:\ \/__/ \:\/:/ /:/  /'
  echo '     \::/  /   \:\  /:/  /        /:/  /   \:\ \:\__\    \:\ \::/  /     |:|::/  /   \:\ \:\__\    \::/_/:/  / '
  echo '     /:/  /     \:\/:/  /        /:/  /     \:\ \/__/     \:\/:/  /      |:|\/__/     \:\ \/__/     \:\/:/  /  '
  echo '    /:/  /       \::/  /        /:/  /       \:\__\        \::/__/       |:|  |        \:\__\        \::/  /   '
  echo '    \/__/         \/__/         \/__/         \/__/         ~~            \|__|         \/__/         \/__/    '
  echo
  echo

  # Check if Homebrew is installed
  if [ -x /usr/local/bin/brew ]; then
    echo "Homebrew is already insalled ✓"
    else
      echo "It seems you don't have Homebrew installed."
      echo
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo "updating Homebrew ..."
      brew update
      brew upgrade
      echo "installing caskroom"
      brew tap homebrew/cask
      brew tap homebrew/cask-fonts
      brew update
      echo "Homebrew and Caskroom insalled ✓"
    fi
}

brewcask_install() {
  echo
  echo
  echo ' ▄▄·  ▄▄▄· .▄▄ · ▄ •▄ .▄▄ · '
  echo '▐█ ▌▪▐█ ▀█ ▐█ ▀. █▌▄▌▪▐█ ▀. '
  echo '██ ▄▄▄█▀▀█ ▄▀▀▀█▄▐▀▀▄·▄▀▀▀█▄'
  echo '▐███▌▐█ ▪▐▌▐█▄▪▐█▐█.█▌▐█▄▪▐█'
  echo '·▀▀▀  ▀  ▀  ▀▀▀▀ ·▀  ▀ ▀▀▀▀ '
  echo
  echo

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing all Casks"
  fi

  for i in "${brewCaskApps[@]}"
  do
    :
    # Checking cask app
    if brew list $i --cask; then
      echo "$i is already insalled ✓"
    else
      echo "It seems you don't have $i installed."
      echo

      # Checking Autopilot
      if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
      answer=Y
      else
      echo
      read -p "Install $i ? (y/n) " -n 1 answer
      echo
      fi

      # Installing cask app
      if [[ $answer == "y" || $answer == "Y" ]]; then
        brew install $i --cask
        if [[ $i == "bettertouchtool" ]]; then
          cp ${HOME}/.config/btt/Default.bttpreset  ~/Library/Application\ Support/BetterTouchTool/Default.bttpreset
        fi
      fi
    fi
  done
}

dep_package_install() {
  echo
  echo
  echo '┌┬┐┌─┐┌─┐  ┌─┐┌─┐┌─┐┬┌─┌─┐┌─┐┌─┐┌─┐'
  echo ' ││├┤ ├─┘  ├─┘├─┤│  ├┴┐├─┤│ ┬├┤ └─┐'
  echo '─┴┘└─┘┴    ┴  ┴ ┴└─┘┴ ┴┴ ┴└─┘└─┘└─┘'
  echo
  echo

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing all dep packages"
  fi

  install_pkg_list "${depPkgs[@]}"
}

other_package_install() {
  echo
  echo
  echo '┌─┐┌┬┐┬ ┬┌─┐┬─┐  ┌─┐┌┬┐┬ ┬┌─┐┌─┐'
  echo '│ │ │ ├─┤├┤ ├┬┘  └─┐ │ │ │├┤ ├┤ '
  echo '└─┘ ┴ ┴ ┴└─┘┴└─  └─┘ ┴ └─┘└  └  '
  echo
  echo

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Other Stuff 0_o"
  fi

  install_pkg_list "${otherPkgs[@]}"
}

# Tools that aren't in the Ubuntu/Debian apt repos, installed from upstream
linux_extras_install() {
  echo
  echo "Installing tools that apt doesn't carry..." | rainbow
  echo

  if command -v atuin &>/dev/null || [ -x "$HOME/.atuin/bin/atuin" ]; then
    echo "atuin is already insalled ✓"
  elif ask "Install atuin (shell history)?"; then
    # --no-modify-path: config.fish already handles atuin init
    curl --proto '=https' --tlsv1.2 -LsSf \
      https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | sh -s -- --no-modify-path
  fi

  if command -v k9s &>/dev/null; then
    echo "k9s is already insalled ✓"
  elif ask "Install k9s?"; then
    local arch tmp
    arch=$(dpkg --print-architecture)
    tmp=$(mktemp -d)
    curl -fsSLo "$tmp/k9s.deb" "https://github.com/derailed/k9s/releases/latest/download/k9s_linux_${arch}.deb" \
      && sudo apt-get install -y "$tmp/k9s.deb"
    rm -rf "$tmp"
  fi

  if command -v ollama &>/dev/null; then
    echo "ollama is already insalled ✓"
  elif ask "Install ollama?"; then
    curl -fsSL https://ollama.com/install.sh | sh
  fi
}

dependants_install() {
  echo
  echo
  echo '██████╗ ███████╗██████╗ ███████╗███╗   ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗███████╗███████╗'
  echo '██╔══██╗██╔════╝██╔══██╗██╔════╝████╗  ██║██╔══██╗██╔════╝████╗  ██║██╔════╝██║██╔════╝██╔════╝'
  echo '██║  ██║█████╗  ██████╔╝█████╗  ██╔██╗ ██║██║  ██║█████╗  ██╔██╗ ██║██║     ██║█████╗  ███████╗'
  echo '██║  ██║██╔══╝  ██╔═══╝ ██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██║╚██╗██║██║     ██║██╔══╝  ╚════██║'
  echo '██████╔╝███████╗██║     ███████╗██║ ╚████║██████╔╝███████╗██║ ╚████║╚██████╗██║███████╗███████║'
  echo '╚═════╝ ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝╚══════╝╚══════╝'
  echo
  echo


  # Check for and install script dependant packages
  echo "Installing script dependancies / fun commands..."
  dep_package_install

  echo
  echo "Script Dependancies Completed!!"
  echo

  # Check if repo directory is created
  if [ -d "$REPO_DIR" ]; then
    echo "Repo directory is already created ✓"
  else
    echo
    echo "Createing Repo Directory"
    echo
    mkdir "$REPO_DIR"
  fi

  # Check if dotfiles directory is created
  if [ -d "${REPO_DIR}/dotfiles" ]; then
    echo "dotfiles directory is already created ✓"
  else
    echo
    echo "Cloneing dotfiles repo!"
    echo
    git clone https://github.com/magic-madrigal/dotfiles $REPO_DIR/dotfiles
  fi

  # Check if config directory is created
  if [ -d "${HOME}/.config" ]; then
    echo "config directory is already created ✓"
  else
    mkdir "${HOME}/.config"
    echo "Made .config directory ✓"
  fi

  # Check if fish directory is created
  if [ -d "${HOME}/.config/fish" ]; then
    echo "fish directory is already created ✓"
  else
    mkdir "${HOME}/.config/fish"
    mkdir "${HOME}/.config/fish/functions"
    touch "${HOME}/.config/reddit.fish"
    touch "${HOME}/.config/artifactory.fish"
    echo "Made .config/fish directory ✓"
  fi

  # Check if git directory is created
  if [ -d "${HOME}/.config/git" ]; then
    echo "git directory is already created ✓"
  else
    mkdir "${HOME}/.config/git"
    echo "Made .config/git directory ✓"
  fi

  # Check if ranger directory is created
  if [ -d "${HOME}/.config/ranger" ]; then
    echo "ranger directory is already created ✓"
  else
    mkdir "${HOME}/.config/ranger"
    echo "Made .config/ranger directory ✓"
  fi

  # Check if ssh directory is created
  if [ -d "${HOME}/.ssh" ]; then
    echo ".ssh directory is already created ✓"
  else
    mkdir "${HOME}/.ssh"
    echo "Made .ssh directory ✓"
  fi

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Creating Symlinks!"
    answer=Y
  else
    echo
    read -p "Create symlinks for all dotfiles? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y"  ]]; then
    ln -sfn "$REPO_DIR/dotfiles/hub"                             "${HOME}/.hub"
    ln -sfn "$REPO_DIR/dotfiles/tmux.conf"                       "${HOME}/.tmux.conf"
    ln -sfn "$REPO_DIR/dotfiles/vimrc"                           "${HOME}/.vimrc"
    ln -sfn "$REPO_DIR/dotfiles/ssh_config"                      "${HOME}/.ssh/config"
    ln -sfn "$REPO_DIR/dotfiles/config/fish/config.fish"         "${HOME}/.config/fish/config.fish"
    ln -sfn "$REPO_DIR/dotfiles/config/fish/terminal_sunday.sh"  "${HOME}/.config/fish/terminal_sunday.sh"
    ln -sfn "$REPO_DIR/dotfiles/config/fish/completions"         "${HOME}/.config/fish/completions"
    ln -sfn "$REPO_DIR/dotfiles/config/fish/functions/"          "${HOME}/.config/fish/functions"
    ln -sfn "$REPO_DIR/dotfiles/config/git/config"               "${HOME}/.config/git/config"
    ln -sfn "$REPO_DIR/dotfiles/config/git/ignore"               "${HOME}/.config/git/ignore"
    ln -sfn "$REPO_DIR/dotfiles/config/ranger/rc.conf"           "${HOME}/.config/ranger/rc.conf"
    ln -sfn "$REPO_DIR/dotfiles/config/ranger/scope.conf"        "${HOME}/.config/ranger/scope.conf"
    ln -sfn "$REPO_DIR/dotfiles/config/starship.toml"            "${HOME}/.config/starship.toml"


    chmod +x "$HOME/.config/fish/terminal_sunday.sh"
  fi

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Fonts!"
    answer=Y
  else
    read -p "Install Powerline & Nerd Fonts? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    local font_tmp font_dir font
    $INSTALL_CMD fontconfig

    if [[ $OS == "MAC" ]]; then
      font_dir="$HOME/Library/Fonts"
    else
      font_dir="$HOME/.local/share/fonts"
    fi
    mkdir -p "$font_dir"

    # Work in a temp dir so nothing gets cloned into the current directory
    font_tmp=$(mktemp -d)

    git clone --depth 1 https://github.com/powerline/fonts.git "$font_tmp/powerline" \
      && "$font_tmp/powerline/install.sh"

    for font in "${nerdFonts[@]}"; do
      echo "Installing $font Nerd Font"
      mkdir -p "$font_dir/$font"
      curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz" \
        | tar -xJ -C "$font_dir/$font"
    done

    rm -rf "$font_tmp"
    command -v fc-cache &>/dev/null && fc-cache -f "$font_dir"
  fi

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Starship!"
    answer=Y
  else
    read -p "Install starship cross shell prompt? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if command -v starship &>/dev/null; then
      echo "starship is already insalled ✓"
    elif is_auto; then
      curl -sS https://starship.rs/install.sh | sh -s -- -y
    else
      curl -sS https://starship.rs/install.sh | sh
    fi
  fi
}

dev_env_install() {
  echo
  echo
  echo ' _______                              ________                      '
  echo '/       \                            /        |                     '
  echo '$$$$$$$  |  ______   __     __       $$$$$$$$/  _______   __     __ '
  echo '$$ |  $$ | /      \ /  \   /  |      $$ |__    /       \ /  \   /  |'
  echo '$$ |  $$ |/$$$$$$  |$$  \ /$$/       $$    |   $$$$$$$  |$$  \ /$$/ '
  echo '$$ |  $$ |$$    $$ | $$  /$$/        $$$$$/    $$ |  $$ | $$  /$$/  '
  echo '$$ |__$$ |$$$$$$$$/   $$ $$/         $$ |_____ $$ |  $$ |  $$ $$/   '
  echo '$$    $$/ $$       |   $$$/          $$       |$$ |  $$ |   $$$/    '
  echo '$$$$$$$/   $$$$$$$/     $/           $$$$$$$$/ $$/   $$/     $/     '
  echo
  echo

  # Check if VIM Plug is installed
  echo
  echo
  echo "$(cat ${REPO_DIR}/dotfiles/misc/vim.logo.colored.asciiart)"
  echo
  echo
  if [ -f ~/.vim/autoload/plug.vim ]; then
    echo "Vim Plug is already insalled ✓"
  else
    echo "Installing Vim Plug and Plugins"
    $INSTALL_CMD vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +silent +VimEnter +PlugInstall +qall
  fi

  # Setup Github keys and tokens
  echo
  echo
  echo "$(cat ${REPO_DIR}/dotfiles/misc/octocat.asciiart)"
  echo
  echo
  echo 'Setting up 1Password Agent'
  echo
  if [[ $OS == "MAC" ]]; then
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  else
    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
  fi
  [ -S "$SSH_AUTH_SOCK" ] || echo "1Password SSH agent socket not found yet — enable it in 1Password > Settings > Developer"

  # Install Pyenv
  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Pyenv!"
    answer=Y
  else
    echo
    read -p "Install Python and pyenv? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if command -v pyenv &>/dev/null || [ -d "$HOME/.pyenv" ]; then
      echo "Python & pyenv is already insalled ✓"
    elif [[ $PKG_MGR == "apt" ]]; then
      # pyenv isn't in apt; use the official installer (plus python build deps)
      $INSTALL_CMD build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
      curl -fsSL https://pyenv.run | bash
    else
      $INSTALL_CMD pyenv
      # pyenv install 3.10.4
      # pyenv global 3.10.4
    fi
  fi

  # # Install Ruby
  # echo
  # read -p "Install Ruby and rbenv? (y/n) " -n 1 answer
  # echo
  # if [[ $answer == "y" || $answer == "Y" ]]; then
  #   if [ -x /usr/local/bin/rbenv ]; then
  #     echo "Ruby & rbenv is already insalled ✓"
  #   else
  #     $INSTALL_CMD rbenv
  #     rbenv install 2.3.3
  #     rbenv global 2.3.3
  #   fi
  # fi

  # Install Node
  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Node!"
    answer=Y
  else
    echo
    read -p "Install Node and nvm? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if command -v node &>/dev/null; then
      echo "Node is already insalled ✓"
    else
      export NVM_DIR="$HOME/.nvm"
      mkdir -p "$NVM_DIR"
      if [[ $OS == "MAC" ]]; then
        $INSTALL_CMD nvm
        source "$(brew --prefix nvm)/nvm.sh"
      else
        # PROFILE=/dev/null: don't let the installer edit shell rc files
        curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash
        source "$NVM_DIR/nvm.sh"
      fi
      nvm install --lts
      npm i -g semantic-git-commit-cli
      # gtop isn't packaged for apt; it's an npm tool
      [[ $PKG_MGR == "apt" ]] && npm i -g gtop
    fi
  fi

  # Install docker
  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing docker & docker-compose!"
    answer=Y
  else
    echo
    read -p "Install docker and docker-compose? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if command -v docker &>/dev/null; then
      echo "docker is already insalled ✓"
    else
      case "$PKG_MGR" in
        apt)    $INSTALL_CMD docker.io docker-compose-v2 ;;
        pacman) $INSTALL_CMD docker docker-compose ;;
        brew)   $INSTALL_CMD docker docker-compose ;;
      esac
    fi

    if [[ $OS != "MAC" ]] && ! id -nG "$USER" | grep -qw docker; then
      sudo usermod -aG docker "$USER"
      echo "Added $USER to the docker group (log out and back in to apply)"
    fi
  fi


  # Checking for AWS CLI
  echo
  if command -v aws &>/dev/null; then
    echo "AWS CLI is already insalled ✓"
  elif ask "Install AWS CLI?"; then
    case "$PKG_MGR" in
      apt)
        # awscli isn't in apt anymore; use the official v2 installer
        local aws_tmp
        aws_tmp=$(mktemp -d)
        curl -fsSLo "$aws_tmp/awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" \
          && unzip -q "$aws_tmp/awscliv2.zip" -d "$aws_tmp" \
          && sudo "$aws_tmp/aws/install"
        rm -rf "$aws_tmp"
        ;;
      pacman) $INSTALL_CMD aws-cli ;;
      brew)   $INSTALL_CMD awscli ;;
    esac
    echo "Don't forget to run aws configure!!!" | rainbow
  fi
}


fish_install() {

  echo '
        ___
   ___======____=---=)
 /T            \_--===)
 [ \ (0)   \~    \_-==)
  \      / )J~~    \-=)
   \\\\___/  )JJ~~~   \)
    \_____/JJ~~~~~    \\
    / \  , \J~~~~~     \\
   (-\)\=|\\\\\~~~~       L__
   (\\\\)  (\\\\\)_           \==__
    \V    \\\\\) ===_____   \\\\\\\\\\\\
           \V)     \_) \\\\\\\\JJ\J\)
                       /J\JT\JJJJ)
                       (JJJ| \UUU)
                        (UU)'

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | rainbow
    echo "Installing Fish Shell!"
    answer=Y
  else
    read -p "Install Fish Shell and make it your default shell ? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    command -v fish &>/dev/null || $INSTALL_CMD fish

    echo

    curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
      --create-dirs -o ~/.config/fish/functions/fisher.fish

    echo "updating Fisher ...." | rainbow

    fish -c "fisher update"

    echo
    echo "Making Fish the default shell" | rainbow
    local fish_path
    fish_path=$(command -v fish)
    grep -qxF "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
    local login_shell
    if [[ $OS == "MAC" ]]; then
      login_shell=$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')
    else
      login_shell=$(getent passwd "$USER" | cut -d: -f7)
    fi
    if [[ $login_shell != "$fish_path" ]]; then
      chsh -s "$fish_path"
    else
      echo "fish is already your default shell ✓"
    fi
  fi
}

mac_install() {
  read -p "Would you like to show hidden files? (y/n)" -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    defaults write com.apple.finder AppleShowAllFiles YES
  fi

  read -p "Would you like to increate your keyboard repeat speed? (y/n)" -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    echo "These settings don't take effect until you log back in" | rainbow
  fi

  read -p "Would you like a recently used apps collection in your dock? (y/n)" -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'; killall Dock
  fi

  read -p "would you to copy your terminal setting over? (y/n)" -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    open ~/config/terminal/Magic.terminal
    defaults write com.apple.terminal "Default Window Settings" -string "Magic"
    defaults write com.apple.Terminal "Startup Window Settings" -string "Magic"
    ln -f $REPO_DIR/dotfiles/config/terminal/iTerm-profiles.json ~/Library/"Application Support"/iTerm2/DynamicProfiles/itermprofiles.json
  fi

  read -p "Would you like to add your favorite apps to your dock? (y/n)" -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Obsidian.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'

    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Signal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/WhatsApp.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/1Password.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>"/Applications/rekordbox 6/rekordbox.app"</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/zoom.us.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

    killall Dock
    # defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
    # defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
    # defaults write com.apple.menuextra.battery ShowPercent YES
    defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"
    killall SystemUIServer
  fi
}

main() {
  # Running as root puts everything in /root and changes root's shell.
  # Run as your normal user; the script calls sudo itself where needed.
  if [[ $EUID -eq 0 ]]; then
    echo "Don't run this script as root or with sudo."
    echo "Run it as your normal user: ./init.sh  (it will ask for your sudo password when needed)"
    exit 1
  fi

  clear

  # Welcome Banner
  welcome

  echo "We haven't built OS detection yet so... what are we looking at?"
  echo
  echo "(1) Mac OS"
  echo "(2) Ubuntu or other debian system"
  echo "(3) Arch Linux ~-==>"
  echo
  echo
  read -p "Pick your poison ~> " -n 1 answer
  echo
  echo
  read -p "Do you want the scipt to be on auto pilot? (y/n)" -n 1 auto
  echo

  if [[ $auto == "y" || $auto == "Y" ]]; then
    AUTO=Y
  fi

  case "$answer" in
    1) # Mac OS
      OS=MAC
      PKG_MGR=brew
      INSTALL_CMD="brew install"
      OPEN_CMD=open
      depPkgs=("${macDepPkgs[@]}")
      otherPkgs=("${macOtherPkgs[@]}")
      homebrew_install
      dependants_install
      other_package_install
      dev_env_install
      brewcask_install
      mac_install
      fish_install
      ;;
    2) # Ubuntu or debian system
      OS=LINUX
      PKG_MGR=apt
      INSTALL_CMD="sudo apt-get install -y"
      OPEN_CMD=xdg-open
      depPkgs=("${aptDepPkgs[@]}")
      otherPkgs=("${aptOtherPkgs[@]}")
      sudo apt-get update
      dependants_install
      other_package_install
      linux_extras_install
      dev_env_install
      fish_install
      ;;
    3) # Arch Linux
      OS=LINUX
      PKG_MGR=pacman
      INSTALL_CMD="sudo pacman -S --needed --noconfirm"
      OPEN_CMD=xdg-open
      depPkgs=("${archDepPkgs[@]}")
      otherPkgs=("${archOtherPkgs[@]}")
      sudo pacman -Sy
      dependants_install
      other_package_install
      dev_env_install
      fish_install
      ;;
    *)
      echo "OS not supported!"
      exit 1
      ;;
  esac

echo "Setup finished!! For further information I recommend reading the Fish Shell documentation." | rainbow | cow
echo
read -p "Should I open the Fish Shell Documentation for you ? (y/n) " -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y" ]]; then
  $OPEN_CMD http://fishshell.com/docs/current/
fi
echo
echo "Don't forget to reboot! ;-)" | rainbow
echo "closing ..."
}

main
