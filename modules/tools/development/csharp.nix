{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.csharp;
  dotnet = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
      sdk_9_0
    ]
  );
in
{
  options = {
    tools.development.csharp = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables CSharp's development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mono
      dotnet
    ];
    environment.sessionVariables = {
      DOTNET_ROOT = "${dotnet}";
    };

    programs.nixvim.plugins.lsp.servers.csharp_ls.enable = true;
  };
}
