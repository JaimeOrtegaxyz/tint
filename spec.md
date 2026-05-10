# tint — Theme Generation Spec

Rules for translating a project's brand colors into a functional terminal palette.

The goal is not to replicate the project's UI in a terminal. It's to answer: **"What would this brand look like if it were a CLI product?"** Extract the essence, make it work as a terminal theme first, carry the brand's DNA second.

**Always dark, even for light-dominant brands.** Terminal apps (Claude Code, less, syntax highlighters, `ls --color`) emit muted text and dim accents via ANSI slots 7/8 and via true-color RGB hex codes tuned for dark backgrounds. A light-bg theme will have readability casualties no palette can fix. For high-key brands (bright pastels, neon, white-dominant), express the brand through the bg's temperature, the foreground tint, the cursor, and brand-quoted ANSI slots — not by inverting terminal polarity. Only ship a light theme when the user explicitly asks AND accepts the tradeoff.

## Two routes for the background

Most brands take the **brand-bg** route: their signature hue translates cleanly into the saturated dark range and dyes the entire terminal canvas in brand color. Borland blue, deep racing green, aubergine, Stripe purple — these brands *want* their hue at L=18-32%, and the math cooperates.

Some brands need the **tinted-canvas** route: the bg recedes to near-black with a faint brand-temperature breath, and the brand identity lives in the foreground, cursor, and bright ANSI slots instead. This is not a fallback or a compromise — it's the right answer for two specific brand shapes:

- **High-key brands** — the signature hue is naturally luminous (bright yellow, lime, orange, amber, hot pink, neon). Pulled into the spec's dark range, these don't become "dark version of the brand" — they become a different color category. Yellow becomes olive. Amber becomes rust. Hot pink becomes maroon. The result might look fine, but it is no longer the brand. Even though the dimmed hue is mathematically adjacent, the new color carries different brand semantics — rust says "rugged, vintage, leather"; amber says "phosphor, signal, alert." Adjacent on the wheel, opposite in meaning.
- **OLED-native or accent-only brands** — the brand's actual canvas is black or near-black, and the brand hue is used as a sparing accent rather than a fill. Apple, many modern hardware brands, anything where "the surface is dark and one brand color lights up against it." Dyeing the bg in the brand hue overstates how the brand actually presents itself.

### The survival test

Before designing the bg, run this on the brand's dominant hue:

1. Set the brand hue to ~24% lightness with maxed saturation (middle of the brand-bg range).
2. Would someone naming the result reach for the brand's color name? Or a different color name?

| Brand hue at L≈24% | Reads as | Verdict |
|---|---|---|
| Borland blue | blue | brand-bg ✓ |
| Racing green | green | brand-bg ✓ |
| Aubergine purple | purple | brand-bg ✓ |
| Burgundy red | red | brand-bg ✓ |
| Brand amber / orange | rust / brown | tinted-canvas |
| Brand yellow | olive / mud | tinted-canvas |
| Neon / lime green | forest / sludge | tinted-canvas |
| Hot pink | maroon | tinted-canvas |

If the answer is "different color name," do not chase it by pushing lightness higher within the brand-bg range — that's a sign you're on the wrong route. The mathematical neighbor is not the brand. Take the tinted-canvas path.

The OLED-native check is separate. Even if the brand hue would survive translation, ask whether the brand actually *presents* as a saturated fill anywhere in its real design language. If the brand is consistently "near-black surface with one brand-color accent," tinted-canvas is the more honest route regardless of what the survival test says.

### Choosing under sparse signal

A brand with a single logo color and no design system is a strong tinted-canvas candidate by default. With only one color to work with, the brand-bg route forces that color into a job (filling 90% of the screen) it was never asked to do. The tinted-canvas route lets that single color play the role it actually plays in the brand: an accent that lights up against a neutral surface.

## Background — brand-bg route

When the brand hue survives the survival test:

- **Hue**: from the brand's dominant/signature color.
- **Saturation**: 60-100%. Preserve the brand's intensity. This is the primary visual differentiator between themes — don't wash it out.
- **Lightness**: 18-32%. Dark enough for light text, saturated enough to be instantly recognizable. Reference: Borland blue is `hsl(240, 100%, 32%)`.
- **Perceived brightness ≠ HSL lightness.** Hues that read as naturally heavy (purples, deep blues, magentas, deep reds) sit at the lower end of the range — pushed higher they feel oppressive. Greens and blues sit comfortably in the middle. Naturally luminous hues (yellows, limes, oranges, warm cyans) should not be on this route at all — they fail the survival test by definition. If you're tempted to push one to the top of the range to keep its color name, you're fighting the route. Switch to tinted-canvas instead.
- **If the brand is monochrome/black**: pick the most "structural" brand color (e.g., the logo or primary action color) and re-run the survival test on it.

## Background — tinted-canvas route

When the brand hue won't survive translation, or the brand is OLED-native or accent-only:

- **Lightness**: 4-10%. Below the brand-bg range, intentionally. The bg should read as "almost black" — not as a color in its own right.
- **Saturation**: 30-60%. Enough that the warmth or coolness is felt, not enough that the bg names itself. The eye should see "dark" first and only register the temperature on a second look.
- **Hue**: matched to the brand's *temperature*, not its color directly. Warm-brand (amber, red, orange, hot pink) → bg hue in the 15-30° range. Cool-brand (cyan, blue, mint) → bg hue in the 200-220° range. The bg is the *room the brand sits in*, not a dim copy of the brand itself.
- **Don't go pure `#000`.** A flat black is correct for some terminals but it isn't a *theme* — it doesn't differentiate brands from each other. The faint temperature is what makes a tinted-canvas theme readable as branded versus a generic dark terminal.

The point of this route is that the brand stops trying to be the bg and starts being the *thing on the bg*. That means the rest of the palette has to do more brand work — see the foreground, cursor, and ANSI sections below for how they shift in this mode.

## Foreground

- **Can carry brand character.** It doesn't have to be neutral gray. If the brand has a natural light color (cream, gold, lavender), adapt it for the foreground.
- **Minimum ~7:1 contrast ratio** against background.
- **Lightness**: 75-95%. Warm/cool temperature should match the brand.
- **In tinted-canvas mode, the foreground is a primary brand vehicle.** Pull it strongly toward the brand color — warm amber/cream for an amber brand, frost-blue for a cool brand. The fg is doing brand work the bg isn't, so don't be shy. Think "this is what light looks like in the brand's world."
- **When the brand-bg sits high in its lightness band** (heavy-hue bgs at the top, ~28-32%), push the foreground to the top of its range (~92-95%). The 7:1 ratio gets tight at the bright end; foregrounds need to reach near-white to hold contrast.
- **Complementary pairings work well**: green bg + cream fg, blue bg + yellow fg, purple bg + lavender fg.

## Cursor

- The brand's **most iconic single-color moment** — where the recognizable brand hue lives at full intensity.
- **In brand-bg mode**: the bg already carries the iconic hue at lower lightness, so the cursor uses the next most prominent brand color. Avoid same-hue-family as bg (no green cursor on green bg).
- **In tinted-canvas mode**: the cursor MUST be the brand's signature color at full, undiluted intensity. This is non-negotiable — when the bg recedes, the cursor becomes the brand's anchor moment. If the brand has only one color, this is where it lives at full strength. The cursor is the smallest possible carrier of the strongest possible brand statement.
- Must contrast strongly against background.

## Selection

- **Background**: same hue as main background, lightness bumped +15-20%.
- **Foreground**: near-white, high contrast. Can be the brightest brand-adjacent light color.

## ANSI Palette (0-15)

### Mapping priority
1. Brand colors fill their nearest ANSI slots first (brand red → slot 1, brand blue → slot 4, etc.)
2. Missing slots are extrapolated by **bridging adjacent brand hues** (e.g., no magenta in brand → blend the red and blue hues).
3. Normal weight (slots 1-6): slightly muted from brand intensity — these are "working" colors for everyday terminal output.
4. Bright weight (slots 9-14): full brand intensity — these are highlights and emphasis.

### Tinted-canvas mode shifts the normal/bright split harder

When the bg recedes, the ANSI palette has to carry more brand weight. Widen the gap between normal and bright:

- **Normal slots (1-6)**: lean toward the brand's temperature — warm-tinted reds, oranges, olives for an amber brand; cool-tinted muted variants for a cool brand. The everyday working surface should feel monochrome-ish, like an amber-phosphor monitor, not like a full rainbow on black. Saturation lower than usual (40-60%).
- **Bright slots (9-14)**: full brand intensity, undiluted. When something explicitly emphasizes, the full brand palette appears. This mirrors how high-key and OLED-native brands actually work in their own UIs — monochrome surface most of the time, brand color on demand.

The result is a surface that *whispers* the brand and *shouts* it on emphasis. That's the right pattern for these brands — they don't shout all the time, and a CLI theme shouldn't either.

### Contrast requirements
- All normal ANSI colors (1-6) on background: minimum ~4.5:1 contrast.
- **Beware same-family conflicts in brand-bg mode**: if background is green, ANSI green (slot 2) must be a distinctly lighter/different shade of green, or shifted toward cyan/mint. Same logic for blue bg + ANSI blue, purple bg + ANSI magenta. (In tinted-canvas mode, the bg is too dark for hue-family conflicts to matter much.)

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
