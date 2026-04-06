# tint — apply per-project terminal themes to the current surface
# Source this file from your .zshrc

tint() {
  local themes_dir="$HOME/.terminal-themes"
  if [[ "$1" == "reset" ]]; then
    printf '\e]111\e\\'; printf '\e]110\e\\'; printf '\e]112\e\\'; printf '\e]104\e\\'
    return
  fi
  if [[ -z "$1" || "$1" == "ls" ]]; then
    echo "available themes:"
    for f in "$themes_dir"/*.sh(N); do
      echo "  ${${f:t}%.sh}"
    done
    echo "  reset"
    return
  fi
  local theme="$themes_dir/$1.sh"
  if [[ -f "$theme" ]]; then
    source "$theme"
  else
    echo "no theme '$1' — run 'tint ls' to list"
  fi
}
