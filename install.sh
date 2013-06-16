#!/bin/sh

for file in $(cat InstallList); do
  ln -s `pwd`/$file ~/.$file
done
