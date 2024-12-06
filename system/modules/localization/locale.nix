{ config, pkgs, ... }: {
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "pt_BR.UTF-8";
  #   LC_IDENTIFICATION = "pt_BR.UTF-8";
  #   LC_MEASUREMENT = "pt_BR.UTF-8";
  #   LC_MONETARY = "pt_BR.UTF-8";
  #   LC_NAME = "pt_BR.UTF-8";
  #   LC_NUMERIC = "pt_BR.UTF-8";
  #   LC_PAPER = "pt_BR.UTF-8";
  #   LC_TELEPHONE = "pt_BR.UTF-8";
  #   LC_TIME = "pt_BR.UTF-8";
  # };
}
