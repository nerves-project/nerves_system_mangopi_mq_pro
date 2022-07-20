# Changelog

This project does NOT follow semantic versioning. The version increases as
follows:

1. Major version updates are breaking updates to the build infrastructure.
   These should be very rare.
2. Minor version updates are made for every major Buildroot release. This
   may also include Erlang/OTP and Linux kernel updates. These are made four
   times a year shortly after the Buildroot releases.
3. Patch version updates are made for Buildroot minor releases, Erlang/OTP
   releases, and Linux kernel updates. They're also made to fix bugs and add
   features to the build infrastructure.

## v0.2.1

This release has several updates, but mostly makes it possible to use SPI now.

* Updates
  * Linux 5.19-rc0 (smauel's wip-d1 Linux branch)
  * SPI1 works now through the GPIO header
  * Clean up DTB handling. The U-Boot device tree is the only one that's used so
    all patching and building of the Linux one has been removed. Also U-Boot is
    updated on firmware updates. This isn't good, but it's easier than reburning
    the MicroSD card every time.

## v0.2.0

This release updates the Linux kernel to 5.18 in the hopes of fixing some Linux
kernel flakiness.

U-Boot has changed enough that I don't believe that a v0.1.1 image is
upgradable. Please rewrite your MicroSD image.

* Updates
  * Linux 5.18-rc4 (smauel's wip-d1 Linux branch)
  * Switch to the Nezha device tree since upstream updates have fixed the
    warnings that caused me to create a custom dts.
  * Enable earlycon for earlier logging from Linux

## v0.1.1

The release fixes some issues that made v0.1.0 hard to use. The flaky MMC boot
issue is still present. If your board hits it, unplugging and replugging in the
MicroSD card has been found to be a more reliable workaround than rebooting.

* Updates
  * Enable the RISC-V vector extension

* Fixes
  * Fix compilation warnings when using C standard headers. If a library had
    `-Werror`, these would end up breaking Elixir libraries that had C/C++ code.
  * Make sure that the watchdog is active during boot and can't be disabled.
    This recovers (with a reboot) from some more hangs.

## v0.1.0

This is the initial release.
