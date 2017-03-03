# PocketMine-MP requirements script
# (C) 2017 by jarne | https://github.com/jarne

# Install dependencies for this script
echo "Installing script requirements ..."

apt-get install -y git screen >> requirements.log 2>&1

# Install dependencies for PHP build scripts
echo "Install PHP build script requirements ..."

apt-get install -y make autoconf automake libtool m4 wget getconf gzip bzip2 bison g++ >> requirements.log 2>&1

# Success
echo "Successfully installed requirements"
