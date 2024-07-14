{ config, pkgs, ... }:
{
  hardware.rtl-sdr.enable = true;
  environment.systemPackages = with pkgs; [
    gqrx
    (gnuradio3_8.override {
      extraPackages = with gnuradio3_8Packages; [
        osmosdr # to enable using the rtl-sdr as a sink
      ];
    })
  ];
}
