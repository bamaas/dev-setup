#!/bin/bash

# Install Homebrew
which -s brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Ansible
which -s ansible || brew install ansible        # TODO: Add fixed version

# Install Xcode Command Line Tools
xcode-select -p 1>/dev/null 2>/dev/null || xcode-select --install