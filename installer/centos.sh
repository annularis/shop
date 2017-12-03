#!/bin/bash
echo "== CentOS installer =="

#Check if root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Enable repos
echo "Enabling repos.."
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install Dependency
echo "Installing dependency.."
yum install httpd  mariadb mariadb-server php70w-intl php70w php70w-cli php70w-devel php70w-pear php70w-common php70w-mcrypt php70w-mysql  php70w-bcmath php70w-gd php70w-mbstring git mcrypt curl unzip atool gpgme gpgme-devel gcc vim gmp-devel libmcrypt-devel curl-devel wget -y
pecl install gnupg

echo -e "\n extension=gnupg.so" >> /etc/php.ini

# Open port 80
echo "Open port 80.."
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

# Disable selinux
echo "Disabling selinux.."
echo 0 > /selinux/enforce
setenforce 0

# Install bitcoin
if [ ! -f /usr/bin/bitcoind ]; then
        echo "Installing bitcoin.."
        cd /tmp
        wget https://bitcoin.org/bin/bitcoin-core-0.15.1/bitcoin-0.15.1-x86_64-linux-gnu.tar.gz # or 32bit
        aunpack bitcoin-0.15.1-x86_64-linux-gnu.tar.gz
        cd bitcoin-0.15.1
        cp bin/* /usr/bin/
fi

# Start bitcoind (testnet)
if ! pgrep "bitcoind" >/dev/null 2>&1 ; then
        echo "Starting bitcoind (testnet).."
        bitcoind -daemon -testnet -rpcport="7530" -rpcuser="bitcoinuser" -rpcpassword="bitcoinpass"
fi

# Enable "AllowOverride All (/var/www)
echo "Setting up 'AllowOverride All' for /var/www"
sudo sed -i 's#AllowOverride None#AllowOverride All#' /etc/httpd/conf/httpd.conf

# Change DocumentRoot to /var/www/html/shop
echo "Setting up Apache2 DocumentRoot.."
if ! grep -q "shop" /etc/httpd/conf/httpd.conf; then
    sed -i 's#DocumentRoot "/var/www/html"#DocumentRoot "/var/www/html/shop"#' /etc/httpd/conf/httpd.conf
fi

# Add mysql user and add database
echo "Setting up MySQL.."
systemctl enable mariadb.service
systemctl start mariadb.service
mysql -e "CREATE DATABASE annularis;"
mysql -e "CREATE USER annularis IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON annularis.* TO annularis@localhost IDENTIFIED BY 'password';"

# Install annularis source (from git)
echo "Cloning Annularis.."
cd /var/www/html
git clone https://github.com/annularis/shop
chown apache:apache -R /var/www/html/shop

# Restart Apache
systemctl enable httpd.service
systemctl restart httpd.service

# Info
echo "Open your browser to http://your-ip/install and fill as follow:"
echo "---------------------------------------------------------------"
echo "DB User / DB Name: annularis"
echo "DB Pass: password"
echo "Bitcoin port: 7530"
echo "Bitcoin user: bitcoinuser"
echo "Bitcoin pass: bitcoinpass"
echo "For 'Bip32 public key' see 'http://bip32.org'"
echo "Set 'Tidy URL' to 'No'"
echo "Set 'Force Vendor to use PGP' to 'No'"
echo "--------------------------------------------------------"
