{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  outputs = {
    nixpkgs,
    ...
  }: let
    allSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    forEachSystem = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
          };
        });
  in {
    devShells = forEachSystem ({
      pkgs,
      system,
    }: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          cmake
          ninja
          dtc
          gcc-arm-embedded
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
        ];
        env = {
          ZEPHYR_TOOLCHAIN_VARIANT = "gnuarmemb";
          GNUARMEMB_TOOLCHAIN_PATH = pkgs.gcc-arm-embedded;
        };
      };
    });
  };
}
