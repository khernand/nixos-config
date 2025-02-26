{ ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    permitRootLogin = "no";
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
  };
}