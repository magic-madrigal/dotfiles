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
# - Oh My Fish              https://github.com/oh-my-fish
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

depPkgs=(
  lolcat
  cowsay
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
)

otherPkgs=(
  irssi
  htop
  gtop
  ncdu
  ollama
)

# Functions
# ---------

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
    echo "Auto Pilot ACTIVATED!!" | lolcat
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
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing all dep packages"
  fi

  for i in "${depPkgs[@]}"
  do
    :
    # Checking if package is installed
    if hash $i 2>/dev/null; then
      echo "$i is already insalled ✓"
    else
      echo

      # Checking Autopilot
      if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
        answer=Y
      else 
        echo
        echo "It seems you don't have $i installed."
        echo
        read -p "Install $i ? (y/n) " -n 1 answer
        echo
      fi

      if [[ $answer == "y" || $answer == "Y" ]]; then
        # Installing package
        $INSTALL_CMD $i
      fi
    fi
  done
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
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Other Stuff 0_o"
  fi

  for i in "${otherPkgs[@]}"
  do
    :
    # Checking if package is installed
    if hash $i 2>/dev/null; then
      echo "$i is already insalled ✓"
    else
      echo
      # Checking Autopilot
      if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
        answer=Y
      else       
        echo
        echo "It seems you don't have $i installed."
        echo
        read -p "Install $i ? (y/n) " -n 1 answer
        echo
      fi

      if [[ $answer == "y" || $answer == "Y" ]]; then
        # Installing package
        $INSTALL_CMD $i
      fi
    fi
  done
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
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Creating Symlinks!"
    answer=Y
  else
    echo
    read -p "Create symlinks for all dotfiles? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y"  ]]; then
    ln -sf "$REPO_DIR/dotfiles/hub"                             "${HOME}/.hub"
    ln -sf "$REPO_DIR/dotfiles/tmux.conf"                       "${HOME}/.tmux.conf"
    ln -sf "$REPO_DIR/dotfiles/vimrc"                           "${HOME}/.vimrc"
    ln -sf "$REPO_DIR/dotfiles/ssh_config"                      "${HOME}/.ssh/config"
    ln -sf "$REPO_DIR/dotfiles/config/fish/config.fish"         "${HOME}/.config/fish/config.fish"
    ln -sf "$REPO_DIR/dotfiles/config/fish/terminal_sunday.sh"  "${HOME}/.config/fish/terminal_sunday.sh"
    ln -sf "$REPO_DIR/dotfiles/config/fish/completions"         "${HOME}/.config/fish/completions"
    ln -sf "$REPO_DIR/dotfiles/config/fish/functions/"          "${HOME}/.config/fish/functions"
    ln -sf "$REPO_DIR/dotfiles/config/git/config"               "${HOME}/.config/git/config"
    ln -sf "$REPO_DIR/dotfiles/config/git/ignore"               "${HOME}/.config/git/ignore"
    ln -sf "$REPO_DIR/dotfiles/config/ranger/rc.conf"           "${HOME}/.config/ranger/rc.conf"
    ln -sf "$REPO_DIR/dotfiles/config/ranger/scope.conf"        "${HOME}/.config/ranger/scope.conf"
    ln -sf "$REPO_DIR/dotfiles/config/omf"                      "${HOME}/.config/omf"

    chmod +x "$HOME/.config/fish/terminal_sunday.sh"
  fi

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Fonts!"
    answer=Y
  else
    read -p "Install Powerline & Nerd Fonts? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD fontconfig
    cp /usr/local/etc/fonts/fonts.conf.bak /usr/local/etc/fonts/fonts.conf

    git clone https://github.com/powerline/fonts.git ./fonts
    ./fonts/install.sh

    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ./.nerdfonts
    ./.nerdfonts/install.sh
  fi

  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Starship!"
    answer=Y
  else
    read -p "Install starship cross shell prompt? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    curl -sS https://starship.rs/install.sh | sh
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
    vim +slient +VimEnter +PlugInstall +qall
  fi

  # Setup Github keys and tokens
  echo
  echo
  echo "$(cat ${REPO_DIR}/dotfiles/misc/octocat.asciiart)"
  echo
  echo
  echo 'Setting up 1Password Agent'
  echo 
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

  # Install Pyenv
  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Pyenv!"
    answer=Y
  else
    echo
    read -p "Install Python and pyenv? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/pyenv ]; then
      echo "Python & pyenv is already insalled ✓"
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
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Node!"
    answer=Y
  else
    echo
    read -p "Install Node and nvm? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/node ]; then
      echo "Node is already insalled ✓"
    else
      $INSTALL_CMD nvm
      mkdir ~/.nvm
      # nvm install node@8
      npm i -g semantic-git-commit-cli
    fi
  fi

  # Install docker
  if [[ $AUTO == "y" || $AUTO == "Y" ]]; then
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing docker & docker-compose!"
    answer=Y
  else
    echo
    read -p "Install docker and docker-compose? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/docker ]; then
      echo "docker is already insalled ✓"
    else
      $INSTALL_CMD docker
      $INSTALL_CMD docker-compose
      
      if [[$OS != "MAC"]]; then
        read -p "What is the name of the user you would like to add to the docker group? " username
        usermod -aG docker ${username}
      fi
    fi
  fi

 
  # Checking for AWS CLI
  echo
  if [ -x /usr/local/bin/aws ]; then
    echo "AWS CLI is already insalled ✓"
  else
    $INSTALL_CMD awscli
    echo "Don't forget to run aws configure!!!" | lolcat
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
    echo "Auto Pilot ACTIVATED!!" | lolcat
    echo "Installing Fish Shell!"
    answer=Y
  else
    read -p "Install Fish Shell and make it your default shell ? (y/n) " -n 1 answer
    echo
  fi

  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD fish

    echo

    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

    echo "updating Fisher ...." | lolcat

    fish -c "fisher up"

    curl -L https://get.oh-my.fish | fish
    fish -c "omf update"
    
    echo 
    echo "Making Fish the default shell" | lolcat
    sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
    chsh -s `which fish`
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
    echo "These settings don't take effect until you log back in" | lolcat
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

  # Mac OS
  if [[ $answer == "1" ]]; then
    OS=MAC
    INSTALL_CMD="brew install"
    homebrew_install
    dependants_install
    other_package_install
    dev_env_install
    brewcask_install
    mac_install
    fish_install
  fi

  # Ubuntu or debian system
  if [[ $answer == "2" ]]; then
    OS=LINUX
    INSTALL_CMD="apt-get install"
    dependants_install
    other_package_install
    dev_env_install
    fish_install
  fi

  # Arch Linux
  if [[ $answer == "3" ]]; then
    OS=LINUX
    INSTALL_CMD="pacman -S"
    dependants_install
    other_package_install
    dev_env_install
    fish_install
  else
    echo "OS not supported!"
  fi

echo "Setup finished!! For further information I recommend reading the Fish Shell documentation." | lolcat | cowsay -f tux
echo
read -p "Should I open the Fish Shell Documentation for you ? (y/n) " -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y" ]]; then
  open http://fishshell.com/docs/current/
fi
echo
echo "Don't forget to reboot! ;-)" | lolcat
echo "closing ..."
}

main
