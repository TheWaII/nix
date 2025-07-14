# OLD CONFIGURATION
# Now running on RAID 10. 
# Too lazy to change lul (will do when the time comes)
{
  disko.devices = {
    disk = {
      a = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zstorage";
            };
          };
        };
      };
      b = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zstorage";
            };
          };
        };
      };
      c = {
        type = "disk";
        device = "/dev/sdc";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zmedia";
            };
          };
        };
      };
      d = {
        type = "disk";
        device = "/dev/sdd";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zmedia";
            };
          };
        };
      };
    };

    zpool = {
      zstorage = {
        type = "zpool";
        mode = "mirror";
        mountpoint = "/storage";
        rootFsOptions = { compression = "zstd"; };
      };

      zmedia = {
        type = "zpool";
        mode = ""; # stripped
        mountpoint = "/media";
        rootFsOptions = { compression = "zstd"; };
      };
    };
  };
}
