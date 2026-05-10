Create a terminal color theme for the current project based on its brand colors and design system.

## Steps

1. **Extract colors.** Search the project for brand colors in: CSS variables, Tailwind config, design tokens, brand constants, SVG assets, component files. Report what you find. Note how each color is *used* in the brand (logo, primary action, fill, accent, sparingly-vs-everywhere) — this matters for choosing the route in step 3.

2. **Read the spec.** Read `~/Documents/GitHub/tint/spec.md` for the generation rules.

3. **Choose the route, then design the palette.** Run the survival test from the spec on the brand's dominant hue to choose between the **brand-bg** and **tinted-canvas** routes. Sparse-signal brands (one logo color, no design system) and accent-only brands (brand color used as a sparing pop, not a fill) lean tinted-canvas even when the survival test passes. State the route you picked and why in one or two sentences before designing — this is the single highest-leverage decision in the theme. Then map the brand colors into a full terminal theme: background, foreground, cursor, selection, and ANSI 0-15. Briefly explain what you extrapolated.

4. **Show a compact summary.** Print a short table of the key colors (bg, fg, cursor, and the 6 main ANSI colors) with their hex values and what brand color they came from.

5. **Save with default name.** Use the current folder name as the theme name. Write the theme file to `~/.terminal-themes/<name>.sh` following the output format in the spec. Include a comment header with the project name and a one-line description of the brand essence.

6. **Ask the user to preview.** Tell the user to open a separate terminal and run `tint <name>` to see the theme live. Wait for their feedback — they may request color adjustments.

7. **Confirm or rename.** Ask:
   ```
   Keep as: [name]? Or suggest a different name.
   ```
   If the user gives a new name, rename the file in `~/.terminal-themes/`.

## Important

- The theme must work as a **functional terminal first**. Readable, good contrast, all 16 ANSI colors usable.
- The bg carries brand identity in one of two ways — either as the brand's signature hue (saturated, bold, brand-bg route) or as a near-black canvas tinted with the brand's temperature (tinted-canvas route). The survival test in the spec is how you choose. Once chosen, commit fully — don't hedge between the two.
- Don't chase a brand color into the saturated-bg range when its color name doesn't survive translation. Amber pulled to L=24% becomes rust; that rust may look fine, but it isn't the brand. When the math drifts into a different color category, take the tinted-canvas route instead.
- If a brand color doesn't work directly as a terminal color (too bright, too dark, bad contrast), **extrapolate** — find a version that carries the same energy in a terminal context. "Same energy" means same color category and same brand semantics, not just adjacent on the wheel.
- Don't just darken brand colors. Think: "What would this brand look like if it shipped a CLI?"
