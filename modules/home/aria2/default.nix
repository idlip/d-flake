

{ pkgs, config, self, lib, ... }:

{
  programs = {
    aria2 = {
      enable = true;
    settings = {
	dir = "/home/i/dloads";
	file-allocation = "none";
	log-level = "warn";
	split = "10";
	max-connection-per-server = 6;
	min-split-size = "5M";
	on-download-complete = "exit";
      };
    };
  };
}
