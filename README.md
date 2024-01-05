# Epson LQ-350 CUPS drivers, at least sort of

This Nix flake builds two files:
- eplq350-rastertoepsidm24-secc0004.ppd 
- rastertoepsidm24-secc0004

from the sources that are fetched from Epson directly.
Both files are needed to use the dot-matrix-printer with all features with CUPS.

## Building it

    nix build

Should be enough to get them for your architecture or those that are set in your [binfmt module](https://github.com/NixOS/nixpkgs/blob/f82e9b88c983b5fad78b35ec57985e9609c416b0/nixos/modules/system/boot/binfmt.nix).

If you want to compile for a certain architecture pass it as argument to nix build like so:

    nix build --system armv7l-linux

## Using it

Have a look in the `result` directory.
The PPD can be selected in the CUPS webinterface and the compiled filter needs to be copied in your directory where all the other filters live.

## Story time
I came across a request to attach the given Epson dot-matrix-printer to a Raspberry Pi that should share the printer with Windows machines in the local network.

CUPS itself got a nice Epson 24-Pin driver that got useable prints.
But with a minor caveat: It always wanted to print a full page, no matter how many actual lines were printed.
If a shorter paper was put in it insisted in printing a full page of the default paper size (DINA4).
The Windows driver did finish the print job after the paper was retracted and was happy.

Searching around for a driver Epson offered some older RPMs and DEBs for x86 and x86_64.
Given the nature of the Raspberry Pi those would not install.
Extracting the PPD file from the archives it claimed that a particular filter was missing.
The filter is a binary that is compiled for the certain architecture.
Praise Epson for providing the source files to compile the driver ourselves.

## Disclaimer
As this flake does nothing more than downloading the official sources and compiles them there should be no license violated.
At the time of writing the files were shipped with a GPL-2.0 license.
