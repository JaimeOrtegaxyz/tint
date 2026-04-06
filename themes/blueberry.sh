# Blueberry — deep indigo skin, leaf-green cursor
# Rich berry purple with frost-lavender text

# Background via OSC 11 (triggers titlebar sync)
printf '\e]11;#281862\e\\'

# Everything else via OSC 21
printf '\e]21;foreground=#d4d0e8;cursor=#38a838;cursor_text=#281862;selection_background=#3e2880;selection_foreground=#ece8f6;0=#160e40;1=#d05060;2=#48a850;3=#c8aa50;4=#6080d8;5=#a860c8;6=#4898b0;7=#a8a0c0;8=#483878;9=#e86878;10=#60cc68;11=#e0c060;12=#80a0f0;13=#c880e0;14=#60b8d0;15=#e8e4f4\e\\'
