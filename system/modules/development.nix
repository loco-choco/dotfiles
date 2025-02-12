{ config, pkgs, ... }:
let
  dotnet = (with pkgs.dotnetCorePackages; combinePackages [ sdk_9_0 ]);

  nextpnr-src = pkgs.fetchFromGitHub {
    owner = "YosysHQ";
    repo = "nextpnr";
    rev = "e4115e85f734a6dc2d59654308eb2474375a7370";
    hash = "sha256-EsWFp5FjrAMky2zsyXH4Ba6UdqezLbWEZiFET6E1kJ4=";
    name = "nextpnr";
    fetchSubmodules = true;
  };

  yosys-updated = pkgs.yosys.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "YosysHQ";
      repo = "yosys";
      rev = "18a7c00382cd64d46b61ff6cafe80851ca29cb77";
      hash = "sha256-VhkYpaBcUtMhdiOoBpmKNqOFx657T+JCM0j5Y2RZxPc=";
      fetchSubmodules = true;
      leaveDotGit = true;
      postFetch = ''
        # set up git hashes as if we used the tarball

        pushd $out
        git rev-parse HEAD > .gitcommit
        cd $out/abc
        git rev-parse HEAD > .gitcommit
        popd

        # remove .git now that we are through with it
        find "$out" -name .git -print0 | xargs -0 rm -rf
      '';
    };
  };

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
    (nextpnr.overrideAttrs (old: {
      src = nextpnr-src;
      #patches = [ ];
      cmakeFlags = [
        "-DARCH=himbaechel;gowin"
        #"-DBUILD_TESTS=ON"
        "-DHIMBAECHEL_UARCH=gowin"
        "-DICESTORM_INSTALL_PREFIX=${icestorm}"
        "-DTRELLIS_INSTALL_PREFIX=${trellis}"
        "-DTRELLIS_LIBDIR=${trellis}/lib/trellis"
        "-DGOWIN_BBA_EXECUTABLE=${python3Packages.apycula}/bin/gowin_bba"
        "-DUSE_OPENMP=ON"
        # warning: high RAM usage
        "-DSERIALIZE_CHIPDBS=OFF"
        "-DHIMBAECHEL_GOWIN_DEVICES=all"
      ];
    }))
    python312Packages.apycula
    gtkwave # for visualizing tests output
    yosys-updated
    /* .withPlugins (with yosys-updated.allPlugins;
       [
         # for synthesis
         ghdl
       ]))
    */
    openfpgaloader
    netlistsvg # for visualizing rtl yosys files
    ngspice
    xyce
    #quartus-prime-lite
  ];

  environment.sessionVariables = { DOTNET_ROOT = "${dotnet}"; };
}
