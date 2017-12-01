if [ -f /etc/debian_version ]; then
    echo "Running Debian Setup.."
    ./installer/debian.sh
fi
