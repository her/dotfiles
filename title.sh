#!/bin/bash
function title () {
  local pkg=title
  if [[ ! $1 ]]; then
    echo "$pkg: missing required argument: title name" 1>&2
    return 99
  fi
  echo "Window Title renamed to $1"
  echo -n -e "\033]0;$1\007"
}
