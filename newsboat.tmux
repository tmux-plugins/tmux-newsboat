#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_DIR="$CURRENT_DIR" # required by scripts/helpers.sh

source "$CURRENT_DIR/scripts/helpers.sh"

interpolation_strings=(
  "\#{newsboat_new_articles}"
  "\#{newsboat_unread_articles}"
  "\#{newsboat_unread_feeds}"
)

interpolation_commands=(
  "#(cat '$(new_articles_file)')"
  "#(cat '$(unread_articles_file)')"
  "#(cat '$(unread_feeds_file)')"
)

create_default_files() {
  mkdir -p "$(newsboat_dir)"

  if [ ! -f "$(new_articles_file)" ]; then
    echo "?" > "$(new_articles_file)"
  fi
  if [ ! -f "$(unread_articles_file)" ]; then
    echo "?" > "$(unread_articles_file)"
  fi
  if [ ! -f "$(unread_feeds_file)" ]; then
    echo "?" > "$(unread_feeds_file)"
  fi
}

interpolate() {
  local interpolated="$1"
  local count="${#interpolation_commands[@]}"
  for ((i=0; i<"$count"; i++)); do
    interpolated=${interpolated//${interpolation_strings[$i]}/${interpolation_commands[$i]}}
  done
  echo "$interpolated"
}

update_status_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  set_tmux_option "$option" "$(interpolate "$option_value")"
}

main() {
  create_default_files

  update_status_option "status-right"
  update_status_option "status-left"
}
main
