_:

{
  xdg.configFile."istherenet/config.json".text = builtins.toJSON {
    sounds = {
      disconnected = "Mezzo";
      slow = "Submerge";
      volume = 0.4;
      connected = "Funky";
    };
    pingIntervalSeconds = 5;
    pingIP = "1.1.1.1";
    pingSlowThresholdMilliseconds = 300;
    fadeSeconds = {
      connected = 5;
      disconnected = 0;
      slow = 10;
    };
    colors = {
      slow = "systemYellow";
      connected = "systemGreen";
      disconnected = "systemRed";
    };
    pingTimeoutSeconds = 1;
    screen = "all";
    launchAtLogin = true;
  };
}
