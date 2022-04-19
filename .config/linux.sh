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

echo "+\n++ Installing local development tools...\n+"

if testcmd code; then
    echo "VS Code is already installed."
else
    if uname -a | grep -q Microsoft; then
        echo "Bash is running in WSL."
        echo "Please install VS Code in Windows and install the 'Remote - WSL' extension."
        echo "https://code.visualstudio.com/download"
        exit 1
    fi
    echo "+\n++ Attempting to install VSCode using snap...\n+"
    sudo snap install code --classic
fi

echo "+\n++ Attempting to install recommended VSCode extensions...\n+"
if testcmd code;
then
    echo "+\n++ VS Code found. Installing recomneded extensions...\n+"
    cat .config/extensions.txt | xargs -L 1 code --install-extension;
fi

echo "+\n++ Attempting to install @vscode/dev-container-cli...\n+"
if testcmd code;
then
    echo "+\n++ VS Code found. Installing @vscode/dev-container-cli...\n+"
    npm install @vscode/dev-container-cli
fi

echo "+\n++ Attempting to launch VSCode...\n+"
if testcmd code;
then
    echo "+\n++ VS Code found. Launching...\n+"
    devcontainer open
fi
