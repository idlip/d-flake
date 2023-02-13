{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      material-icons
      material-design-icons
      comic-neue
      twemoji-color-font
      noto-fonts-emoji
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
        emoji = ["Noto Color Emoji" "tewmoji-color-font" "material-icons"];
      };
    };
  };
}
