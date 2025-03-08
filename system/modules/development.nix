{ config, pkgs, ... }:
let
  dotnet = (with pkgs.dotnetCorePackages; combinePackages [ sdk_8_0 sdk_9_0 ]);

in {

  services.ollama.enable = true;
  services.open-webui.enable = true;

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
    openfpgaloader
    netlistsvg # for visualizing rtl yosys files
    ngspice
    xyce
    #quartus-prime-lite
  ];

  environment.sessionVariables = { DOTNET_ROOT = "${dotnet}"; };
}
