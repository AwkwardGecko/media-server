{ config, lib, pkgs, ... }:
{
  home-manager.users.brock.programs.yt-dlp = {
    enable = true;
    settings = {
      merge-output-format = "mkv";
      format = "bv*+ba/b";
      embed-metadata = true;
      embed-thumbnail = true;
      embed-subs = true;
      sub-langs = "en";
      sponsorblock-mark = "all";
    };
  };
}
