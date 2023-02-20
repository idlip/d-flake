{
  config,
  pkgs,
  ...
}:
# this should block *most* junk sites
# make sure to ALWAYS lock commit hash
{
  networking.extraHosts =
    builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
      sha256 = "2BqbU4G5VWLerdIc8C9Nkny6zZ68PqZ9oyL1VwdlREQ=";
      # blocks fakenews, gambling and coomer sites
    })
    + builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/shreyasminocha/shady-hosts/main/hosts";
      sha256 = "QrHTVcqfeoRi+hWWxkZZQTPNiFFF+7kiTI7jfvMU9h8=";
      # blocks some shady fed sites
    })
    + builtins.readFile (pkgs.fetchurl {
      # blocks crypto phishing scams
      url = "https://raw.githubusercontent.com/MetaMask/eth-phishing-detect/master/src/hosts.txt";
      sha256 = "b3HvaLxnUJZOANUL/p+XPNvu9Aod9YLHYYtCZT5Lan0=";
    })
    + builtins.readFile (pkgs.fetchurl {
      # generic ads
      url = "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt";
      sha256 = "mp0ka7T0H53rJ3f7yAep3ExXmY6ftpHpAcwWrRWzWYI=";
    });
}
