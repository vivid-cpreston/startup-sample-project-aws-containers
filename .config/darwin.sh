#!/bin/bash

VSCODE_SYSPATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
DOCKER_SYSPATH="/usr/local/bin"

testcmd () {
    command -v "$1" > /dev/null
}

if ! testcmd brew; then
    read -rp "Homebrew is not installed. Install now [y/n]: " install
    if [ "$install" == "y" ]; then
        echo "installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
        echo "Please install Homebrew and try again."
    fi
    exit 1
fi

echo "+\n++ Checking for Docker installation in "$DOCKER_SYSPATH"...\n+"
if [ ! -d "$DOCKER_SYSPATH" ]
then
    echo "Docker desktop not found. Please install Docker Desktop and try again."
    exit
fi

echo "+\n++ Checking for VSCode installation in "$VSCODE_SYSPATH"...\n+"
if [ ! -d "$VSCODE_SYSPATH" ]
then
    echo "VSCode not found in "$VSCODE_SYSPATH"."
    echo "Attempting to install VSCode using brew"
    brew install visual-studio-code
fi

echo "+\n++ Attempting to install recommended VSCode extensions...\n+"
if [ -d "$VSCODE_SYSPATH" ]
then
    echo "+\n++ VS Code found. Installing recomneded extensions...\n+"
    cat .config/extensions.txt | xargs -L 1 "$VSCODE_SYSPATH/code" --install-extension;
fi

echo "+\n++ Attempting to install @vscode/dev-container-cli...\n+"
if [ -d "$VSCODE_SYSPATH" ]
then
    echo "+\n++ VS Code found. Installing @vscode/dev-container-cli...\n+"
    npm install @vscode/dev-container-cli
fi

echo "+\n++ Attempting to launch VSCode...\n+"
if [ -d "$VSCODE_SYSPATH" ]
then
    echo "+\n++ VS Code found. Launching...\n+"
    devcontainer open
fi