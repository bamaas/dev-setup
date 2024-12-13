#!/bin/bash
set -o errexit
set -o nounset

# Install Xcode Command Line Tools
xcode-select -p 1>/dev/null 2>/dev/null || xcode-select --install

# Install Homebrew
if ! command -v brew &>/dev/null
then
	# Install brew in ~/.brew
	test -d ~/.brew || git clone https://github.com/Homebrew/brew ~/.brew
	test -f ~/.zshrc && $(cat ~/.zshrc | grep 'brew shellenv)') || echo 'eval "$(~/.brew/bin/brew shellenv)"' >> ~/.zshrc	# TODO: this gets overwritten when installing the oh my zsh role

	# Verify Homebrew installation
	source ~/.zshrc
	which -s brew

	brew update --force --quiet
	chmod -R go-w "$(brew --prefix)/share/zsh"
fi

# Install Ansible
which -s ansible || brew install ansible        # TODO: Add fixed version
