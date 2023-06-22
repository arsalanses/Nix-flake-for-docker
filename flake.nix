{
  description = "A !very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      
      busyboxFromDockerHub = pkgs.dockerTools.pullImage {
        imageName = "busybox";
        imageDigest = "sha256:1b0a26bd07a3d17473d8d8468bea84015e27f87124b283b91d781bce13f61370";
        sha256 = "sha256-uSmgXdnRe4xITBv8u5cx0bFpUzzxvN95YfbzUqZXtLI=";
        finalImageTag = "1.36.1";
        finalImageName = "busybox";
        os = "linux";
        arch = "x86_64";
      };

      csource = pkgs.stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "gcc -o hello ./hello.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      };

      dockerImage = pkgs.dockerTools.buildImage {
        name = "mycurl";
        tag = "0.1.0";
        fromImage = busyboxFromDockerHub;
        copyToRoot = pkgs.buildEnv {
          name = "image-root";
          pathsToLink = [ "/bin" ];
          paths = [
            csource 
            pkgs.nano
          ];
        };
        config = {
          Cmd = [ "/bin/sh" ];
          Env = [];
          Volumes = {};
        };
        created = "now";
      };

    in {

      packages = {
        cPackage = csource;
        docker = dockerImage;
      };
        
      defaultPackage = dockerImage;
      # packages.x86_64-linux.default = dockerImage;

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          bat
          vim
        ];
      };

    });
}
