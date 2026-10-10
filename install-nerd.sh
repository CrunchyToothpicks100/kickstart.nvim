#!/bin/bash

font="JetBrainsMono.zip"
mkdir ~/.fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/$font
unzip $font -d ~/.fonts/
rm $font
fc-cache -f -v
