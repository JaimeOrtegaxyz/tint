# tint — apply per-project terminal themes to the current surface
# Source this file from your .zshrc

tint() {
  local themes_dir="$HOME/.terminal-themes"
  if [[ "$1" == "reset" ]]; then
    printf '\e]111\e\\'; printf '\e]110\e\\'; printf '\e]112\e\\'; printf '\e]104\e\\'
    return
  fi
  if [[ "$1" == "rename" || "$1" == "mv" ]]; then
    local old="$2" new="$3"
    if [[ -z "$old" || -z "$new" ]]; then
      echo "usage: tint rename <old> <new>"
      return 1
    fi
    if [[ ! -f "$themes_dir/$old.sh" ]]; then
      echo "no theme '$old' — run 'tint ls' to list"
      return 1
    fi
    if [[ -e "$themes_dir/$new.sh" ]]; then
      echo "theme '$new' already exists"
      return 1
    fi
    mv "$themes_dir/$old.sh" "$themes_dir/$new.sh" || return 1
    # keep the header comment in sync if it led with the old name
    local first=$(head -1 "$themes_dir/$new.sh")
    if [[ "${(L)first}" == "# ${(L)old}"* ]]; then
      local rest="${first:$(( ${#old} + 2 ))}"
      printf '%s\n' "# $new$rest" > "$themes_dir/.tint-rename.$$"
      tail -n +2 "$themes_dir/$new.sh" >> "$themes_dir/.tint-rename.$$"
      mv "$themes_dir/.tint-rename.$$" "$themes_dir/$new.sh"
    fi
    echo "renamed '$old' → '$new'"
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
