{ config, pkgs, ... }:
{
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  environment.systemPackages = with pkgs; [
    # C# development
    mono
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_6_0
        sdk_7_0
        sdk_8_0
      ]
    )
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
    monado
    opencomposite
    opencomposite-helper
    openxr-loader
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

    # VHDL development
    ghdl # for vhdl
    gtkwave # for visualizing tests output
    (yosys.withPlugins (
      with yosys.allPlugins;
      [
        # for synthesis
        ghdl
      ]
    ))
    netlistsvg # for visualizing rtl yosys files
    #quartus-prime-lite
  ];

  services.udev.extraRules = ''
        #ESP32
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="00??", GROUP="plugdev", MODE="0666"

    # Do not edit this file - generated by make-udev-rules.py
    #
    # Copyright 2019-2022, Collabora, Ltd. and the xr-hardware contributors
    #
    # SPDX-License-Identifier: BSL-1.0

    # 70-xrhardware.rules

    # Must be located at a number smaller than 73 for uaccess to work right!

    # Skip if a remove
    ACTION=="remove", GOTO="xrhardware_end"


    # BEGIN DEVICE LIST #
    #####################
    # Razer Hydra - USB
    ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0300", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # HTC Vive - USB
    ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="2c87", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # HTC Vive Pro - USB
    ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0309", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Valve Watchman Dongle - USB
    ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2101", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Valve VR Radio - USB
    ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2102", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Valve Index Controller - USB
    ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2300", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Valve Receiver for Lighthouse - HTC Vive - USB
    ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2000", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # OSVR HDK - USB
    ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0b00", TAG+="uaccess", ENV{ID_xrhardware}="1", ENV{ID_xrhardware_USBSERIAL_NAME}="OSVRHDK"


    # OSVR HDK Camera - USB
    ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="57e8", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sensics zSight - USB
    ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0515", TAG+="uaccess", ENV{ID_xrhardware}="1", ENV{ID_xrhardware_USBSERIAL_NAME}="zSight"


    # NOLO CV1 - USB
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5750", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # NOLO CV1 - USB
    ATTRS{idVendor}=="28e9", ATTRS{idProduct}=="028a", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # NOLO CV1 PRO - USB
    ATTRS{idVendor}=="28e9", ATTRS{idProduct}=="0302", ATTRS{product}=="CV1_PRO_HEAD", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Pimax 4k - USB
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="0021", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (DK1) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0001", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (DK2) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0021", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (DK2) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="2021", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (DK2 Sensor) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0201", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (CV1) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0031", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift (CV1 Sensor) - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0211", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Oculus Rift S - USB
    ATTRS{idVendor}=="2833", ATTRS{idProduct}=="0051", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Samsung GearVR (Gen1) - USB
    ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="a500", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-D3V1 - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0200", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-D3V2 - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0201", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-D3C - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0202", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-D2C - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0203", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-S1V5 - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0100", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # 3Glasses-S1V8 - USB
    ATTRS{idVendor}=="2b1c", ATTRS{idProduct}=="0101", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sony PlayStation VR - USB
    ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09af", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sony PlayStation Move Motion Controller CECH-ZCM1 - Bluetooth, USB
    ATTRS{idVendor}=="054c", ATTRS{idProduct}=="03d5", TAG+="uaccess", ENV{ID_xrhardware}="1"
    KERNELS=="0005:054C:03D5.*", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sony PlayStation Move Motion Controller CECH-ZCM2 - Bluetooth, USB
    ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0c5e", TAG+="uaccess", ENV{ID_xrhardware}="1"
    KERNELS=="0005:054C:0C5E.*", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sony PlayStation VR2 - USB
    ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0cde", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Sony PlayStation VR2 Sensor Controller - Bluetooth, USB
    ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0e46", TAG+="uaccess", ENV{ID_xrhardware}="1"
    KERNELS=="0005:054C:0E46.*", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # LG 360 VR R-100 - USB
    ATTRS{idVendor}=="1004", ATTRS{idProduct}=="6374", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Microsoft Windows MR Controller - Bluetooth
    KERNELS=="0005:045E:065B.*", TAG+="uaccess", ENV{ID_xrhardware}="1", ENV{LIBINPUT_IGNORE_DEVICE}="1"


    # Microsoft Windows MR Controller - Bluetooth
    KERNELS=="0005:045E:065D.*", TAG+="uaccess", ENV{ID_xrhardware}="1", ENV{LIBINPUT_IGNORE_DEVICE}="1"


    # Microsoft Windows MR Controller (Reverb G2) - Bluetooth
    KERNELS=="0005:045E:066A.*", TAG+="uaccess", ENV{ID_xrhardware}="1", ENV{LIBINPUT_IGNORE_DEVICE}="1"


    # Microsoft HoloLens Sensors - USB
    ATTRS{idVendor}=="045e", ATTRS{idProduct}=="0659", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Samsung Odyssey+ sensors - USB
    ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="7312", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # HP VR1000 - USB
    ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="0367", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # HP Reverb G1 - USB
    ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="0c6a", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # HP Reverb G2 - USB
    ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="0580", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Lenovo QHMD - USB
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="b801", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Cypress Semiconductor Corp. Lenovo Explorer - USB
    ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="6504", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Acer AH100 QHMD - USB
    ATTRS{idVendor}=="0502", ATTRS{idProduct}=="b0d6", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Medion Erazer X1000 - USB
    ATTRS{idVendor}=="0408", ATTRS{idProduct}=="b5d5", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Vis3r NxtVR - USB
    ATTRS{idVendor}=="1209", ATTRS{idProduct}=="9d0f", TAG+="uaccess", ENV{ID_xrhardware}="1"


    # Nreal Air - USB
    ATTRS{idVendor}=="3318", ATTRS{idProduct}=="0424", TAG+="uaccess", ENV{ID_xrhardware}="1"

    ###################
    # END DEVICE LIST #


    # Exit if we didn't find one
    ENV{ID_xrhardware}!="1", GOTO="xrhardware_end"

    # XR devices with serial ports aren't modems, modem-manager
    ENV{ID_xrhardware_USBSERIAL_NAME}!="", SUBSYSTEM=="usb", ENV{ID_MM_DEVICE_IGNORE}="1"

    # Make friendly symlinks for XR USB-Serial devices.
    ENV{ID_xrhardware_USBSERIAL_NAME}!="", SUBSYSTEM=="tty", SYMLINK+="ttyUSB.$env{ID_xrhardware_USBSERIAL_NAME}"

    LABEL="xrhardware_end"
  '';
}
