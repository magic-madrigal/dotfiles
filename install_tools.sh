
#!/usr/bin/env bash

# Author    Magic Madrigal
# Github    https://github.com/magic-madrigal
# Version   1.0

# Information
# -----------
# Shell script to automate the installation of key software for Waterbears team

# Links
# -----
# - Homebrew Website:       http://brew.sh/
# - iTerm2 Website:         https://www.iterm2.com/
# - iTerm2 Colour Schemes:  http://iterm2colorschemes.com/
# - Fish Shell:             https://fishshell.com/
# - Fisherman:              http://fisherman.sh/
# - Oh My Fish							https://github.com/oh-my-fish
# - Powerline Fonts:        https://github.com/powerline/fonts
# - Atom                    http://atom.io
# - Node                    https://nodejs.org/en/
# - rbenv                   https://github.com/rbenv/rbenv
# - Flow Code Checker       https://flow.org/


# Configuration
# -------------
HOMEBREW="https://raw.githubusercontent.com/Homebrew/install/master/install"
COLOUR_THEMES="https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master"

# Add brew cask mac apps here!!! - https://github.com/caskroom/homebrew-cask/tree/master/Casks
brewCaskApps=( atom github-desktop postman iterm2 mysqlworkbench  )

# Functions
# ---------

atom_package_install() {
  read -p "Would you like to install Waterbear default packages for Atom? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    echo "installing atom packages ..."
    apm install activate-power-mode
    apm install atom-beautify
    apm install atom-typescript
    apm install atom-xsltransform
    apm install busy-signal
    apm install docblockr
    apm install flow-ide
    apm install git-control
    apm install git-plus
    apm install git-time-machine
    apm install highlight-line
    apm install highlight-selected
    apm install intentions
    apm install language-batch
    apm install language-freemarker
    apm install language-markdown
    apm install linter
    apm install linter-jscs
    apm install linter-jshint
    apm install linter-jsonlint
    apm install linter-markdown
    apm install linter-shellcheck
    apm install linter-ui-default
    apm install linter-xmllint
    apm install minimap
    apm install minimap-cursorline
    apm install minimap-find-and-replace
    apm install minimap-git-diff
    apm install minimap-highlight-selected package
    apm install minimap-linter
    apm install minimap-selection
    apm install open-in-browser
    apm install pretty-json
    apm install qolor
    apm install split-diff
    apm install xml-tools
  fi
}

homebrew_install() {
  echo "It seems you don't have Homebrew installed."
  echo
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "updating Homebrew ..."
  brew update
  brew upgrade
  echo "installing caskroom"
  brew install caskroom/cask/brew-cask
  echo "Homebrew and Caskroom insalled ✓"
}

brewcask_check() {
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

     # Options for each app
      case "$i" in
              atom)
                  atom_package_install
                  ;;


      esac
  done
}

node_install() {
  echo "It seems you don't have Node installed."
  echo
  read -p "Install Node? (y/n) " -n 1 answer
  echo
  if [[ $answer == "y" || $answer == "Y" ]]; then
    brew install node
    brew install npm
    echo 'set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths' >> ~/.config/fish/config.fish
    echo 'set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths' >> ~/.config/fish/config.fish
    echo 'set fish_user_paths ~/.npm-packages/bin' >> ~/.config/fish/config.fish
  fi
}

ascii_font() {
  echo ' __     __  ______  ______ ______  ______  ______  ______  ______  ______  ______    '
  echo '/\ \  _ \ \/\  __ \/\__  _/\  ___\/\  == \/\  == \/\  ___\/\  __ \/\  == \/\  ___\   '
  echo '\ \ \/ ".\ \ \  __ \/_/\ \\ \  __\\ \  __<\ \  __<\ \  __\\ \  __ \ \  __<\ \___  \  '
  echo ' \ \__/".~\_\ \_\ \_\ \ \_\\ \_____\ \_\ \_\ \_____\ \_____\ \_\ \_\ \_\ \_\/\_____\ '
  echo '  \/_/   \/_/\/_/\/_/  \/_/ \/_____/\/_/ /_/\/_____/\/_____/\/_/\/_/\/_/ /_/\/_____/ '
  echo '                                                                                     '
}

# Test if fun things are installed
if [ -x /usr/local/bin/lolcat ] && [ -x /usr/local/bin/cowsay ] && [ -x /usr/local/bin/fortune ] && [ -x /usr/local/bin/fuck ]; then
    echo "Fun commands are insalled ✓"
  else
    echo "Installing fun commands..."
    brew install lolcat
    brew install cowsay
    brew install fortune
    brew install thefuck
  fi

# Execute the Shell Script
ascii_font | lolcat

# Checking for Ruby
if [ -x /usr/local/bin/rbenv ]; then
  echo "Ruby & rbenv is already insalled ✓"
  else
    brew install rbenv
    rbenv install 2.3.3
    rbenv global 2.3.3
  fi

# Test if Homebrew is installed
if [ -x /usr/local/bin/brew ]; then
  echo "Homebrew is already insalled ✓"
  else
    homebrew_install
  fi

#Test if VIM Plug is installed
if [ -f ~/.vim/autoload/plug.vim ]; then
  echo "Vim Plug is already insalled ✓"
  else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

# Checking for Node
if [ -x /usr/local/bin/node ]; then
  echo "Node is already insalled ✓"
else
    node_install
  fi

# Checking for AWS CLI
if [ -x /usr/local/bin/aws ]; then
  echo "AWS CLI is already insalled ✓"
else
  brew install awscli
  echo "Don't forget to run aws configure!!!" | lolcat
  fi

read -p "Install Powerline Fonts ? (y/n) " -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y" ]]; then
  brew install git fontconfig
  cp /usr/local/etc/fonts/fonts.conf.bak /usr/local/etc/fonts/fonts.conf

  git clone https://github.com/powerline/fonts.git ./fonts
  ./fonts/install.sh
fi

read -p "Install Fish Shell ? (y/n) " -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y" ]]; then
brew install fish --HEAD

		read -p "Would you like to make fish your default shell? (y/n) " -n 1 answer
		echo
		if [[ $answer == "y" || $answer == "Y" ]]; then
      sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
      chsh -s `which fish`
    fi

    read -p "Install Fisherman ? (y/n) " -n 1 answer
    echo
    if [[ $answer == "y" || $answer == "Y" ]]; then
      brew tap fisherman/tap
      brew install fisherman

      echo "updating Fisher ...."
			fish -c "fisher up"

      read -p "Install useful Fisherman Plugins: z + bass ? (y/n) " -n 1 answer
      echo
      if [[ $answer == "y" || $answer == "Y" ]]; then
        echo "Installing Fisher Plugin z + bass"
        fish -c "fisher edc/bass"
				fish -c "fisher z"
      fi

      read -p "Install Oh My Fish ? (y/n) " -n 1 answer
      echo
      if [[ $answer == "y" || $answer == "Y" ]]; then
        git clone https://github.com/oh-my-fish/oh-my-fish
        cd oh-my-fish
        bin/install --offline
        fish -c "omf install bobthefish"
				fish -c "omf install aws"
        wget https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git.fish >> ~/.config/fish/completions/git.fish
        echo "Enableing powerline fonts"
				fish -c "set -g theme_powerline_fonts yes"
				fish -c "set -g theme_powerline_fonts no"
        echo "Removing oh-my-fish install dir" | lolcat
        cd ..
        rm -r -f oh-my-fish
      fi
    fi
fi

echo
read -p "Would you like to OVERWRITE your current .vimrc file with the default setting to make vim more like Atom? (y/n)" -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y"  ]]; then
  cp dot_files/vimrc ~/.vimrc
	echo "Don't forget to modify your vimrc file. (cmd: vim ~/.vimrc)" | lolcat
  fi

# Checking and insalling brew cask apps
brewcask_check

echo "Setup finished!! For further information I recommend reading the Fish Shell documentation." | lolcat | cowsay -f tux
echo

read -p "Should I open the Fish Shell Documentation for you ? (y/n) " -n 1 answer
echo
if [[ $answer == "y" || $answer == "Y" ]]; then
  open http://fishshell.com/docs/current/
fi

echo
echo "closing ..."
