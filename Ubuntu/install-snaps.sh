#!/bin/sh

echo "Snap: Telegram"
sudo snap install telegram-desktop
echo "Snap: Olive Video Editor"
sudo snap install --edge olive-editor
echo "Snap: Insomnia"
sudo snap install insomnia	
echo "Snap: Eclipse"
sudo snap install eclipse --classic
echo "Snap: Android Studio"
sudo snap install android-studio --classic
echo "Snap: PyCharm"
sudo snap install pycharm-community --classic
echo "Snap: IntelliJ"
sudo snap install intellij-idea-community --classic
echo "Snap: Redis Desktop Manager"
sudo snap install redis-desktop-manager
echo "Snap: Slack"
sudo snap install slack --classic
echo "Snap: Discord"
sudo snap install discord
echo "Snap: Wire"
sudo snap install wire
echo "Snap: Riot IM"
sudo snap install riot-web
sudo snap connect riot-web:camera

