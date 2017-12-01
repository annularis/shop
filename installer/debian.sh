#!/bin/bash
echo "== Debian installer =="

#Check if root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

#Install Dependency
echo "Installing packages.."
apt-get update
apt-get install apache2 mysql-server mysql-client php libapache2-mod-php php-mcrypt php-gnupg php-mysql php-gmp php-curl php-bcmath php-gd git mcrypt curl unzip atool

#Check apt exit status
if [ $? -ne 0 ]; then
        exit 1
fi

# Enable Mod Rewrite
a2enmod rewrite

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
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf

# Change DocumentRoot to /var/www/html/shop
echo "Setting up Apache2 DocumentRoot.."
if ! grep -q "shop" /etc/apache2/sites-enabled/000-default.conf; then
    sed -i 's#/var/www/html#/var/www/html/shop#' /etc/apache2/sites-enabled/000-default.conf
fi

# Add mysql user and add database
echo "Setting up MySQL.."
mysql -e "CREATE DATABASE annularis;"
mysql -e "CREATE USER IF NOT EXISTS annularis IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON annularis.* TO annularis@localhost IDENTIFIED BY 'password';"

# Install annularis source (from git)
echo "Cloning Annularis.."
cd /var/www/html
git clone https://github.com/annularis/shop
chown www-data:www-data -R /var/www/html/shop

# Restart Apache
systemctl restart apache2.service

# Info
echo ""
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
echo "---------------------------------------------------------------"
