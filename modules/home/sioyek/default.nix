{
  config,
  pkgs,
  ...
}: {

  programs.sioyek = {
    enable = true;

    config = {
      
	"background_color" =  "0.0 0.0 0.0";
	"dark_mode_background_color"  =  "0.0 0.0 0.0";
	"custom_background_color" =  "0.180 0.204 0.251";
	"custom_text_color" =  "0.847 0.871 0.914";
	
	"dark_mode_contrast" =			"0.8";
	"text_highlight_color" =     "1.0 1.0 0.0";
	"search_url_s" = 	"https://scholar.google.com/scholar?q=";
	"search_url_l" = 	"http://gen.lib.rus.ec/scimag/?q=";
	"search_url_g" =	"https://www.google.com/search?q=";
	"middle_click_search_engine" = "s";
	"shift_middle_click_search_engine" = 	"l";
	"zoom_inc_factor" =         "1.2";
	"flat_toc" =                            "0";
	"should_launch_new_instance"		=		"1";
	
	"should_launch_new_window"		=		"1";
	
	"default_dark_mode" =	"1";
	"sort_bookmarks_by_location" = 	"1";
	"ui_font" = "ComicCodeLigatures";
	"font_size" =  "24";
	"wheel_zoom_on_cursor" =  "1";
	"status_bar_font_size" = "22";
	"collapsed_toc" = "1";
	"ruler_mode" = "1";
	
	"single_click_selects_words" =  "1";
	
	
	"item_list_prefix" =  ">";
	
	"#ignore_whitespace_in_presentation_mode" = "0";
	
	"prerender_next_page_presentation" = "1";
	
    };

    bindings = {
      "fit_to_page_width" =  "<f9>";
      "fit_to_page_width_smart" =  "<f10>";

       " quit"	= "q";
        "toggle_custom_color"  =   "<f8>";
        "toggle_fullscreen" =   "<f11>";
        "toggle_highlight" =   "<f1>";
        "command" =             "<A-x>";
        "toggle_dark_mode" =	"i";
        "toggle_presentation_mode" =	"<f5>";
        "toggle_statusbar" = "<S-b>";
    };
  };

}
