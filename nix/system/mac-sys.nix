{ self, pkgs, user, system, ... }: 

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

    config = {
      allowUnfree = true;
      #cudaSupport = true;
      #cudaCapabilities = ["8.0"];
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ] ++ import ./shared/packages.nix { inherit pkgs; };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

}
