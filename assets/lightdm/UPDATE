#!/bin/bash

source build/SETTINGS

# Rename the files to default and check their file extensions to match the lightdm.conf before running the script!

sudo mkdir -p /usr/share/images/lightdm

sudo cp $DIR_BASE/lightdm/* $DIR_LIGHTDM

sudo cp $HOME/.local/share/lightdm/default.jpg /usr/share/images/lightdm
sudo cp $HOME/.local/share/lightdm/default.svg /usr/share/images/lightdm
sudo cp -r $DIR_LIGHTDM/lightdm.conf /etc/lightdm/lightdm-gtk-greeter.conf  

