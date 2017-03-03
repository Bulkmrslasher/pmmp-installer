# pmmp-installer
Automatic install script for PocketMine-MP and its PHP binaries

## Files
The files should be executed in this sequence:

`requirements.sh` Run as root, installing the dependencies of this script (using apt-get, only working on Debian / Ubuntu)  
`install.sh` Run as a normal user, installing PocketMine-MP

## Configuration
To run the script, you need to reconfigure it in most cases. The config is stored in the install.sh file.

`USER` The GitHub username where the repository is stored  
`REPOSITORY` The name of the repository  
`BRANCH` The branch which should be used to create the PHAR  
`SYSTEM` Your operating system, possible options are `mac`, `mac64`, `linux`, `linux64`  
`THREADS` How many threads should be used when compiling PHP, depending on your CPU

If you don't want to change the default settings in the file, you can also use arguments when executing the script:

`-u` The GitHub username where the repository is stored  
`-r` The name of the repository  
`-b` The branch which should be used to create the PHAR  
`-s` Your operating system, possible options are `mac`, `mac64`, `linux`, `linux64`  
`-t` How many threads should be used when compiling PHP, depending on your CPU

By default, `USER` is set to `pmmp` and `REPOSITORY` to `PocketMine-MP`, but you can also change it to a fork of PocketMine-MP and it'll still work for most forks.

## License & Credits
[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

You are free to copy, redistribute, change or expand our work, but you must give credits share it under the same license.
pmmp-installer by [jarne](https://github.com/jarne/pmmp-installer) is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

The script is using [php-build-tools](https://github.com/pmmp/php-build-scripts) and [PocketMine-DevTools](https://github.com/pmmp/PocketMine-DevTools) by [pmmp](https://github.com/pmmp).