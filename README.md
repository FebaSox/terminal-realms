# terminal-realms

Cozy, animated themes for your terminal, Zellij and Neovim. Each theme is a **realm**.

![terminal-realms demo](demo.gif)

> **Three realms to install, plus the wizard's own.** More are on the way over the coming months.

| Realm | Vibe |
|---|---|
| **bonfire** | Dark Souls: a pixel bonfire, sword in the ashes, embers drifting, steel title letters. A failed command shows **YOU DIED**. |
| **frost** | The frozen north: snowy pines, a log cabin, lanterns, the aurora over a dark navy sky. |
| **mainframe** | Old-school black and white: a vintage CRT on a desk typing away, code rain falling behind it, a radar scope in camp. A failed command says SEGFAULT. |
| **vialmancy** ✦ | The wizard's own realm. A starry amber night, a wizard with his potion and his black cat, a bubbling cauldron, and a spellbook in Neovim. *Invite only.* |

What you get:

- A **scene pinned to the top** of your terminal. It animates for a few seconds after each Enter and stays still while your commands run. Long commands make it flare and ring the bell.
- **Per-window realms.** Each terminal window keeps its own realm, so you can have bonfire in one and frost in another.
- Terminal colors, `ls`/`eza` colors and an **oh-my-posh prompt** for each realm.
- A **Zellij layout** with two tabs: a workspace tab (shell, Neovim, a fire pane, system stats) and a camp tab (weather, an ambient animation, music).
- **Neovim** colors, a lualine theme, and realm art plus quotes for the alpha-nvim dashboard (with a small version for short panes).

## Screenshots

**The first cut**: bonfire and frost

![first demo](demo.gif)

**Bonfire**: the workspace tab

![bonfire realm](bonfire.png)

**Frost**: the Lodge

![frost realm](frost.png)

**Camp**: weather, ashfall and the bard

![camp tab](camp.png)

**Mainframe**: old-school black and white. A CRT typing away under code rain, a radar scope in camp

![mainframe realm](mainframe.png)

**Vialmancy** ✦ The wizard's go-to realm. Not part of the public install. It's invite only

![vialmancy realm](vialmancy.png)

## Install

**New Mac, or want the whole setup?** One line installs everything: the tools, the font, the configs and both realms.

```sh
git clone https://github.com/FebaSox/terminal-realms.git ~/terminal-realms && ~/terminal-realms/install.sh --full
```

Then quit and reopen Ghostty, and type `wizseb`.

**Already have a setup you like?** Install just the themes on top of it:

```sh
git clone https://github.com/FebaSox/terminal-realms.git ~/terminal-realms && ~/terminal-realms/install.sh
```

### What `--full` sets up

| | |
|---|---|
| **Tools** (Homebrew) | Ghostty, Zellij, Neovim, eza, oh-my-posh, btop, lazygit, ripgrep, fd, mpv, Yazi, fzf, zoxide, bat, tldr, glow |
| **Font** | JetBrainsMono Nerd Font |
| **Ghostty** | font, padding, tabs in the title bar, slight blur |
| **Zellij** | mouse, copy on select, quiet startup |
| **Neovim** | a ready-to-go config: file tree, fuzzy finder, status line, syntax colors, and the realm start screen |
| **zsh** | the realm screen, prompt and colors, `ls` with icons, and the everyday tools below |

It never wipes your stuff. If you already have a Ghostty, Zellij or Neovim config, it keeps yours.
To swap in these ones anyway, run `./install.sh --full --replace`. Your old ones are saved as `*.before-realms`, and `./uninstall.sh` puts them back.

Homebrew is installed for you if it's missing. On Linux, install the tools with your package manager first.

## Use

```sh
wizseb           # which realm this window is in, and the list of realms
wizseb bonfire   # switch this window to bonfire
wizseb mainframe # switch this window to black and white
wizseb frost     # switch this window to frost (new windows start in the last one you picked)
wizseb open      # open the realm's Zellij layout as a fresh session
wizseb join      # a second window joins that same session (pick a different tab there)
wizseb close     # end the realm's Zellij session
wizseb pin       # pin the scene again after `clear`
wizseb unpin     # let it scroll away
wizseb flare     # just for fun
```

## Everyday tools

`--full` also sets up a handful of tools, all colored to match the realm:

| Type | Does |
|---|---|
| *(just type)* | grey ghost-text suggestions from your history. Press → to accept |
| *(just type)* | commands light up in the realm color as you type, and typos get underlined |
| `z dotfiles` | jump to any folder you've been to, from anywhere |
| `Ctrl+R` | fuzzy-search everything you've ever typed |
| `cat file` | syntax colors and line numbers (bat) |
| `y` | Yazi, a three-column file manager with image previews. Uses Neovim keys, and you land wherever you quit |
| `tldr tar` | short, plain-English examples for any command |
| `glow README.md` | read Markdown nicely in the terminal |

## Neovim

With `--full` you get a complete Neovim setup. Space is the leader key:

| Keys | Does |
|---|---|
| `Space e e` | file tree |
| `Space f f` | find a file |
| `Space f s` | find text in your project |
| `Space f r` | recent files |
| `jk` | leave insert mode |
| `Space w` | save |

Plugins download the first time you open `nvim`. Give it a few seconds.

**Using your own Neovim config?** The installer puts `terminal-realms.lua` in `~/.config/nvim/plugin/`, which sets colors and the lualine theme automatically.

For the dashboard art, if you use [alpha-nvim](https://github.com/goolord/alpha-nvim) with its `dashboard` theme, add one line right before `alpha.setup(...)`:

```lua
local dashboard = require("alpha.themes.dashboard")
-- ... your buttons ...
require("terminal_realms").alpha(dashboard)
alpha.setup(dashboard.opts)
```

Don't want the colors? Set `vim.g.terminal_realms_disable = true`, or pass options with
`vim.g.terminal_realms = { transparent = false, lualine = false }`.

## Settings

Edit `~/.config/terminal-realms/settings.zsh`. Every option is listed there with its default. The main ones:

- `REALM_SECONDS=25`: how long the scene animates after Enter (`inf` or `0` also work)
- `REALM_PROMPT=0`: keep your own prompt
- `REALM_PLACE` / `REALM_LAT` / `REALM_LON`: the weather location (otherwise it's guessed from your IP)
- `REALM_BONFIRE_INFO="Class=Knight;Boss=Ornstein"`: the rows in the bonfire box
- `REALM_GREETING=0`: no once-a-day hello from the wizard

## Requirements

`--full` installs all of this for you.

Required: **zsh** and **perl** (both come with macOS), and a truecolor terminal with a [Nerd Font](https://www.nerdfonts.com/). Ghostty, WezTerm, Kitty and iTerm2 all work.

Optional:

| Tool | For |
|---|---|
| [Zellij](https://zellij.dev) | `wizseb open` layouts |
| Neovim + alpha-nvim + lualine | editor colors and dashboard |
| python3 | the fire pane |
| [oh-my-posh](https://ohmyposh.dev) | realm prompts |
| macchina / mactop / btop / htop | nicer stats |
| mpv | ambient radio in the music pane (it also shows Spotify / Apple Music) |

Works on macOS and Linux.

## Uninstall

```sh
./uninstall.sh          # keeps your settings.zsh
./uninstall.sh --all    # removes everything
```

If `--full --replace` swapped out your configs, uninstall puts your old ones back.

## Make your own realm

Copy `realms/frost` to `realms/<name>` and edit it:

- `screen.sh`: draws the scene (`screen.sh`, `screen.sh anim <seconds>`, `screen.sh quote`)
- `yazi/theme.toml`: Yazi file manager colors
- `env.zsh`: anything to export, like `LS_COLORS` / `EZA_COLORS`
- `panes.pl`, `stats.env`, `tools.env` (optional): the realm's own colors for the weather, music and stats panes and the everyday tools
- `colors.conf`: Ghostty-style `palette = N=#hex`, `background`, `foreground`, `cursor-color`
- `prompt.omp.json`: oh-my-posh prompt
- `layout.kdl`: Zellij layout
- `nvim.lua`: `apply()` and a `lualine` table
- `dashboard.lua`: `lines`, `hl`, `small_lines`, `small_hl`, `quote()`, `setup()`

Then add a Zellij theme at `zellij-themes/realm-<name>.kdl`.

## Coming soon

More realms are in the works. Ideas and pull requests for new ones are welcome. A realm is just a folder (see above).

## Credits

Made by **WizSeb** ([@FebaSox](https://github.com/FebaSox)), with help from Claude. If you share a screenshot, a shout-out is appreciated. Inspired by Dark Souls (FromSoftware). This is a fan project, not affiliated with them. Weather by [Open-Meteo](https://open-meteo.com).

License: MIT
