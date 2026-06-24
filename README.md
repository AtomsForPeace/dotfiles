# dotfiles

Managed with [chezmoi](https://chezmoi.io). Source of truth for zsh, nvim, tmux,
mise, git, alacritty and karabiner config, plus a `Brewfile` of every Homebrew
package and a cross-platform bootstrap script.

## Set up a new machine

### macOS

1. Install the Xcode command-line tools (gives you `git`):

   ```sh
   xcode-select --install
   ```

2. Make sure you have a GitHub SSH key on the machine and that it's added to your
   account — the private work CLIs (installed via `mise`) need it. Generate
   one with `ssh-keygen -t ed25519` and add it at <https://github.com/settings/keys>.

3. Run the bootstrap:

   ```sh
   curl -fsLS https://raw.githubusercontent.com/atomsforpeace/dotfiles/main/setup.sh | bash
   ```

   This installs chezmoi, applies the dotfiles, installs Homebrew + everything in
   `Brewfile`, installs oh-my-zsh (keeping the managed `.zshrc`), and runs
   `mise install` for language runtimes.

4. Open a new terminal (or `exec zsh`).

### Linux (apt GPU box)

Same one-liner — the post-install script detects the OS and runs the apt/NVIDIA
path instead.

## Day-to-day

- Pull in a change you made elsewhere: `chezmoi update`
- Capture a local edit back into the repo: `chezmoi re-add` then commit & push
- Track a new file: `chezmoi add ~/path/to/file`
- See what's drifted: `chezmoi status`

## What's tracked

- Shell: `.zshrc` (oh-my-zsh), `.bashrc`
- Editor: `.config/nvim` (lazy.nvim, lock file pinned)
- Terminal/mux: `.config/tmux`, `.config/alacritty.toml`
- Tooling: `.config/mise/config.toml`, `.gitconfig`, `.config/git/ignore`
- Packages: `Brewfile` (not deployed to `$HOME`; used by the bootstrap)
