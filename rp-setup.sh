# setup
sudo echo 'jrpi' > /etc/hostname

# apps
sudo apt-get update
sudo apt-get install \
	fail2ban \
	kodi \
	ufw \
	vim

# ufw
sudo ufw allow ssh
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status verbose

# ssh
mkdir -p ~/.ssh
if [ ! -f ~/.ssh/authorized_keys ]; then
	curl https://raw.githubusercontent.com/jessie-ross/dot-files/main/public-keys/id_ed25519_20240608.pub >> ~/.ssh/authorized_keys
fi


echo <<SSHD_CONFIG > /etc/ssh/sshd_config
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
PermitEmptyPasswords no
KbdInteractiveAuthentication no
UsePAM no
X11Forwarding no
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp internal-sftp
SSHD_CONFIG

sudo systemctl enable sshd

