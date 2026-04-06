# tint — Theme Generation Spec

Rules for translating a project's brand colors into a functional terminal palette.

The goal is not to replicate the project's UI in a terminal. It's to answer: **"What would this brand look like if it were a CLI product?"** Extract the essence, make it work as a terminal theme first, carry the brand's DNA second.

## Background

- **Hue**: from the brand's dominant/signature color.
- **Saturation**: 60-100%. Preserve the brand's intensity. This is the primary visual differentiator between themes — don't wash it out.
- **Lightness**: 18-32%. Dark enough for light text, saturated enough to be instantly recognizable. Reference: Borland blue is `hsl(240, 100%, 32%)`.
- **Hue-specific adjustment**: greens and blues can tolerate higher lightness (~28-32%). Purples and reds feel heavier — keep them at 18-24%.
- **If the brand is monochrome/black**: pick the most "structural" brand color (e.g., the one used in the logo or primary actions) and use that hue instead.

## Foreground

- **Can carry brand character.** It doesn't have to be neutral gray. If the brand has a natural light color (cream, gold, lavender), adapt it for the foreground.
- **Minimum ~7:1 contrast ratio** against background.
- **Lightness**: 75-95%. Warm/cool temperature should match the brand.
- **Complementary pairings work well**: green bg + cream fg, blue bg + yellow fg, purple bg + lavender fg.

## Cursor

- The brand's **most vivid/identifiable color** that isn't the background hue.
- Must contrast strongly against background.
- Avoid same-hue-family as background (no green cursor on green bg). Pick the next most prominent brand color instead.

## Selection

- **Background**: same hue as main background, lightness bumped +15-20%.
- **Foreground**: near-white, high contrast. Can be the brightest brand-adjacent light color.

## ANSI Palette (0-15)

### Mapping priority
1. Brand colors fill their nearest ANSI slots first (brand red → slot 1, brand blue → slot 4, etc.)
2. Missing slots are extrapolated by **bridging adjacent brand hues** (e.g., no magenta in brand → blend the red and blue hues).
3. Normal weight (slots 1-6): slightly muted from brand intensity — these are "working" colors for everyday terminal output.
4. Bright weight (slots 9-14): full brand intensity — these are highlights and emphasis.

### Contrast requirements
- All normal ANSI colors (1-6) on background: minimum ~4.5:1 contrast.
- **Beware same-family conflicts**: if background is green, ANSI green (slot 2) must be a distinctly lighter/different shade of green, or shifted toward cyan/mint. Same logic for blue bg + ANSI blue, purple bg + ANSI magenta, etc.

### Black and white slots
- **0 (black)**: slightly lighter than background. Provides visible contrast for borders/panels.
- **7 (white)**: slightly dimmer than foreground. Creates text hierarchy.
- **8 (bright black)**: midpoint gray, can carry a subtle brand hue tint.
- **15 (bright white)**: near-white, the brightest text available. Can match/derive from foreground.

## Output format

Themes are saved as shell scripts in `~/.terminal-themes/<name>.sh`:

```bash
# Background via OSC 11 (triggers Ghostty titlebar sync)
printf '\e]11;#RRGGBB\e\\'

# Everything else via OSC 21 (Kitty color protocol)
printf '\e]21;foreground=#RRGGBB;cursor=#RRGGBB;cursor_text=#RRGGBB;selection_background=#RRGGBB;selection_foreground=#RRGGBB;0=#RRGGBB;1=#RRGGBB;2=#RRGGBB;3=#RRGGBB;4=#RRGGBB;5=#RRGGBB;6=#RRGGBB;7=#RRGGBB;8=#RRGGBB;9=#RRGGBB;10=#RRGGBB;11=#RRGGBB;12=#RRGGBB;13=#RRGGBB;14=#RRGGBB;15=#RRGGBB\e\\'
```

Background MUST use OSC 11 (not OSC 21's `background=`) because Ghostty uses OSC 11 to sync the titlebar color.
