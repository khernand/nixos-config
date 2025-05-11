{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
  ];
}
