#!/bin/sh

wget -c https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.8-stable.tar.xz
tar -xf flutter_linux_v1.12.13+hotfix.8-stable.tar.xz
rm $EXT_BIN/flutter
mv flutter $EXT_BIN/

exit
