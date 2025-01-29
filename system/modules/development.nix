{ config, pkgs, ... }:
let dotnet = (with pkgs.dotnetCorePackages; combinePackages [ sdk_9_0 ]);
in {
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.locochoco.extraGroups = [ "docker" ];

  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  environment.systemPackages = with pkgs; [
    # C# development
    mono
    dotnet
    #jetbrains.rider

    # Game development
    godot_4

    # VR development
    #monado
    #(pkgs.monado.overrideAttrs {
    #  src = fetchFromGitLab {
    #    domain = "gitlab.freedesktop.org";
    #    owner = "monado";
    #    repo = "monado";
    #    rev = "5cea2bea2f76fa3b44ec5fab771ed1490d937c76";
    #    sha256 = "sha256-opx8zkQTRqCGhHAPZUgdhg7s+wqZEeh+c3K33FrYXrk=";
    #  };
    #  patches = [];
    #})
    #monado
    #opencomposite
    #opencomposite-helper
    #openxr-loader
    # Arduino development
    arduino-cli

    # PIC development
    #(pkgs.sdcc.override { withGputils = true;})
    #gputils

    # Rust development
    rustc
    cargo

    # Nix development
    nix-prefetch-github

    #Verilog + SystemVerilog Dev
    verilator
    iverilog
    # VHDL development
    ghdl # for vhdl
    nextpnr
    python312Packages.apycula
    gtkwave # for visualizing tests output
    (yosys.withPlugins (with yosys.allPlugins;
      [
        # for synthesis
        ghdl
      ]))
    netlistsvg # for visualizing rtl yosys files
    ngspice
    xyce
    (sdcc.override { withGputils = true; })
    gputils
    #quartus-prime-lite
  ];

  environment.sessionVariables = { DOTNET_ROOT = "${dotnet}"; };

  services.udev.extraRules = ''
    #ESP32
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="00??", GROUP="plugdev", MODE="0666"
    ACTION!="add|change", GOTO="openfpgaloader_rules_end"

    # gpiochip subsystem
    SUBSYSTEM=="gpio", MODE="0664", GROUP="plugdev", TAG+="uaccess"

    SUBSYSTEM!="usb|tty|hidraw", GOTO="openfpgaloader_rules_end"

    # Original FT232/FT245 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Original FT2232 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Original FT4232 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Original FT232H VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Original FT231X VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # anlogic cable
    ATTRS{idVendor}=="0547", ATTRS{idProduct}=="1002", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # altera usb-blaster
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="664", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="664", GROUP="plugdev", TAG+="uaccess"
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # altera usb-blasterII - uninitialized
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="664", GROUP="plugdev", TAG+="uaccess"
    # altera usb-blasterII - initialized
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # dirtyJTAG
    ATTRS{idVendor}=="1209", ATTRS{idProduct}=="c0ca", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Jlink
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # NXP LPC-Link2
    ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="0090", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # NXP ARM mbed
    ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # icebreaker bitsy
    ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="6146", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # numato systems
    ATTRS{idVendor}=="2a19", ATTRS{idProduct}=="1009", MODE="644", GROUP="plugdev", TAG+="uaccess"

    # orbtrace-mini dfu
    ATTRS{idVendor}=="1209", ATTRS{idProduct}=="3442", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # QinHeng Electronics USB To UART+JTAG (ch347)
    ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="55dd", MODE="664", GROUP="plugdev", TAG+="uaccess"

    LABEL="openfpgaloader_rules_end"

  '';
}
