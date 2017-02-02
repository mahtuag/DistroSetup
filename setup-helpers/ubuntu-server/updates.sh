printf "Start: Update Ubuntu\n"
printf "apt update - twice, to account for network errors\n"
apt -y update
apt -y update
apt -y upgrade
apt -y dist-upgrade
printf "End: Update Ubuntu"

