{
  dotfilesDir,
  ...
}: {
  home.file.".config/kitty/KittyTheme.conf".source = "${dotfilesDir}/kitty/KittyTheme.conf";
  home.file.".config/kitty/nvimSplit.conf".source = "${dotfilesDir}/kitty/nvimSplit.conf";

  programs.ghostty = {
    enable = true;
  };
}
