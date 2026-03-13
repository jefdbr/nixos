{...}: {
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "be-latin1";

  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };
}
