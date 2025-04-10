{ config, pkgs, ... }:
let
  dotnet = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
    ]
  );

in
{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.extraGroups.docker.members = [ "locochoco" ];
  #services.ollama.enable = true;
  #services.open-webui.enable = true;
  programs.pulseview.enable = true;

  environment.systemPackages = with pkgs; [
    # C# development
    mono
    dotnet
    #jetbrains.rider

    # Game development
    godot_4

    # Arduino development
    arduino-cli

    # PIC development
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
    (yosys.withPlugins (
      with yosys.allPlugins;
      [
        # for synthesis
        ghdl
      ]
    ))
    openfpgaloader
    netlistsvg # for visualizing rtl yosys files
    ngspice
    xyce
    #quartus-prime-lite
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${dotnet}";
  };
}
