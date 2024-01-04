{  
  mainBar = { 
    layer = "top"; 
    position = "top";
    mode = "overlay";
    height = 40;
    output = [ "eDP-1" "HDMI-A-1" ];
    modules-center = [ "clock" ];
    modules-right = [ "bluetooth" "network" "memory" "temperature" "battery" "tray" ];

    bluetooth = {
      format = " {status}";
      format-connected = " {device_alias}";
      format-connected-battery = " {device_alias} {device_battery_percentage}%";
      # format-device-preference = [ "device1", "device2" ]; # preference list deciding the displayed device
      tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
      on-double-click = "kitty bluetoothctl";
    };

    network = {
      interface = "wlp2s0";
      format = "{ifname}";
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} 󰊗";
      format-disconnected = ""; #An empty format will hide the module.
      tooltip-format = "{ifname} via {gwaddr} 󰊗";
      tooltip-format-wifi = "{essid} ({signalStrength}%) ";
      tooltip-format-ethernet = "{ifname} ";
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
      on-double-click = "kitty nmtui";
    };

    clock = {
      interval = 60;
      tooltip = "true";
      format = "{:%H:%M}";
      tooltip-format = "{:%d/%m/%Y}";
    };
 };

 bottomBar = { 
    layer = "top"; 
    position = "bottom";
    mode = "overlay";
    #mode = "overlay";
    height = 80;
    output = [ "eDP-1" "HDMI-A-1" ];
    modules-left = [ "image#karma-battery" ];

    "image#karma-battery" = {
      exec ="~/.dotfiles/home/modules/hyprland/waybar/custom-modules/karma-battery/karma-battery.sh";
      size = 80;
      interval = 30;  
    };
 };
}

