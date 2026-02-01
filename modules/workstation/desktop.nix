{ config, pkgs, extraHostsFromEnv, ... }:

{

  # X Server
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  networking.extraHosts = extraHostsFromEnv;

	fonts = {
		enableDefaultPackages = true;

		packages = with pkgs; [
			nerd-fonts.fira-code
		];
	};

  nix.settings.trusted-users = [ "root" "carlos" ];

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Compositor
  services.picom = {
    enable = true;
  };

  users.defaultUserShell = pkgs.fish;

  # GUI Programs
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.3"
  ];

  # Packages for a graphical environment are managed by Home Manager.
}
