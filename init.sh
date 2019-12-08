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
  bettertouchtool
  dash
  evernote
  font-fira-code
  font-roboto-mono
  google-chrome
  iterm2
  kitematic
  kitty
  mkchromecast
  notion
  postman
  signal
  slack
  spotify
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
)

otherPkgs=(
  irssi
  htop
  gtop
  ncdu
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
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      echo "updating Homebrew ..."
      brew update
      brew upgrade
      echo "installing caskroom"
      brew tap caskroom/cask
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

  for i in "${brewCaskApps[@]}"
  do
     :
     # Checking cask app
     if brew cask list $i; then
       echo "$i is already insalled ✓"
     else
       echo "It seems you don't have $i installed."
       echo
       read -p "Install $i ? (y/n) " -n 1 answer
       echo
       if [[ $answer == "y" || $answer == "Y" ]]; then
         # Installing cask app
         brew cask install $i
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

  for i in "${depPkgs[@]}"
  do
     :
     # Checking if package is installed
     if hash $i 2>/dev/null; then
       echo "$i is already insalled ✓"
     else
       echo
       echo
       echo "It seems you don't have $i installed."
       echo
       read -p "Install $i ? (y/n) " -n 1 answer
       echo
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

  for i in "${otherPkgs[@]}"
  do
     :
     # Checking if package is installed
     if hash $i 2>/dev/null; then
       echo "$i is already insalled ✓"
     else
       echo
       echo
       echo "It seems you don't have $i installed."
       echo
       read -p "Install $i ? (y/n) " -n 1 answer
       echo
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

  echo
  read -p "Create symlinks for all dotfiles? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y"  ]]; then
    ln -sf "$REPO_DIR/dotfiles/hub"                        "${HOME}/.hub"
    ln -sf "$REPO_DIR/dotfiles/tmux.conf"                  "${HOME}/.tmux.conf"
    ln -sf "$REPO_DIR/dotfiles/vimrc"                      "${HOME}/.vimrc"
    ln -sf "$REPO_DIR/dotfiles/config/fish/config.fish"    "${HOME}/.config/fish/config.fish"
    ln -sf "$REPO_DIR/dotfiles/config/git/config"          "${HOME}/.config/git/config"
    ln -sf "$REPO_DIR/dotfiles/config/git/ignore"          "${HOME}/.config/git/ignore"
    ln -sf "$REPO_DIR/dotfiles/config/ranger/rc.conf"      "${HOME}/.config/ranger/rc.conf"
    ln -sf "$REPO_DIR/dotfiles/config/ranger/scope.conf"   "${HOME}/.config/ranger/scope.conf"
    ln -sf "$REPO_DIR/dotfiles/config/omf"                 "${HOME}/.config/omf"
  fi

  read -p "Install Powerline Fonts ? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD fontconfig
    cp /usr/local/etc/fonts/fonts.conf.bak /usr/local/etc/fonts/fonts.conf

    git clone https://github.com/powerline/fonts.git ./fonts
    ./fonts/install.sh
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
  read -p "Would you like to setup Github? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    read -p "What is your github username? " gh_user
    echo
    echo "Hi ${gh_user}! Now let's generate a new token."
    echo
    echo "Your token must have the at least the following permissions:"
    echo
    echo " • repo - Full control of private repositories"
    echo " • admin:public_key - Full control of user public keys"
    echo
    echo "(Opening Github...)"
    sleep 3
    open https://github.com/settings/tokens/new
    echo
    read -p "Enter your newly generated token? " gh_token
    echo
    echo "Great! Now let's setup your SSH keys! \o/"
    echo
    read -p "What would you like the passphrase for you SSH key to be? " ssh_passphrase
    echo
    echo "Generating SSH Key..."
    echo
    ssh-keygen -t rsa -b 4096 -C "$gh_user" -f ${HOME}/.ssh/github_rsa -N "$ssh_passphrase"
    echo
    echo
    SSH_KEY_PUB="$(cat ${HOME}/.ssh/github_rsa.pub)"
    curl -H "Authorization: token ${gh_token}" --data '{"title":"'${HOSTNAME}'","key":"'"$(cat ${HOME}/.ssh/github_rsa.pub)"'"}' https://api.github.com/user/keys
    echo
    echo
    echo "You SSH Public Key has been added to you github account for ${HOSTNAME} ✓"
    echo
    echo "# Github Creds - Auto-Generated by dofiles script" >> ${HOME}/.config/fish/github.fish
    echo "export GITHUB_USER=$gh_user" >> ${HOME}/.config/fish/github.fish
    echo "export GITHUB_TOKEN=$gh_token" >> ${HOME}/.config/fish/github.fish
    echo
    echo "# Github Creds - Auto-Generated by dofiles script" >> ${HOME}/.bashrc
    echo "export GITHUB_USER=$gh_user" >> ${HOME}/.bashrc
    echo "export GITHUB_TOKEN=$gh_token" >> ${HOME}/.bashrc
    echo "github creds added to bashrc config ✓"
    echo
    echo
  fi

  # Install Ruby
  echo
  read -p "Install Ruby and rbenv? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/rbenv ]; then
      echo "Ruby & rbenv is already insalled ✓"
    else
      $INSTALL_CMD rbenv
      rbenv install 2.3.3
      rbenv global 2.3.3
    fi
  fi

  # Install Node
  echo
  read -p "Install Node and nvm? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/node ]; then
      echo "Node is already insalled ✓"
    else
      $INSTALL_CMD nvm
      mkdir ~/.nvm
      nvm install node@8
      npm i -g semantic-git-commit-cli
    fi
  fi

  # Install docker
  echo
  read -p "Install docker and docker-compose? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/docker ]; then
      echo "docker is already insalled ✓"
    else
      $INSTALL_CMD docker
      $INSTALL_CMD docker-compose
      read -p "What is the name of the user you would like to add to the docker group? " username
      usermod -aG docker ${username}
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

  read -p "Install Fish Shell ? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD fish

    read -p "Would you like to make fish your default shell? (y/n) " -n 1 answer
    echo
    if [[ $answer == "y" || $answer == "Y" ]]; then
      sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
      chsh -s `which fish`
    fi

    read -p "Install Fisherman ? (y/n) " -n 1 answer
    echo
    if [[ $answer == "y" || $answer == "Y" ]]; then
      curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

      echo "updating Fisher ...."
      fish -c "fisher up"

      read -p "Install Oh My Fish ? (y/n) " -n 1 answer
      echo
      if [[ $answer == "y" || $answer == "Y" ]]; then
        curl -L https://get.oh-my.fish | fish
        fish -c "omf update"
        wget https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git.fish >> ~/.config/fish/completions/git.fish
      fi
    fi
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

  # Mac OS
  if [[ $answer == "1" ]]; then
    OS=MAC
    INSTALL_CMD="brew install"
    homebrew_install
    dependants_install
    other_package_install
    dev_env_install
    brewcask_install
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
echo "closing ..."
}

main
