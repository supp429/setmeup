#!/usr/bin/env bash
set -e 

# Check if homebrew installed and install if required
if ! (brew -v) &> /dev/null; then
	echo "#### Installing homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install basic uitlities
brew install vim
brew install git
brew install hg
brew install tree
brew install watch
brew tap phinze/cask
brew install brew-cask
brew cask install shiftit
brew install ripgrep
brew install ack
brew install fd
brew install ngrep
brew install wget --with-libressl
brew install curl --with-openssl
brew install gnu-sed
brew install gawk
brew install gpg
brew cask install iterm2
brew cask install google-chrome
brew cask install slack
brew install ipcalc

# Install Python
brew install python2
brew install python3

# Install Docker
brew install docker

# Cloudfoundry
brew tap cloudfoundry/tap
brew install cf-cli
brew install cloudfoundry/tap/bosh-cli
brew tap starkandwayne/cf
brew install starkandwayne/cf/safe
brew cask install fly
brew install spruce
brew install jq
brew install fzf

# Hashicorp tools
brew install vault
brew install terraform
brew install packer

# CLI tools
brew install awscli
brew install azure-cli

# Setup Oh My ZSH
echo "#### Installing ZSH"
brew install zsh zsh-completions
echo "#### Setting up ZSH as default"
chsh -s /bin/zsh
echo "#### Install Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd $ZSH; git config transfer.fsckObjects false
echo "#### Setting up Zeta theme for ZSH"
mkdir -p $ZSH_CUSTOM/themes
git clone https://github.com/skylerlee/zeta-zsh-theme.git /tmp/zeta-zsh-theme
cp /tmp/zeta-zsh-theme/zeta.zsh-theme $ZSH_CUSTOM/themes
echo "#### Adding custom .zshrc"
cp ./assets/zshrc ~/.zshrc

# Install Ruby
brew install rbenv ruby-build
echo '# Setup rbenv' >> ~/.zshrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
echo "gem: --no-document" >> ~/.gemrc
gem install bundle
gem install cf-uaac


# Kubernetes
brew install kubectl
brew install kubernetes-helm

# Golang
echo "#### Installing golang"
if [ ! -d ~/go ]; then
	mkdir ~/go
	pushd ~/go
	mkdir src bin pkg
	popd
fi

echo "Configuring Go PATH"
if ! grep -q "GOPATH" ~/.zshrc; then
	echo                                  >> ~/.zshrc
	echo '# GOPATH Configuration'         >> ~/.zshrc
	echo 'export GOPATH=~/go'             >> ~/.zshrc
	echo 'export PATH=$PATH:$GOPATH/bin'  >> ~/.zshrc
fi

brew install go
brew install dep
go get -u github.com/onsi/ginkgo/ginkgo
go get -u github.com/onsi/gomega/...


# Setup git
brew tap git-duet/tap
brew install git-duet
cp ./assets/git-authors ~/.git-authors

echo "#### Setting global Git configurations"
git config --global color.ui true
git config --global core.editor /usr/bin/vim
git config --global credential.helper "cache --timeout=36000"
git config --global diff.patience true
git config --global hub.protocol https
git config --global init.templatedir '~/.git-templates'
git config --global push.default simple
git config --global transfer.fsckobjects true
git config --global ui.color auto
git config --system --unset credential.helper
git config --global alias.ci duet-commit
git config --global alias.co checkout
git config --global alias.ds diff --staged
git config --global alias.st git status
git config --global alias.llog "log --date=local"
git config --global alias.logout 'credential-cache exit'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.pr "pull -r"
git config --global alias.up "pull --rebase --autostash"

# Setup iterm theme
git clone https://github.com/dracula/iterm.git ~/iterm
cp ./assets/com.googlecode.iterm2.plist ~/Library/Preferences/

# Setup vim
cp ./assets/vimrc ~/.vimrc
