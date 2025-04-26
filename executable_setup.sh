#!/bin/bash

# Install chezmoi (if not exists)
if ! command -v chezmoi >/dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi

# Initialize chezmoi with your dotfiles repo (REPLACE URL)
chezmoi init --apply https://github.com/atomsforpeace/dotfiles.git

# Run post-install steps from your chezmoi-managed scripts
chezmoi apply  # Executes any linked files like `~/.local/bin/setup-post-install`
