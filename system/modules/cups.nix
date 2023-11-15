{ config, pkgs, ... }: {
  services.printing.enable = true;
  services.printing.cups-pdf = {
    enable = true;
    instances.pdf = {
      settings = {
        Out = "\${HOME}/cups-pdf";
	UserUMask = "0033";
      };
    };
  };
}
