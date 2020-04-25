echo "Adding user wingedrhino"
echo "TODO: This should be a perl script that takes an argument"
adduser wingedrhino
usermod -aG sudo wingedrhino
usermod -aG docker wingedrhino
