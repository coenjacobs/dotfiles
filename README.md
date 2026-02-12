My dotfiles have evolved over the past year or so. They still aren't the most exciting dotfiles you can find on the web, but they work just fine for me on a daily basis. Feel free to draw inspiration from the way the files are organised, or actual configurations in one of the files. :)

The [dotfiles of @holman](https://github.com/holman/dotfiles) have been a massive inspiration for the way my files are laid out, I'm a huge fan of the way the files are organised by topic rather than by purpose. You can find all my git stuff in one directory and everything related to tmux in another, instead of putting all aliases in one folder and all configuration files in another.

## Install

```bash
# macOS / Linux
./install.sh

# Windows (PowerShell as admin)
./install.ps1
```

This installs Homebrew (or winget on Windows), sets up packages, and symlinks all config files to their expected locations. Existing files are backed up with a `.backup` suffix.

Any `env` or `aliases` file placed in a topic directory (e.g. `git/aliases`, `nvim/env`) is automatically sourced by `.bashrc` at shell startup. This keeps tool-specific configuration next to the rest of that tool's config, rather than cluttering the shell init file.

At this point, all my files lack is proper documentation for them to be useful to others, but feel free to take or reuse whatever you can find in this repository. Should you make a great improvement in these files, I'd really appreciate if you contribute your changes back! [Dotfiles are meant to be forked](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)!
