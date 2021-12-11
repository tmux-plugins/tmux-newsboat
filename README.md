# tmux-newsboat

Display [newsboat](https://newsboat.org) counters in tmux status line.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-newsboat'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-newsboat ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/newsboat.tmux

Reload TMUX environment with: `$ tmux source-file ~/.tmux.conf`.
You should now be able to use the plugin.

### Additional installation steps

After installing the plugin, there are a couple more installation steps:

- Ensure `newsboat` has the following config:

    notify-always yes
    notify-format "%d %n %f"
    notify-program "<plugin-installation-dir>/bin/tmux-newsboat"

- Where `<plugin-installation-dir>` from the above will most likely be
  - `~/.tmux/plugins/tmux-newsboat`
  - or `~/.config/tmux/plugins/tmux-newsboat`

- Add one or more supported format strings to tmux's `status-right`:
  - `#{newsboat_new_articles}`
  - `#{newsboat_unread_articles}`
  - `#{newsboat_unread_feeds}`

### License

[MIT](LICENSE)
