

{ pkgs, config, self, lib, ... }:

{
  programs = {
    btop = {
      enable = true;
    settings = {
      color_theme = "Default";
      theme_background = "False";
      vim_keys = "True";
      shown_boxes = "proc cpu";
      rounded_corners = "True";
      graph_symbol = "block";
      proc_sorting = "memory";
      proc_reversed = "False";
      proc_gradient = "True";
    };
  };
 };
}
