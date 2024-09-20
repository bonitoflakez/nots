{ config, pkgs, ... }:

{
users.defaultUserShell = pkgs.zsh;

nixpkgs.config.enableDynamicLinker = true;

  users.users.syk = {
    isNormalUser = true;
    extraGroups = [
         "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"
    ];
    packages = with pkgs; [
      emacs
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
      python3
      nodejs
      zig
      zls
      rust-analyzer
      rustup
      corepack
      nasm
      asm-lsp
      gopls
      lua-language-server
      vscode-langservers-extracted
      svelte-language-server
      typescript 
      typescript-language-server
      tailwindcss-language-server
      pyright

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
      
      qemu
      tmux

      prismlauncher
      jdk17
      ffmpeg

      cmake
      libtool
    ];
  };

environment.systemPackages = with pkgs; [
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
  typescript
  clang
  clang-tools
  gcc
  marksman
  rust-analyzer

  nixfmt-classic

  dive

  docker
  nvidia-docker

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
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
};

programs.nix-ld.enable = true;
programs.nix-ld.libraries = with pkgs; [
  zlib
  xorg.libXext
  xorg.libX11
  xorg.libXrender
  xorg.libXtst
  xorg.libXi
  freetype
];

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
