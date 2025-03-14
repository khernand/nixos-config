{
  config,
  lib,
  nhModules,
  pkgs,
  ...
}: {

  xdg.enable = true;
  
  # Consistent cursor theme across all applications.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 24;
  };

  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export QT_QPA_PLATFORM=wayland
      export MOZ_ENABLE_WAYLAND="1"
      export XDG_SESSION_TYPE="wayland"
      export XDG_CURRENT_DESKTOP="sway"
      export EGL_PLATFORM=wayland
      export NIXOS_OZONE_WL=1
    '';

    extraOptions = [ "--unsupported-gpu" ]; 
 
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "kitty";}
      ];
    };
  };
}
