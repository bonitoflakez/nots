{ config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  users.users.syk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      neovim
      vscode
      zed-editor

      firefox
      google-chrome

	  obsidian

      rofi
      piper
      gnome.gnome-tweaks
      gnome.gnome-shell-extensions
      gnome.nautilus

      vesktop

      vlc
      obs-studio
      spotify

      git
      go
      rustup
      python3
      nodejs

      zsh
      unzip
      zip
      xz
      p7zip
      ripgrep
      jq
      fzf
      cowsay
      file
      which
      tree
      gawk
      strace
      ltrace
      lsof
      pciutils
      usbutils
      dnsutils
      socat
      nmap
      ipcalc

      nerdfonts

      osu-lazer-bin

      neofetch
	  htop
    ];
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.blur-my-shell
    openrgb-with-all-plugins
    wineWowPackages.waylandFull
    lxappearance
    nitrogen
    autotiling
    polybar
    whitesur-gtk-theme
    mojave-gtk-theme
    gruvbox-gtk-theme
    papirus-icon-theme
    phinger-cursors
    xclip
    vim
    wget
    curl
  ];
}
