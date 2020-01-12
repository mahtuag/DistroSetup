echo "Begin termux setup on kernel `uname -r`"

echo "Running an initial update..."
pkg update
echo "Running an initial upgrade..."
pkg upgrade
pkg install \
    python \
    nodejs \
    zsh \
    screen \
    byobu \
    openssh \
    nginx \
    wget \
    htop \
    build-essential \
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

echo "Done with Termux setup!"
