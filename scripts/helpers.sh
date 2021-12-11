default_newsboat_dir="$PLUGIN_DIR/../../newsboat"
# default dir is ~/.tmux/newsboat or ~/.config/tmux/newsboat
newsboat_dir_option="@newsboat-dir"

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

newsboat_dir() {
  if [ -z "$_NEWSBOAT_DIR" ]; then
    local path="$(get_tmux_option "$newsboat_dir_option" "$default_newsboat_dir")"
    # expands tilde, $HOME if used in @newsboat-dir
    echo "$path" | sed "s,\$HOME,$HOME,g; s,\~,$HOME,g"
  else
    echo "$_NEWSBOAT_DIR"
  fi
}
_NEWSBOAT_DIR="$(newsboat_dir)"

new_articles_file() {
  echo "$(newsboat_dir)/new_articles"
}

unread_articles_file() {
  echo "$(newsboat_dir)/unread_articles"
}

unread_feeds_file() {
  echo "$(newsboat_dir)/unread_feeds"
}
