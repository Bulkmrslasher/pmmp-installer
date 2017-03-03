# PocketMine-MP install script
# (C) 2017 by jarne | https://github.com/jarne

# Default settings
USER="pmmp"
REPOSITORY="PocketMine-MP"
BRANCH="master"
SYSTEM="mac64"
THREADS=4

# Development
CACHE=false

# Updating settings from arguments
while getopts "u:r:b:s:t:c" OPTION; do
  case $OPTION in
    u)
      USER=$OPTARG
      ;;
    r)
      REPOSITORY=$OPTARG
      ;;
    b)
      BRANCH=$OPTARG
      ;;
    s)
      SYSTEM=$OPTARG
      ;;
    t)
      THREADS=$OPTARG
      ;;
    c)
      CACHE=true
      ;;
  esac
done

# Create and go into working directory
echo "Creating working directory ..."

if $CACHE
then
  mkdir cache >> install.log 2>&1
fi

mkdir tmp >> install.log 2>&1
cd tmp >> install.log 2>&1

# Download PHP build scripts and PocketMine-MP
echo "Downloading files ..."

git clone https://github.com/pmmp/php-build-scripts.git >> ../install.log 2>&1
git clone https://github.com/pmmp/PocketMine-DevTools.git >> ../install.log 2>&1
git clone --recursive --branch $BRANCH https://github.com/$USER/$REPOSITORY.git >> ../install.log 2>&1

# Compile PHP binaries
cd php-build-scripts >> ../install.log 2>&1

if $CACHE && [ -d ../../cache/bin ]
then
  echo "Using cached PHP binaries ..."

  cp -r ../../cache/bin bin >> ../install.log 2>&1
else
  echo "Compiling PHP binaries ..."

  ./compile.sh -t $SYSTEM -j $THREADS -c >> ../../install.log 2>&1

  if $CACHE
  then
    cp -r bin ../../cache/bin >> ../../install.log 2>&1
  fi
fi

cd .. >> ../../install.log 2>&1

# Compile DevTools
echo "Compiling DevTools ..."

cd PocketMine-DevTools >> ../install.log 2>&1
../php-build-scripts/bin/php7/bin/php src/DevTools/ConsoleScript.php --make . --relative . --out DevTools.phar >> ../../install.log 2>&1
cd .. >> ../../install.log 2>&1

# Start PocketMine-MP and create PHAR
echo "Creating PHAR file ..."

cd $REPOSITORY >> ../install.log 2>&1

mkdir plugins >> ../../install.log 2>&1

cp -r ../php-build-scripts/bin bin  >> ../../install.log 2>&1
cp ../PocketMine-DevTools/DevTools.phar plugins/DevTools.phar  >> ../../install.log 2>&1

echo -e "makeserver\nstop\n" | bin/php7/bin/php src/pocketmine/PocketMine.php --no-wizard --disable-ansi --disable-readline >> ../../install.log 2>&1

cd .. >> ../../install.log 2>&1

# Leave working directory
cd .. >> ../install.log 2>&1

# Create PocketMine-MP folder and copy files
echo "Copying files ..."

mkdir $REPOSITORY >> install.log 2>&1

cp -r tmp/php-build-scripts/bin $REPOSITORY/bin >> install.log 2>&1
cp tmp/$REPOSITORY/start.sh $REPOSITORY/start.sh >> install.log 2>&1
cp tmp/$REPOSITORY/plugins/DevTools/$REPOSITORY*.phar $REPOSITORY/$REPOSITORY.phar >> install.log 2>&1

# Delete working directory
echo "Deleting working directory ..."

sudo rm -r tmp >> install.log 2>&1

# Success
echo "Successfully installed $REPOSITORY"
