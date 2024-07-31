{ config, pkgs, ... }:

{
users.defaultUserShell = pkgs.zsh;

nixpkgs.config.enableDynamicLinker = true;

  users.users.syk = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      vscode
      zed-editor

      firefox
      google-chrome
      chromium
      
      obsidian

      rofi
      piper
      # gnome.gnome-tweaks
      # gnome.gnome-shell-extensions
      # gnome.nautilus

      xfce.thunar

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

      osu-lazer-bin

      flameshot
      neofetch
      htop

      zathura
    ];
  };

environment.systemPackages = with pkgs; [
    tree-sitter
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.gsconnect
    # gnomeExtensions.blur-my-shell
    openrgb-with-all-plugins
    # wineWowPackages.waylandFull
    lxappearance
    nitrogen
    autotiling
    polybar
    whitesur-gtk-theme
    mojave-gtk-theme
    gruvbox-gtk-theme
    kanagawa-gtk-theme
    papirus-icon-theme
    phinger-cursors
    nerdfonts
    xclip
    neovim
    vim
    wget
    curl

    # editor plugins
    luarocks
    lua-language-server
    gopls
  ];

fonts.packages = with pkgs;[ nerdfonts ];
}
