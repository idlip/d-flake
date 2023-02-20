{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      material-icons
      material-design-icons
      noto-fonts-emoji
      weather-icons
      font-awesome
      symbola
    ];

    enableDefaultFonts = false;

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = [
          "ComicCodeLigatures"
          "Fira Code Nerd Font"
          "JetBrains Mono Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Fira Code Nerd Font" "ComicCodeLigatures" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji" "all-the-icons" "FontAwesome" "Material Icons" "symbola" "Material Design Icons" ];
      };
    };
  };
}
