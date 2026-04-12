Create a terminal color theme for the current project based on its brand colors and design system.

## Steps

1. **Extract colors.** Search the project for brand colors in: CSS variables, Tailwind config, design tokens, brand constants, SVG assets, component files. Report what you find.

2. **Read the spec.** Read `~/Documents/GitHub/tint/spec.md` for the generation rules.

3. **Design the palette.** Following the spec, map the brand colors into a full terminal theme: background, foreground, cursor, selection, and ANSI 0-15. Explain your key decisions briefly (which color became the background, why, what you extrapolated).

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
- Backgrounds should be **bold and saturated** (see spec). Not "dark with a hint" — the background IS the brand differentiator.
- If a brand color doesn't work directly as a terminal color (too bright, too dark, bad contrast), **extrapolate** — find a version that carries the same energy but works in a terminal context.
- Don't just darken brand colors. Think: "What would this brand look like if it shipped a CLI?"
