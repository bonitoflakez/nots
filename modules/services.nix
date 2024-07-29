{ config, pkgs, ... }:

{
services.xserver.enable = true;
services.xserver.desktopManager.gnome.enable = true;
services.xserver.displayManager.gdm.enable = true;

services.gnome.core-utilities.enable = true;
services.gnome.games.enable = false;
services.gnome.core-developer-tools.enable = true;

services.xserver = {
  windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
	  i3lock
      i3blocks
    ];
  };
};

services.xserver.windowManager.i3.package = pkgs.i3-gaps;
services.ratbagd.enable = true;
services.xserver.xkb.layout = "us";
  services.hardware.openrgb.enable = true;

  services.openssh.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    # vSync = true;
    shadow = true;
    fadeDelta = 4 ;
    inactiveOpacity = 1;
    activeOpacity = 1;
    menuOpacity = 1.0;
    backend = "glx";
    settings = {
      blur = {
	method = "dual_kawase";
	background = true;
	strength = 2;
    };
  };

  wintypes = {
    popup_menu = { opacity = config.services.picom.menuOpacity; };
    dropdown_menu = { opacity = config.services.picom.menuOpacity; };
    menu = { shadow = false; };
  };
 };

  services.printing.enable = true;
}
