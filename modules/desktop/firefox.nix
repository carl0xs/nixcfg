{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";

    profiles.default = {
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };

      isDefault = true;
      extensions.force = true;
      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          dearrow
          vimium
          bitwarden
        ];
    };

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      DisableTelemetry = true;

      # Access Restrictions
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = true;
    };
  };
}
