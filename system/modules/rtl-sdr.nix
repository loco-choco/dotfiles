{ config, pkgs, ... }: {
  hardware.rtl-sdr.enable = true;
  enviroment.systemPackages = with pkgs; [
    gqrx
    (gnuradio3_8.override {
      extraPackages = with gnuratio3_8Packages; [
        osmodr #to enable using the rtl-sdr as a sink
      ];
    })
  ];
}
