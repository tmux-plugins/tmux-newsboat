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

```
auto-reload yes   # fetch new content when starting program
reload-time 10    # fetch new content every 10 minutes
notify-always yes # update tmux counters after every fetch
notify-format "%d %n %f"
notify-program "<plugin-installation-dir>/bin/tmux-newsboat"
```

Where `<plugin-installation-dir>` from the above will most likely be
- `~/.tmux/plugins/tmux-newsboat`
- or `~/.config/tmux/plugins/tmux-newsboat`

- Add one or more supported format strings to tmux's `status-right` (or
  `status-left if that's your thing):
  - `#{newsboat_new_articles}`
  - `#{newsboat_unread_articles}`
  - `#{newsboat_unread_feeds}`

- NOTE: this plugin assumes you have a running newsboat instance in a tmux
  pane **all the time**. This way newsboat will periodically fetch new content
  and update tmux counters.

### FAQ

- Q: I read all the articles in newsboat, but tmux counters are not all
  zero?<br/>
  A: `tmux-newsboat` counters are updated only when newsboat refreshes. That
  happens in two cases:
    - When newsboat periodically fetches new content. The interval is set with
      `reload-time` option (good value is `10` => 10 minutes).
    - Or when you manually refresh by hitting <kbd>R</kbd>.

  After reading all the articles, it is recommended to manually refresh by
  pressing <kbd>R</kbd>. The counters should update within a couple seconds.

- Q: Tmux counters update only when I open newsboat?<br/>
  A: This plugin assumes you have newsboat open in a tmux pane **all the time**.
    It also requires newsboat option `reload-time` to be set (good value is
    `10` => 10 minutes) so that newsboat fetches new content periodically, and
    updates tmux counters.

### License

[MIT](LICENSE)
