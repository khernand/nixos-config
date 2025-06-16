{
  dotfiles,
  dotfilesDir,
  ...
}: {
  home.file.".config/kitty/KittyTheme.conf".source = "${dotfiles}/KittyTheme.conf";
  home.file.".config/kitty/nvimSplit.conf".source = "${dotfilesDir}/kitty/nvimSplit.conf";

  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family Fira Code
      font_size 12
      include ${dotfiles}/KittyTheme.conf
      allow_remote_control yes
      map ctrl+down resize_window shorter
      map ctrl+up resize_window taller
    '';
  };
}
