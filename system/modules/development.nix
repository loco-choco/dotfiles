{ config, pkgs, ... }: {
  services.udev.extraRules = ''
    #ESP32
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="00??", GROUP="plugdev", MODE="0666"
  '';

  enviroment.systemPackages = with pkgs; [
    # C# development
    mono
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
    ])
    jetbrains.rider

    # Game development
    godot_4

    # Arduino development
    arduino-cli

    # Rust development
    rustc
    cargo

    # Nix development
    nix-prefetch-github

    # VHDL development
    ghdl # for vhdl
    gtkwave # for visualizing tests output
    (with yosys.allPlugins; [ # for synthesis
      ghdl
    ])
    netlistsvg # for visualizing rtl yosys files
    #quartus-prime-lite
  ];
}
