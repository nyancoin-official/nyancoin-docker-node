#!/bin/bash

## Check if binaries are already installed
cd ~
if [ ! -f ~/nyancoin-2.0/bin/nyancoind ]; then
    curl -o nyancoin.tar.gz -s4SL https://github.com/nyancoin-official/nyancoin-client/releases/download/v2.0/nyancoin2.0-x86_64-linux-gnu.tar.gz
    if [ $? -eq 0 ]; then
        tar -xvf nyancoin.tar.gz
        ## Rename folder appropriately
        mv nyancoin2.0-x86_64-linux-gnu/ nyancoin-2.0
        ## Add nyancoin commands to PATH
        echo 'export PATH=$PATH:~/nyancoin-2.0/bin/' > ~/.bashrc
        source ~/.bashrc
        rm ~/nyancoin-2.0/bin/nyancoin-qt
        rm nyancoin.tar.gz
    else
        rm nyancoin.tar.gz
        echo "Download failed."
        exit 1
    fi
fi

##Check if configuration file exists
if [ ! -f ~/.nyancoin/nyancoin.conf ]; then
    mkdir ~/.nyancoin
    echo rpcuser=nyancoinrpc > ~/.nyancoin/nyancoin.conf
    echo rpcpassword=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1) >> ~/.nyancoin/nyancoin.conf
fi

##Start nyancoin daemon
echo Running nyancoin!
~/nyancoin-2.0/bin/nyancoind -printtoconsole -shrinkdebugfile >/dev/null 2>&1 & disown
