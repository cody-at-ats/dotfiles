# dotfiles

Personal shell configs used across Windows (PowerShell), WSL (Bash), and WSL (Fish).

## Files

| File | Shell | Location |
|------|-------|----------|
| `Microsoft.PowerShell_profile.ps1` | PowerShell 7 | `$PROFILE` (CurrentUserCurrentHost) |
| `.bashrc` | Bash (WSL) | `~/.bashrc` |
| `config.fish` | Fish (WSL) | `~/.config/fish/config.fish` |
| `.vimrc` | Vim | `~/.vimrc` |

## Quick Start

Clone and symlink (or copy) the relevant file to its target location.

**PowerShell:**
```powershell
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\git\dotfiles\Microsoft.PowerShell_profile.ps1" -Force
```

**Bash:**
```bash
ln -sf ~/git/dotfiles/.bashrc ~/.bashrc
```

**Fish:**
```bash
mkdir -p ~/.config/fish
ln -sf ~/git/dotfiles/config.fish ~/.config/fish/config.fish
```

**Vim:**
```bash
ln -sf ~/git/dotfiles/.vimrc ~/.vimrc
```

## What's Inside

### All shells — Git aliases

A full set of short git aliases, consistent across all three shells.

| Alias | Command |
|-------|---------|
| `gs` | `git status` |
| `ga` / `gaa` | `git add` / `git add --all` |
| `gc` / `gcm` / `gca` | `git commit` / `commit -m` / `commit --amend` |
| `gp` / `gpf` | `git push` / `push --force-with-lease` |
| `gl` | `git pull` |
| `gf` / `gfa` | `git fetch` / `fetch --all` |
| `gd` / `gds` | `git diff` / `diff --staged` |
| `gco` / `gcb` | `git checkout` / `checkout -b` |
| `gb` / `gba` / `gbd` | `git branch` / `-a` / `-d` |
| `gm` / `grb` | `git merge` / `git rebase` |
| `gst` / `gstp` / `gstl` | `git stash` / `pop` / `list` |
| `glog` / `gloga` | log graph (current / all branches) |
| `grs` / `grsh` | `git reset` / `reset --hard` |
| `gclean` | `git clean -fd` |

### All shells — Navigation

```
.. ... .... .....   cd up 1–4 levels
bd                  cd to previous directory
home                cd ~
mkdirg <dir>        mkdir + cd in one step
up <N>              cd up N levels (bash/fish)
```

### Bash / Fish — Extras

- **`ls` variants** — `la`, `ll`, `lt`, `lk`, `ldir`, `lf`, and more
- **`extract <file>`** — unpack any archive format (tar.gz, zip, 7z, rar, …)
- **`ftext <term>`** — recursive grep with colour in the current directory
- **`h/f/p <term>`** — search history / files / processes
- **`sha1` / `sha256`** — quick file hashing via openssl
- **`da`** — formatted date/time
- **Prompt** — [Starship](https://starship.rs) (initialized if installed)

### Vim

Based on [amix/vimrc](https://github.com/amix/vimrc) (basic version) with a custom **OLED colorscheme** (pure `#000000` background) and practical developer additions. No plugins — drops cleanly onto any box with Vim 8+.

| Setting | Value | Why |
|---------|-------|-----|
| `relativenumber` | on | j/k motion counts at a glance |
| `cursorline` | on | easier to track position |
| `mouse` | all modes | scroll + click in terminals |
| `undofile` | `~/.vim/undodir` | persistent undo across sessions |
| `splitright` / `splitbelow` | on | splits open where you expect |
| `colorcolumn` | 80 | visual line-length guide |
| `listchars` | defined | toggle whitespace with `:set list` |
| `nomodeline` | on | security — prevents modeline exploits |
| `Q` | `<Nop>` | prevents accidental Ex mode |
| `Y` | `y$` | consistent with `D` and `C` |

**Key mappings** (leader = `,`):

| Mapping | Action |
|---------|--------|
| `,w` | Save file |
| `<Space>` | Forward search |
| `<C-hjkl>` | Move between splits |
| `,bd` | Close buffer |
| `,tn` / `,tc` / `,tl` | New / close / last tab |
| `,ss` | Toggle spell check |
| `,pp` | Toggle paste mode |
| `Alt+j/k` | Move line up/down |
| `*` / `#` (visual) | Search selected text |

### PowerShell — Extras

- **`e` / `n` / `v`** — open in VS Code / Notepad / Neovide (WSL)
- **`dirs [pattern]`** — recursive file list (`dir /s /b` equivalent)
- **`sha1` / `sha256`** — `Get-FileHash` wrappers
- **`Remove-Bin <path>`** — delete all `bin`/`obj` folders (skips node_modules etc.)
- **`Remove-EmptyDirectories`** — clean up empty dirs
- **`Remove-GitStaleLocalBranches`** — prune local branches whose remote is gone
- **`Rename-GitBranch -New <name>`** — rename current branch locally and on remote
- **`Shrink-VHDX`** — compact the WSL Ubuntu disk image
- **`Restore-DatabaseBackups <dir>`** — restore `.bak` files to local SQL Server
- **`Clear-AzureQueues`** — cancel queued ADO builds (requires `AZURE_DEVOPS_PAT` env var)
- **Prompt** — [Starship](https://starship.rs) (consistent with WSL)

## Help

Run `chelp` in any shell for a colour-coded in-terminal cheatsheet.

## Auto-update

Each config includes a command that pulls the latest version from this repo and reloads itself.

> **Requires** the repo to be cloned at `~/git/dotfiles`. If it's not there yet, clone it first (see Quick Start).

| Shell | Command |
|-------|---------|
| Bash | `dotfiles-update` |
| Fish | `dotfiles-update` |
| PowerShell | `Update-Dotfiles` (alias: `dotfiles-update`) |

- If the config file is a **symlink** into the repo, only `git pull` is run — the symlink already points to the updated file.
- If the config file is a **copy**, the updated file is copied to the target location after pulling.
- The config is **re-sourced automatically** so changes take effect immediately without opening a new shell.
