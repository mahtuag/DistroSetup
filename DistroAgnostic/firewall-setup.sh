# Setup default UFW Firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Enable UFW Logging
ufw logging on

# Enable UFW
sudo ufw enable
sudo ufw reload

# Enable Fail2Ban
sudo systemctl enable fail2ban

# Allow incoming SSH
sudo systemctl enable --now sshd

# Setup Firewalls for SSH
sudo ufw allow ssh

# Setup Firewalls for KDEConnect
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp

# Setup Firewalls for HTTP and HTTPS (Common Ports)
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 8443
sudo ufw allow 3000
sudo ufw allow 4000
sudo ufw allow 1080
sudo ufw allow 2080
sudo ufw allow 3080
sudo ufw allow 4080
sudo ufw allow 5080
sudo ufw allow 6080
sudo ufw allow 7080
sudo ufw allow 8080
sudo ufw allow 9080

# Final UFW Reload
sudo ufw reload
