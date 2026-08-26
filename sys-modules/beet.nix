{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.beets ];

  environment.etc."beets/config.yaml".source =
    (pkgs.formats.yaml { }).generate "beets-config.yaml" {
      directory = "/media/music";
      library = "/var/lib/beets/library.db";
      statefile = "/var/lib/beets/state.pickle";

      import = {
        move = true;          # relocate in-place into the tree below
        write = true;         # write matched tags back to the files
        quiet = true;         # never prompt; skip anything ambiguous
        quiet_fallback = "asis";        # import using existing tags instead of skipping
        incremental = true;   # remember already-processed dirs
        incremental_skip_later = true;  # retry skipped dirs on the next run
        singletons = false;
        log = "/var/lib/beets/import.log";
      };

      musicbrainz.enabled = true;

      paths = {
        default = "$albumartist/$album/$track $title";
        comp = "Various Artists/$album/$track $title";
        singleton = "$artist/Non-Album/$title";
      };
    };

  systemd.services.beets-import = {
    description = "Tag and sort /media/music with beets";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    environment.BEETSDIR = "/etc/beets";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.beets}/bin/beet import --quiet /media/music";
      StateDirectory = "beets";
      TimeoutStartSec = "infinity";
      Nice = 10;
      IOSchedulingClass = "idle";
    };
  };

  systemd.timers.beets-import = {
    description = "Run beets import every 3 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 00/3:00:00";
      Persistent = true;
      RandomizedDelaySec = "5m";
    };
  };
}
