{
  description = "Quakespasm-Spiked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      defaultSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      perSystem =
        {
          lib ? nixpkgs.lib,
          systems ? defaultSystems,
          initOutputs ? { },
        }:
        genSystem:
        let
          groupedOutputs = lib.attrsets.genAttrs systems (system: genSystem { inherit system; });
          mergeSystems =
            outputs: system:
            let
              systemOutputs = groupedOutputs.${system};
              systemOutputNames = builtins.attrNames systemOutputs;
              mergeOutputs =
                outputs: outputName:
                let
                  prevValues = outputs.${outputName} or { };
                  systemValues = {
                    ${system} = systemOutputs.${outputName};
                  };
                in
                outputs // { ${outputName} = prevValues // systemValues; };
            in
            (builtins.foldl' mergeOutputs outputs systemOutputNames);
        in
        (builtins.foldl' mergeSystems initOutputs systems);
    in
    perSystem { } (
      { system, ... }:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        formatter = pkgs.nixfmt;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.just

            pkgs.meson
            pkgs.ninja
            pkgs.cmake
            # For: libmad
            pkgs.autoconf
            pkgs.automake
            pkgs.libtool
          ];
        };
      }
    );
}
