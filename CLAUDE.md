# tint

Per-project terminal color themes for Ghostty, applied via escape sequences to individual surfaces (tabs/splits/windows). No config files modified. Closes with the tab.

## What this is

A shell function (`tint`) that applies saved themes, plus a theme generation system that extracts brand colors from a project and translates them into a terminal palette.

Two paths for theme creation:
- **Claude Code** (`/tint-create`): intelligent — reads the project's CSS/Tailwind/design tokens, infers brand identity, designs a palette. This is the recommended path.
- **Standalone** (`tint-create.sh`): prompts for hex colors, applies a deterministic mapping. Fallback for when Claude isn't available.

## Architecture

- `tint.sh` — shell function sourced by .zshrc. Handles `tint <name>`, `tint reset`, `tint ls`.
- `~/.terminal-themes/*.sh` — where generated themes live at runtime. Each file is just printf commands with OSC escape sequences.
- `commands/tint-create.md` — the Claude Code slash command. Install copies this to `~/.claude/commands/` for global availability.
- `spec.md` — the codified rules for translating brand colors into terminal palettes. This is the source of truth for generation logic.
- `tint-create.sh` — standalone bash fallback.
- `themes/` — bundled example themes, copied to `~/.terminal-themes/` on install.

## Design philosophy

The spec (`spec.md`) captures this fully, but the key ideas:

- **Two routes for the bg, chosen by survival test.** Most brands take the **brand-bg** route: signature hue at 60-100% saturation and 18-32% lightness — the bg IS the brand. Reference: Borland blue `#0000a4` = `hsl(240, 100%, 32%)`. Brands whose dominant hue is naturally luminous (yellow, amber, orange, hot pink, neon) — or that use their brand color as a sparing accent against a black surface — take the **tinted-canvas** route instead: near-black bg with a faint brand-temperature breath, brand identity carried by fg/cursor/bright ANSI slots. Picking the wrong route is how you get rust from amber and maroon from hot pink.
- **Foregrounds carry brand character** too — cream, yellow, lavender, not just neutral gray. In tinted-canvas mode the fg is a primary brand vehicle, not a contrast partner.
- **Cursor** avoids the bg hue in brand-bg mode (use the next brand color); in tinted-canvas mode the cursor MUST carry the brand's signature color at full intensity — it's the brand's anchor moment when the bg recedes.
- **"What would this brand look like as a CLI product?"** — not a literal copy of website colors, but an extrapolation that's a functional terminal theme first, brand-flavored second.

## Technical details

- OSC 11 sets background AND triggers Ghostty's titlebar color sync. Must use this instead of OSC 21's `background=` key.
- OSC 21 (Kitty color protocol) sets everything else in one sequence: foreground, cursor, cursor_text, selection_background, selection_foreground, and palette indices 0-15.
- OSC 110/111/112/104 reset everything back to the terminal's configured defaults.
- All changes are scoped to the current terminal surface. Other surfaces are unaffected.

## Development notes

- When modifying the generation logic, update `spec.md` first — it's what Claude reads during `/tint-create`.
- The `.claude/commands/tint-create.md` references `spec.md` by path. If spec moves, update the command.
- `install.sh` is idempotent — safe to re-run. It skips existing themes and checks for duplicate .zshrc entries.
- `tint-create.sh` uses basic bash hex math for the standalone path. It won't produce results as good as the Claude path — that's expected and acceptable.
