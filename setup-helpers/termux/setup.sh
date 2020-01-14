echo "Begin termux setup on kernel `uname -r`"

echo "Running an initial update..."
pkg update

echo "Running an initial upgrade..."
pkg upgrade

echo "Install stuff to make termux shell environemnt feel more like regular Linux"
pkg install \
  man \
  proot \
  zsh \
  screen \
  byobu \
  htop \
  vim \
  wget \
  dnsutils \
  openssh \
  -y

echo "Install Programming Languages, Databases and webservers"
pkg install \
  build-essential \
  python \
  nodejs \
  yarn \
  golang \
  php \
  redis \
  postgresql \
  nginx \
    -y

echo "Create essential directories..."
mkdir -p $HOME/ext/bin $HOME/ext/workspace $HOME/ext/vault $HOME/ext/appdata $HOME/bin

echo "Download ~/.irbirc"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/irbrc -o ~/.irbrc
echo "Download ~/.zshrc"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/zshrc -o ~/.zshrc
echo "Download ~/.vimrc"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/vimrc -o ~/.vimrc
echo "Download ~/.gitconfig"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/gitconfig -o ~/.gitconfig

echo "Install termux-api for programmatic access to phone tools"
pkg install termux-api -y

echo "Switch to zsh"
chsh -s zsh

echo "Done with Termux setup!"
