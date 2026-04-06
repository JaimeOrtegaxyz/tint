# tint — apply per-project terminal themes to the current surface
# Source this file from your .zshrc

tint() {
  local themes_dir="$HOME/.terminal-themes"
  if [[ "$1" == "reset" ]]; then
    printf '\e]111\e\\'; printf '\e]110\e\\'; printf '\e]112\e\\'; printf '\e]104\e\\'
    return
  fi
  if [[ -z "$1" || "$1" == "ls" ]]; then
    for f in "$themes_dir"/*.sh(N); do
      local name="${${f:t}%.sh}"
      local hex=$(grep '\\e\]11;' "$f" | grep -o '#[0-9a-fA-F]\{6\}' | head -1)
      if [[ -n "$hex" ]]; then
        local r=$((16#${hex:1:2})) g=$((16#${hex:3:2})) b=$((16#${hex:5:2}))
        printf '\e[48;2;%d;%d;%dm  \e[0m %s\n' "$r" "$g" "$b" "$name"
      else
        printf '  %s\n' "$name"
      fi
    done
    printf '   reset\n'
    return
  fi
  local theme="$themes_dir/$1.sh"
  if [[ -f "$theme" ]]; then
    source "$theme"
  else
    echo "no theme '$1' — run 'tint ls' to list"
  fi
}
