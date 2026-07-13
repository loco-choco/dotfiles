{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.hardware.keyboard;
in
{
  options = {
    hardware.keyboard = {
      br-abnt2.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables ABNT2 keyboard 
        '';
      };
      us-int.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables us-int keyboard 
        '';
      };
    };
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = !(config.hardware.keyboard.us-int.enable && config.hardware.keyboard.br-abnt2.enable);
          message = ''
            Multiple keyboards can't be enabled at the same time.
          '';
        }
      ];
    }
    (mkIf cfg.us-int.enable {
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    })
    (mkIf cfg.br-abnt2.enable {
      services.xserver.xkb = {
        layout = "br";
        variant = "";
      };
    })
  ];
}
