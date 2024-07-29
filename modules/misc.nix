{ config, pkgs, lib, ... }:

{
  programs.zsh.enable = true;
    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_US.UTF-8";
    environment.variables.XCURSOR_SIZE = "24";
    programs.dconf.enable = true;
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
             "spotify"
	     "vscode"
	     "google-chrome"
	     "obsidian"
	     "osu-lazer-bin"
	     "nvidia-x11"
	     "nvidia-settings"
    ];
}
