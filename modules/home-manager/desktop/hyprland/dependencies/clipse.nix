{...}: {
  services.clipse = {
    enable = true;

    historySize = 200;
    imageDisplay = {
       type = "kitty";
       scaleX = 9;
       scaleY = 9;
       heightCut = 2;
    };
  };
}
