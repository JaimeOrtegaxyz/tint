# Apple — red skin, cream flesh
# Saturated red like a fresh gala, warm creamy foreground

# Background via OSC 11 (triggers titlebar sync)
printf '\e]11;#630d14\e\\'

# Everything else via OSC 21
printf '\e]21;foreground=#f0e6da;cursor=#f0e8d0;cursor_text=#630d14;selection_background=#7a2828;selection_foreground=#f5f0e8;0=#3a0a10;1=#e06050;2=#5eaa50;3=#d8b450;4=#5080b8;5=#c060a0;6=#40a8a0;7=#c0b0a0;8=#6a2020;9=#f07060;10=#70cc60;11=#f0cc60;12=#70a0d8;13=#e080c0;14=#60c8c0;15=#f5ece0\e\\'
