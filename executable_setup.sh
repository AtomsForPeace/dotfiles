#!/bin/bash
# Bootstrap a fresh machine from these dotfiles.
#
#   curl -fsLS https://raw.githubusercontent.com/atomsforpeace/dotfiles/main/setup.sh | bash
#
# Or, if this file is already on disk: bash ~/setup.sh
set -euo pipefail

# 1. Install chezmoi if it isn't already present.
if ! command -v chezmoi >/dev/null 2>&1; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$PATH"
fi

# 2. Pull the dotfiles and apply them.
chezmoi init --apply https://github.com/atomsforpeace/dotfiles.git

# 3. Run OS-specific provisioning (Homebrew/apt, oh-my-zsh, mise tools, ...).
"$HOME/.local/bin/setup-post-install"

echo
echo "Done. Open a new terminal (or run 'exec zsh' on macOS) to pick everything up."
