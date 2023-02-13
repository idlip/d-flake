{
  config,
  pkgs,
  lib,
  ...
}: {
#   programs.newsboat = {
#     enable = true;
#     autoReload = true;
#     urls = [
#       # https://hackaday.com/blog/feed/
#       {
#         title = "Wiadomosci blisko ciebie";
#         tags = ["news" "twitter"];
#         url = "https://nitter.net/WBC24News/rss";
#       }
#       {
#         title = "LukaszBok";
#         tags = ["news" "twitter"];
#         url = "https://nitter.net/LukaszBok/rss";
#       }
#       {
#         title = "KIKS";
#         tags = ["news" "twitter"];
#         url = "https://weekly.nixos.org/feeds/all.rss.xml";
#       }
#     ];
#     extraConfig = ''
# #show-read-feeds no
# #auto-reload yes

# reload-time 120
# always-display-description true
# reload-threads 40



# bind-key j down
# bind-key k up
# bind-key j next articlelist
# bind-key k prev articlelist
# bind-key J next-feed articlelist
# bind-key K prev-feed articlelist
# bind-key G end
# bind-key g home
# bind-key d pagedown
# bind-key u pageup
# bind-key l open
# bind-key h quit
# bind-key a toggle-article-read
# bind-key n next
# bind-key p prev
# bind-key D pb-download
# bind-key U show-urls
# bind-key x pb-delete

# color listnormal cyan default
# color listfocus black yellow standout bold
# color listnormal_unread blue default
# color listfocus_unread yellow default bold
# color info red black bold
# color article white default bold

# browser "d-stuff"

# #bind-key \ macro-prefix
# macro , open-in-browser ; set browser d-stuff
# macro d set browser "d-stuff" ; open-in-browser ; set browser linkhandler
# macro c set browser "echo %u | xclip -r -sel c" ; open-in-browser ; set browser linkhandler
# macro o set browser "d-stuff" ; open-in-browser ;
# macro m pipe-to "grep -o 'http.*mp3' | xargs tsp mpv " ; toggle-article-read "read"

# macro v set browser "tsp mpv %u"; open-in-browser ;set browser linkhandler

# macro t pipe-to "grep -o 'http.*torrent' | xclip -selection clipboard"; 

# highlight all "---.*---" yellow
# highlight feedlist ".*(0/0))" black
# highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
# highlight article "(^Link:.*|^Date:.*)" default default
# highlight article "https?://[^ ]+" green default
# highlight article "^(Title):.*$" blue default
# highlight article "\\[[0-9][0-9]*\\]" magenta default bold
# highlight article "\\[image\\ [0-9]+\\]" green default bold
# highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
# highlight article ":.*\\(link\\)$" cyan default
# highlight article ":.*\\(image\\)$" blue default
# highlight article ":.*\\(embedded flash\\)$" magenta default

#       user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
#     '';
#   };


  home.packages = [pkgs.newsboat];
  # xdg.configFile."newsboat".source = ./configs/.;
  
  home.file.".config/newsboat".recursive = true;
  home.file.".config/newsboat".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/newsboat/.configs";


}
