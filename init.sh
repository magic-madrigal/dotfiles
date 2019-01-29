
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
# - amethyst                https://github.com/ianyh/Amethyst
# - signal                  https://github.com/signalapp
# - tmux settings           https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

# Configuration
# -------------
REPO_DIR="~/Repos"
HOMEBREW="https://raw.githubusercontent.com/Homebrew/install/master/install"
COLOUR_THEMES="https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master"

# Add brew cask mac apps here!!! - https://github.com/caskroom/homebrew-cask/tree/master/Casks
brewCaskApps=( 
  amethyst 
  postman 
  irvue 
  iterm2 
  font-fira-code 
  font-roboto-mono 
  dash 
  signal 
  evernote 
  google-chrome 
  mkchromecast 
  kitematic 
  kitty 
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
)

# Functions
# ---------

ascii_font() {
  echo ' __    __     ______     ______     __     ______    '
  echo '/\ "-./  \   /\  __ \   /\  ___\   /\ \   /\  ___\   '
  echo '\ \ \-./\ \  \ \  __ \  \ \ \__ \  \ \ \  \ \ \____  '
  echo ' \ \_\ \ \_\  \ \_\ \_\  \ \_____\  \ \_\  \ \_____\ '
  echo '  \/_/  \/_/   \/_/\/_/   \/_____/   \/_/   \/_____/ '
  echo '                                                     '
}


homebrew_install() {
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
  for i in "${depPkgs[@]}"
  do
     :
     # Checking if package is installed
     if hash $i 2>/dev/null; then
       echo "$i is already insalled ✓"
     else
       echo "It seems you don't have $i installed."
       echo
       read -p "Install $i ? (y/n) " -n 1 answer
       echo
       if [[ $answer == "y" || $answer == "Y" ]]; then
         # Installing package
         $INSTALL_CMD install $i
       fi
     fi
  done
}

other_package_install() {
  for i in "${otherPkgs[@]}"
  do
     :
     # Checking if package is installed
     if hash $i 2>/dev/null; then
       echo "$i is already insalled ✓"
     else
       echo "It seems you don't have $i installed."
       echo
       read -p "Install $i ? (y/n) " -n 1 answer
       echo
       if [[ $answer == "y" || $answer == "Y" ]]; then
         # Installing package
         $INSTALL_CMD install $i
       fi
     fi
  done
}

node_install() {
  echo "It seems you don't have Node installed."
  echo
  read -p "Install Node? (y/n) " -n 1 answer
  echo
  }

dependants_install() {

  # Check for and install script dependant packages
  echo "Installing script dependants / fun commands..."
  dep_package_install

  # Check if repo directory is created
  if [ -d "$REPO_DIR" ]; then
    echo "Repo directory is already created ✓"
  else
    mkdir $REPO_DIR
  fi

  # Check if dotfiles directory is created
  if [ -d "$REPO_DIR/dotfiles" ]; then
    echo "dotfiles directory is already created ✓"
  else
    git clone https://github.com/magic-madrigal/dotfiles $REPO_DIR
  fi

  # Check if config directory is created
  if [ -d "~/.confg" ]; then
    echo "config directory is already created ✓"
    else
      mkdir ~/.config
    fi

  # Check if fish directory is created
  if [ -d "~/.config/fish" ]; then
    echo "fish directory is already created ✓"
  else
    mkdir ~/.config/fish
  fi

  echo
  read -p "Create symlinks for all dotfiles? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y"  ]]; then
    ln -s ~/$REPO_DIR/dotfiles/hub                        ~/hub
    ln -s ~/$REPO_DIR/dotfiles/tmux.conf                  ~/.tmux.conf
    ln -s ~/$REPO_DIR/dotfiles/vimrc                      ~/.vimrc
    ln -s ~/$REPO_DIR/dotfiles/config/fish/config.fish    ~/config/fish/config.fish
    ln -s ~/$REPO_DIR/dotfiles/config/git/config          ~/config/git/config
    ln -s ~/$REPO_DIR/dotfiles/config/git/ignore          ~/config/git/ignore
    ln -s ~/$REPO_DIR/dotfiles/config/ranger/rc.conf      ~/config/ranger/rc.conf
    ln -s ~/$REPO_DIR/dotfiles/config/ranger/scope.conf   ~/config/ranger/scope.conf
    ln -s ~/$REPO_DIR/dotfiles/config/omf                 ~/config/omf
  fi

  read -p "Install Powerline Fonts ? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD install fontconfig
    cp /usr/local/etc/fonts/fonts.conf.bak /usr/local/etc/fonts/fonts.conf

    git clone https://github.com/powerline/fonts.git ./fonts
    ./fonts/install.sh
  fi
}

dev_env_install() {
  # Check if VIM Plug is installed
  if [ -f ~/.vim/autoload/plug.vim ]; then
    echo "Vim Plug is already insalled ✓"
  else
    echo "Installing Vim Plug and Plugins"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +slient +VimEnter +PlugInstall +qall
  fi


  # Install Ruby
  read -p "Install Ruby and rbenv? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/rbenv ]; then
      echo "Ruby & rbenv is already insalled ✓"
    else
      brew install rbenv
      rbenv install 2.3.3
      rbenv global 2.3.3
    fi
  fi

  # Install Node
  read -p "Install Node and nvm? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    if [ -x /usr/local/bin/node ]; then
      echo "Node is already insalled ✓"
    else
      $INSTALL_CMD install nvm
      mkdir ~/.nvm
      nvm install node@8
    fi
  fi

  # Checking for AWS CLI
  if [ -x /usr/local/bin/aws ]; then
    echo "AWS CLI is already insalled ✓"
  else
    $INSTALL_CMD install awscli
    echo "Don't forget to run aws configure!!!" | lolcat
  fi
}

fish_install() {
  read -p "Install Fish Shell ? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    $INSTALL_CMD install fish --HEAD

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

  # Welcome Banner
  ascii_font

  read -p "Are you installing on a mac or linux? (m/l) " -n 1 answer
  echo
  if [[ $answer == "m" || $answer == "M" ]]; then
    OS=MAC
    INSTALL_CMD=brew
    homebrew_install
    dependants_install
    other_package_install
    dev_env_install
    brewcask_install
    fish_install
  fi

  if [[ $answer == "l" || $answer == "L" ]]; then
    OS=LINUX
    INSTALL_CMD=apt-get
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
