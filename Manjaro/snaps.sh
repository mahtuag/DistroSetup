#!/bin/sh

echo "Install Tools via Snap"
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
echo "Snap: Slack"
sudo snap install slack --classic
echo "Snap: Gitter"
sudo snap install gitter-desktop
echo "Snap: Mattermost"
sudo snap install mattermost-desktop
echo "Snap: Discord"
sudo snap install discord
echo "Snap: Zoom"
sudo snap install zoom-client
echo "Snap: Microk8s; See https://microk8s.io/#get-started"
sudo snap install microk8s --classic --channel=1.18/stable
echo "Finished installing tools via Snap!"
