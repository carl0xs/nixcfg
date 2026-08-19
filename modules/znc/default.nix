{ pkgs, config, ... }:
{
  services.znc = {
    enable = true;
    mutable = false;
    useLegacyConfig = false;
    openFirewall = true;

    configFile = pkgs.writeText "znc.conf" ''
            Version = 1.0

            LoadModule = webadmin 
            LoadModule = adminlog

            <Listener l>
              Port = 5000
              SSL = true
            </Listener>

            <User carl0xs>
              Admin = true
              Nick = carl0xs
              AltNick = carl0xs_
              Ident = carl0xs
              RealName = carl0xs

              <Pass password>
                Method = SHA256
                Hash = ${config.sops.secrets.znc.hash}
                Salt = ${config.sops.secrets.znc.salt}
              </Pass>

              LoadModule = chansaver
              LoadModule = controlpanel
      	<Network libera>
      	  LoadModule = sasl
      	</Network>
            </User>
    '';
  };
}
