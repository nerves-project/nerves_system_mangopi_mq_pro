# MangoPi MQ Pro Support

*This is a work in progress.*

[![CircleCI](https://circleci.com/gh/fhunleth/nerves_system_mangopi_mq_pro.svg?style=svg)](https://circleci.com/gh/fhunleth/nerves_system_mangopi_mq_pro)
[![Hex version](https://img.shields.io/hexpm/v/nerves_system_mangopi_mq_pro.svg "Hex version")](https://hex.pm/packages/nerves_system_mangopi_mq_pro)

This is the base Nerves System configuration for the [MangoPi MQ Pro](#mangopi).

![MangoPi MQ Pro](assets/mq-pro-pink-t.png)
<br><sup>[Image credit](#mangopi)</sup>

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | 1 GHz 64 bit RISC-V             |
| Memory               | 512 MB or 1 GB DRAM             |
| Storage              | MicroSD                         |
| Linux kernel         | 5.14 w/ patches                 |
| IEx terminal         | UART `ttyS0`                    |
| GPIO, I2C, SPI       | Yes - [Elixir Circuits](https://github.com/elixir-circuits) |
| Display              | Yes, but not supported yet      |
| ADC                  | Yes                             |
| PWM                  | Yes, but no Elixir support      |
| UART                 | ttyS0                           |
| Camera               | None                            |
| Ethernet             | No                              |
| WiFi                 | Onboard WiFi                    |
| RTC                  | No                              |
| HW Watchdog          | Yes                             |

## Using

The most common way of using this Nerves System is create a project with `mix
nerves.new` and add `mangopi` references where needed and in a similar way
to the default systems like `bbb`, etc. Then export `MIX_TARGET=mangopi`.
See the [Getting started
guide](https://hexdocs.pm/nerves/getting-started.html#creating-a-new-nerves-app)
for more information.

If you need custom modifications to this system for your device, clone this
repository and update as described in [Making custom
systems](https://hexdocs.pm/nerves/customizing-systems.html).

## Console access

The console is configured to output to the UART on pins 8 and 10 on the 40-pin
GPIO connector. This is just like the Raspberry Pi. A 3.3V FTDI cable is needed
to access the output.

## Networking

The board has two network interfaces, a WiFi module and a virtual Ethernet on
the USB C connector marked "OTG".

## Thanks

Since there aren't many RISC-V boards out, it took a bit of searching to figure
out how to bring this board up. The key was finding out that it's a trimmed down
version of the
[Nezha](https://www.indiegogo.com/projects/nezha-your-first-64bit-risc-v-linux-sbc-for-iot#/)
board since it's possible to find decent device tree configurations and Linux
configurations that actually work. Everything in this repository derives from
that and not from Tina Linux. The Linux kernel comes from [smaeul's Allwinner D1
Linux fork](https://github.com/smaeul/linux/tree/d1/all/arch/riscv).

[Image credit](#mangopi): This image is from [mangopi.cc](https://mangopi.cc/mangopi_mqpro).

