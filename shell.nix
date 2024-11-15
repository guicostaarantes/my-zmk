{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  packages = [
    cmake ninja dtc
    (python311.withPackages (ps: [
      ps.west
      ps.pyelftools
      ps.pyyaml
      ps.pykwalify
      ps.canopen
      ps.packaging
      ps.progress
      ps.psutil
      ps.pylink-square
      ps.pyserial
      ps.requests
      ps.anytree
      ps.intelhex
    ]))
    gcc-arm-embedded
  ];

  env = {
    ZEPHYR_TOOLCHAIN_VARIANT = "gnuarmemb";
    GNUARMEMB_TOOLCHAIN_PATH = gcc-arm-embedded;
  };
}
