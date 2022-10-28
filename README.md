## Xen Guest Tools for Talos

This repo contains the necessary files for building `xenstore` and `xe-daemon` as a system extension for Talos OS.

Currently it is using a fork of mine instead of the upstream xcp-ng/xe-guest-utilities as they hardcode a path on `/var/cache` and i was having issues allowing the system extension to write on it.

This is still a work in progress, with just the most basic features working. Since Talos does not ships with binaries like `ip/ifconfig` and `df` currently the daemon is not properly reporting disk or network information.

