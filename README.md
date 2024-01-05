# Epson LQ-350 CUPS drivers, at least sort of

This Nix flake builds two files:
- eplq350-rastertoepsidm24-secc0004.ppd 
- rastertoepsidm24-secc0004

from the sources that are fetched from Epson directly.
Both files are needed to use the dot-matrix-printer with all features with CUPS.

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
