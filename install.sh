if [ -f /etc/debian_version ]; then
    echo "Running Debian Setup.."
    ./installer/debian.sh
elif [ -f /etc/centos-release ]; then
    echo "Running CentOS Setup.."
    ./installer/centos.sh
fi
