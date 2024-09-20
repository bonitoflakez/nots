echo "copying nix config"
cp -r /etc/nixos/configuration.nix .
cp -r /etc/nixos/modules .

echo "copying base dots"
cp -r ~/.config/i3 .
cp -r ~/.config/polybar .
cp -r ~/.config/nvim .
cp -r ~/.config/kitty .
cp -r ~/.config/zathura .
cp -r ~/.tmux.conf .
cp -r ~/.config/doom .

echo "done"

