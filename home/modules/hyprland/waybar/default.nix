let
  topBarHeight = 40;
  bottomBarHeight = 40;
in
{  
  mainBar = {
    name = "mainBar";
    layer = "top"; 
    position = "top";
    #mode = "overlay";
    exclusive = false;
    passthrough = false;
    spacing = 10;
    height = topBarHeight;
    output = [ "eDP-1" "HDMI-A-1" "DP-2" ];
    modules-center = [ "memory" "clock" "temperature" ];
    modules-left = [ "tray" ];
    modules-right = [ "bluetooth" "network" ];

    clock = {  
      interval = 60;
      tooltip = true;
      format = "{:%H:%M}";
      tooltip-format = "{:%d/%m/%Y}";
    };

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
    
    memory = {
      interval = 30;
      format = "{percentage}% ";
      tooltip-format = "{used:0.1f}GiB used\n{swapUsed:0.1f}GiB swap";
    };

    temperature = {
      format = "{temperatureC}°C 󱃃";
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
    };
  };

# bottomBar = { 
#    name = "bottomBar";
#    layer = "top"; 
#    position = "bottom";
#    #mode = "dock";
#    exclusive = false;
#    passthrough = false;
#    spacing = 10;
#    height = bottomBarHeight;
#    output = [ "eDP-1" "HDMI-A-1" ];
#    modules-right = [ "bluetooth" "network" ];
#
# };
 
 karmaBar = { 
    name = "karmaBar";
    layer = "top"; 
    position = "bottom";
    #mode = "dock";
    exclusive = false;
    passthrough = false;
    margin-left = bottomBarHeight;
    margin-bottom = bottomBarHeight;
    output = [ "eDP-1" "HDMI-A-1" ];
    modules-left = [ "image#karma-battery" ];
    "image#karma-battery" = {
      exec ="sh /home/locochoco/.dotfiles/home/modules/hyprland/waybar/custom-modules/karma-battery/karma-battery.sh";
      size = 90;
      interval = 30; 
    };
 };
}

