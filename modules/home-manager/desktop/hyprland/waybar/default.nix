{...}: {
  # Install and configure waybar via home-manager module
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        ipc = true;
        margin-top = 3;
        margin-left = 4;
        margin-right = 4;

        modules-left = [
          "hyprland/workspaces"
          "cpu"
          "temperature"
          "memory"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "bluetooth"
          "pulseaudio"
          "custom/notification"
        ];

        bluetooth = {
          format = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          on-click = "blueman-manager";
        };

        clock = {
          format = "{:%b %d %H:%M}";
          format-alt = " {:%H:%M   %Y, %d %B, %A}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          format = "󰍛 {usage}%";
          interval = 1;
        };
        
        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{name}";
          on-click = "activate";
          show-special = false;
          sort-by-number = true;
        };

        memory = {
          interval = 10;
          format = "󰾆 {used:0.1f}G";
          format-alt = "󰾆 {percentage}%";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
          on-click-right = "foot --title btop sh -c 'btop'";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}  {volume} %";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          on-click-right = "pamixer -t";
          smooth-scrolling-threshold = 1;
          ignored-sinks = ["Easy Effects Sink"];
        };

        temperature = {
          interval = 10;
          tooltip = false;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 82;
          format-critical = "{icon} {temperatureC}°C";
          format = "󰈸 {temperatureC}°C";
        };

        tray = {
          size = 21;
          spacing = 10;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
    style = ''
    @define-color rosewater #f5e0dc;
    @define-color flamingo #f2cdcd;
    @define-color pink #f5c2e7;
    @define-color mauve #cba6f7;
    @define-color red #f38ba8;
    @define-color maroon #eba0ac;
    @define-color peach #fab387;
    @define-color yellow #f9e2af;
    @define-color green #a6e3a1;
    @define-color teal #94e2d5;
    @define-color sky #89dceb;
    @define-color sapphire #74c7ec;
    @define-color blue #89b4fa;
    @define-color lavender #b4befe;
    @define-color text #cdd6f4;
    @define-color subtext1 #bac2de;
    @define-color subtext0 #a6adc8;
    @define-color overlay2 #9399b2;
    @define-color overlay1 #7f849c;
    @define-color overlay0 #6c7086;
    @define-color surface2 #585b70;
    @define-color surface1 #45475a;
    @define-color surface0 #313244;
    @define-color base #1e1e2e;
    @define-color mantle #181825;
    @define-color crust #11111b;

    * {
      font-family: Fira Code;
      font-size: 17px;
      min-height: 0;
    }

    window#waybar {
      background-color: shade(@base, 0.9);
      border: 2px solid alpha(@crust, 0.3);
      border-radius: 1rem;
    }

    #waybar {
      background: transparent;
      color: @text;
      margin: 10px;
    }

    #workspaces {
      background-color: @surface0;
      margin: 5px 5px 5px 1rem;
      border-radius: 1rem;
    }

    #workspaces button {
      color: @lavender;
      border-radius: 1rem;
      padding: 0.4rem;
    }

    #workspaces button.active {
      color: @sky;
    }

    #workspaces button:hover {
      color: @sapphire;
    }

    #modules-center > *:last-child {
      margin-right: 2rem;
    }

    #modules-right > *:last-child {
      margin-right: 2rem;
    }

    #tray,
    #clock,
    #pulseaudio
    #custom-notification {
      background-color: @surface0;
      padding: 0.5rem 1rem;
      margin: 5px 0;
      border-radius: 1rem;
    }

    #cpu,
    #memory,
    #temperature {
      padding: 0.5rem 1rem;
      margin: 5px 0;
      min-width: 4em;
    }

    #cpu {
      color: @maroon;
    }

    #memory {
      color: @peach;
    }

    #temperature {
      color: @yellow;
    }

    #clock {
      color: @blue;
      margin-right: 1rem;
    }

    #pulseaudio {
      color: @maroon;
      margin-left: 1rem;
      margin-right: 1rem;
    }

    #custom-notification {
      color: @mauve;
      margin-left: 1rem;
      margin-right: 2rem;
    }

    #tray {
      margin-right: 1rem;
    }
    '';
  };
}