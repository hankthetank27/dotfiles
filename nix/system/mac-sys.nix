{ self, pkgs, user, system, fenix, ... }: 

{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = {
      inherit system;
    };

    overlays = [ fenix.overlays.default ];

    config = {
      allowUnfree = true;
      # cudaSupport = true;
      # cudaCapabilities = ["8.0"];
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  # this should be set in kitty. not working atm
  environment.variables = {
    # SHELL = "${pkgs.bashInteractive}/bin/bash";
    EDITOR = "vim";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
    # rust toolchain
    # we might be to do this in shared. Need to test on linux.
    (fenix.packages.${system}.stable.withComponents [
    # nightly -- (fenix.packages.${system}.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
  ] ++ import ./shared/packages.nix { inherit pkgs fenix system; };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
