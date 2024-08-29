{ config, pkgs, ... }:

{
users.defaultUserShell = pkgs.zsh;

nixpkgs.config.enableDynamicLinker = true;

  users.users.syk = {
    isNormalUser = true;
    extraGroups = [
         "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
	];
    packages = with pkgs; [
      vscode
      zed-editor
      jetbrains.idea-community

      firefox
      google-chrome
      chromium

      obsidian
      remmina

      rofi
      piper
      # gnome.gnome-tweaks
      # gnome.gnome-shell-extensions
      # gnome.nautilus

      xfce.thunar

      vesktop

      vlc
      droidcam
      spotify

      xfce.ristretto
      libreoffice

      git
      go
      rustup
      python3
      nodejs
      zig
      zls
      corepack

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
      gnumake
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
      lutris

      flameshot
      neofetch
      htop

      gdb
      gef
      gf

      zathura
    ];
  };

environment.systemPackages = with pkgs; [
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.gsconnect
    # gnomeExtensions.blur-my-shell
    wineWowPackages.stable
    winetricks
    lxappearance
    pavucontrol
    nitrogen
    variety
    autotiling
    polybar
    whitesur-gtk-theme
    mojave-gtk-theme
    gruvbox-gtk-theme
    kanagawa-gtk-theme
    papirus-icon-theme
    phinger-cursors
    nerdfonts
    libGL
    libGLU
    libglibutil
    libva-utils
    v4l-utils
    android-tools
    adb-sync
    xclip
    neovim
    vim
    wget
    curl
    fd

    # editor plugins
    luarocks
    lua
    lua-language-server
    gopls
    typescript
    clang
    clang-tools
    gcc
    marksman
    rust-analyzer

    (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  })
  ];

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

fonts.packages = with pkgs;[
    nerdfonts
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];
}
