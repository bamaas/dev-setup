#!/bin/bash

# Install Homebrew
which -s brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Ansible
which -s ansible || brew install ansible@10

# Install Xcode Command Line Tools
xcode-select -p 1>/dev/null 2>/dev/null || xcode-select --install