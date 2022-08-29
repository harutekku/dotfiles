#!/bin/bash

# Note: Environment variable definitions
# and programs to run at startup go here

grep "i" &>/dev/null <<< "$-" && [ -r ~/.bashrc ] && source ~/.bashrc

[ -d ~/bin ] && PATH="~/bin:${PATH}"

