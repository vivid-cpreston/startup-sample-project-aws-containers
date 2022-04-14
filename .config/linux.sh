#!/bin/bash

DOCKER_SYSPATH="/usr/bin/docker"

testcmd () {
    command -v "$1" > /dev/null
}


echo "Checking for Docker executable at path: "$DOCKER_SYSPATH"."
if [ ! "$DOCKER_SYSPATH" ]
then
    echo "Docker installation not found. Please install Docker and try again."
    exit
fi

echo "Installing local development tools..."

if testcmd code; then
    echo "VS Code is already installed."
else
    if uname -a | grep -q Microsoft; then
        echo "Bash is running in WSL."
        echo "Please install VS Code in Windows and install the 'Remote - WSL' extension."
        echo "https://code.visualstudio.com/download"
        exit 1
    fi
    echo "Attempting to install VSCode using snap"
    sudo snap install code --classic
fi

echo "Attempting to install recommended VSCode extensions."
if testcmd code;
then
    echo "VS Code found. Installing recomneded extensions"
    cat .config/extensions.txt | xargs -L 1 code --install-extension;
    # devcontainer open
fi

echo "Attempting to launch VSCode."
if testcmd code;
then
    echo "VS Code found. Launching"
    "code" --new-window $PWD --verbose;
    # devcontainer open
fi

# # Copy vscode config from the repo
# [[ -d .vscode ]] || cp -a .config/vscode .vscode
