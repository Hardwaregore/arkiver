#!/bin/bash

red=`tput setaf 1`

command -v gzip > /dev/null || printf "\n ${red}CRITICAL ERROR! ABORTING! (Err: gzip NOT INSTALLED)${reset} \n \n"
command -v gunzip > /dev/null || printf "\n ${red}CRITICAL ERROR! ABORTING! (Err: gunzip NOT INSTALLED)${reset} \n \n"



if [ $1 == "init" ]; then
  mkdir ~/arkiverSnapshots
  cd ~/arkiverSnapshots
  echo "Copying Source code..."
  dd if=arkiver.sh of=arkiver
  echo "Done!"
  echo ""
  echo "Moving to /usr/local/bin"
  mv arkiver /usr/local/bin/
  echo "Done!"
  echo ""
  echo "Deleting this file: arkiver.sh"
  rm -rf arkiver.sh
  echo "Done!"
  exit
  
elif [ $1 == "newarchive" ]; then
  cd ~/arkiverSnapshots
  curl https://$2 >> $2
  tar cf $3.tar.gz $2
  
  echo "Created $3.tar.gz from $2"
  
elif [ $1 == "append" ]; then
  cd ~/arkiverSnapshots
  curl https://$2 >> $2
  tar rf $3.tar.gz $2
  
elif [ $1 == "expand" ]; then
  cd ~/arkiverSnapshots
  tar xf $2.tar.gz
  
elif [ $1 == "delete" ]; then
  cd ~/arkiverSnapshots
  rm -rf $2.tar.gz
  
elif [ $1 == "view" ]; then
  cd ~/arkiverSnapshots
  mkdir tempdir
  cp $2.tar.gz tempdir/
  cd tempdir
  tar xf $2.tar.gz
  rm -rf $2.tar.gz
  mv $2 index.html
  
  clear
  echo "Visit localhost:8080 to view snapshot"
  php -S localhost:8080 | rm -rf ../tempdir | cd .. | exit
  
  

else
  cd ~/arkiverSnapshots
  echo "Unknown option: $2, please refer to https://github.com/Hardwaregore/arkiver/README.md"
fi
