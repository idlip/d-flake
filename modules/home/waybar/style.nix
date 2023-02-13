let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in ''
* {
    color: #ffffff;
    border: 0;
    border-radius: 10px;
    padding: 0 0;
    font-family:ComicCodeLigatures Bold;
    font-size: 24px;
    margin-right: 5px;
    margin-left: 5px;
    padding-bottom:3px;
    min-height: 45px;
}

window#waybar {
    background: transparent;
    background: rgba(00, 00, 00, 0.2);
}

#workspaces button {
    border-radius: 20px;
    background-color: #11111b;
    color: #ffff00;

}

#workspaces button.active {
    border-color: #89DCEB ;
    padding-bottom:5px ;
}

#mode {
    color: #ebcb8b;
}

#mpd,#workspaces, #submap, #clock, #cpu, #memory,#network, #pulseaudio, #window,#custom-launcher,#custom-power{
    padding: 0 3px;
    border-bottom: 2px;
    border-style: solid;
    border-radius: 15px 15px 15px 15px;
  background-color: #11111b;
  margin-top: 3px;
  padding-top: 1px;
  padding-left: 13px;
  padding-right: 3px;
    opacity: 0.9;
}
 
#window {
    border-radius: 20px;
    padding-left: 10px;
    padding-right: 10px;
    color:#ffd700;
    margin-top:1px;
    border-color:#ffd700;
}

#clock {
 color:#00eeee;
}

#mpd {
  color: #cdd6f4;
}


#cpu {
  color:#a3be8c ;
}


#memory {
  color: #cba6f7;
}

#network.disabled {
    color:#bf616a;
}

#network{
    color:#ffe4b5;
}

#network.disconnected {
    color: #bf616a;
}

#pulseaudio {
  color: #c1ffc1;
}

#pulseaudio.muted {
    color: #3b4252;
}

#custom-launcher {
    font-family:Fira Code Nerd Font;
    font-size:32px;
    color:#00bfff;
    border-color: #00bfff;
    border-radius: 15px 15px 15px 15px;

}

#custom-power {
  font-family: Fira Code Nerd Font;
  font-size: 22px;
  color:#ff9999;
  border-radius: 30px 30px 30px 30px;

}

#submap {
  color:#eb9;
}
#mode{
    margin-bottom:3px;
}

''
