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

echo "Checking for Docker installation in "$DOCKER_SYSPATH"."
if [ ! -d "$DOCKER_SYSPATH" ]
then
    echo "Docker desktop not found. Please install Docker Desktop and try again."
    exit
fi

echo "Checking for VSCode installation in "$VSCODE_SYSPATH"."
if [ ! -d "$VSCODE_SYSPATH" ]
then
    echo "VSCode not found in "$VSCODE_SYSPATH"."
    echo "Attempting to install VSCode using brew"
    # brew install visual-studio-code
fi

echo "Attempting to install recommended VSCode extensions."
if [ -d "$VSCODE_SYSPATH" ]
then
    echo "VS Code found. Installing recomneded extensions"
    cat .config/extensions.txt | xargs -L 1 "$VSCODE_SYSPATH/code" --install-extension;
fi

echo "Attempting to launch VSCode."
if [ -d "$VSCODE_SYSPATH" ]
then
    echo "VS Code found. Launching"
    # "$VSCODE_SYSPATH/code" --new-window $PWD --verbose;
    # devcontainer open
fi

# # Copy vscode config from the repo
# [[ -d .vscode ]] || cp -a .config/vscode .vscode
