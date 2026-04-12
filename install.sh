#!/usr/bin/env bash
# tint installer

set -e

TINT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEMES_DIR="$HOME/.terminal-themes"
CLAUDE_CMD_DIR="$HOME/.claude/commands"

echo "installing tint..."

# Create themes directory
mkdir -p "$THEMES_DIR"

# Copy bundled themes
if [[ -d "$TINT_DIR/themes" ]]; then
  for f in "$TINT_DIR/themes"/*.sh; do
    [[ -f "$f" ]] || continue
    name="$(basename "$f")"
    if [[ -f "$THEMES_DIR/$name" ]]; then
      echo "  skip $name (already exists)"
    else
      cp "$f" "$THEMES_DIR/$name"
      echo "  added $name"
    fi
  done
fi

# Add source line to .zshrc if not already there
SOURCE_LINE="source \"$TINT_DIR/tint.sh\""
if ! grep -qF "tint.sh" ~/.zshrc 2>/dev/null; then
  printf '\n# tint — per-project terminal themes\n%s\n' "$SOURCE_LINE" >> ~/.zshrc
  echo "  added tint to .zshrc"
else
  echo "  tint already in .zshrc"
fi

# Install Claude Code command (global, available in all sessions)
mkdir -p "$CLAUDE_CMD_DIR"
if [[ -f "$TINT_DIR/commands/tint-create.md" ]]; then
  cp "$TINT_DIR/commands/tint-create.md" "$CLAUDE_CMD_DIR/tint-create.md"
  echo "  installed /tint-create command for Claude Code"
fi

# Make tint-create.sh executable
chmod +x "$TINT_DIR/tint-create.sh"

echo ""
echo "done. restart your shell or run: source ~/.zshrc"
echo ""
echo "  tint ls          list themes"
echo "  tint <name>      apply a theme"
echo "  tint reset       back to default"
echo "  /tint-create     generate a theme with Claude Code"
