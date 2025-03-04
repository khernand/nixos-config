{
  config,
  lib,
  nhModules,
  pkgs,
  ...
}: {
  imports = [
    "${nhModules}/desktop/hyprland/gtk"
    "${nhModules}/desktop/hyprland/wallpaper"
    "${nhModules}/desktop/hyprland/xdg"
    "${nhModules}/desktop/hyprland/swappy"
    "${nhModules}/desktop/hyprland/wofi"
    "${nhModules}/desktop/hyprland/cliphist"
    "${nhModules}/desktop/hyprland/swaync"
    "${nhModules}/desktop/hyprland/waybar"
  ];

  # Consistent cursor theme across all applications.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 24;
  };

  # Source hyprland config from the home-manager store
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };

    "hypr/hyprpaper.conf".text = ''
      splash = false
      preload = ${config.wallpaper}
      wallpaper = HDMI-A-1, ${config.wallpaper}
    '';

    "hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
      }
    '';

    "hypr/hyprlock.conf".text = ''
      background {
          monitor = HDMI-A-1
          path = ${config.wallpaper}
          blur_passes = 3
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
      }

      general {
          no_fade_in = false
          grace = 0
          disable_loading_bar = trues
      }

      input-field {
          monitor = HDMI-A-1
          size = 250, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(0, 0, 0, 0)
          inner_color = rgba(0, 0, 0, 0.5)
          font_color = rgb(200, 200, 200)
          fade_on_empty = false
          capslock_color = -1
          placeholder_text = <i><span foreground="##e6e9ef">Password</span></i>
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          hide_input = false
          position = 0, -120
          halign = center
          valign = center
      }

      # Date
      label {
        monitor = HDMI-A-1
        text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
        color = rgba(255, 255, 255, 0.8)
        font_size = 15
        font_family = Fira Code
        position = 0, -400
        halign = center
        valign = top
      }

      # Time
      label {
          monitor = HDMI-A-1
          text = cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"
          color = rgba(255, 255, 255, 0.8)
          font_size = 120
          font_family = Fira Code
          position = 0, -400
          halign = center
          valign = top
      }

      # Keyboard layout
      label {
        monitor = DFP-0
        text = $LAYOUT
        color = rgba(255, 255, 255, 0.9)
        font_size = 10
        font_family = Fira Code
        position = 0, -175
        halign = center
        valign = center
      }
    '';
  };

  dconf.settings = {
    "org/blueman/general" = {
      "plugin-list" = lib.mkForce ["!StatusNotifierItem"];
    };

    "org/blueman/plugins/powermanager" = {
      "auto-power-on" = true;
    };

    "org/gnome/calculator" = {
      "accuracy" = 9;
      "angle-units" = "degrees";
      "base" = 10;
      "button-mode" = "basic";
      "number-format" = "automatic";
      "show-thousands" = false;
      "show-zeroes" = false;
      "source-currency" = "";
      "source-units" = "degree";
      "target-currency" = "";
      "target-units" = "radian";
      "window-maximized" = false;
    };

    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "cursor-theme" = "Yaru";
      "font-name" = "Roboto 11";
      "icon-theme" = "Tela-circle-dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = lib.mkForce "";
    };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "list-view";
      "migrated-gtk-settings" = true;
      "search-filter-time-type" = "last_modified";
      "search-view" = "list-view";
    };

    "org/gnome/nm-applet" = {
      "disable-connected-notifications" = true;
      "disable-vpn-notifications" = true;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      "show-hidden" = true;
    };

    "org/gtk/settings/file-chooser" = {
      "date-format" = "regular";
      "location-mode" = "path-bar";
      "show-hidden" = true;
      "show-size-column" = true;
      "show-type-column" = true;
      "sort-column" = "name";
      "sort-directories-first" = false;
      "sort-order" = "ascending";
      "type-format" = "category";
      "view-type" = "list";
    };
  };
}
