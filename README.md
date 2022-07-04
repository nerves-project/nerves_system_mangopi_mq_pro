# MangoPi MQ Pro Support

*This is a work in progress.*

[![CircleCI](https://circleci.com/gh/fhunleth/nerves_system_mangopi_mq_pro.svg?style=svg)](https://circleci.com/gh/fhunleth/nerves_system_mangopi_mq_pro)
[![Hex version](https://img.shields.io/hexpm/v/nerves_system_mangopi_mq_pro.svg "Hex version")](https://hex.pm/packages/nerves_system_mangopi_mq_pro)

This is the base Nerves System configuration for the [MangoPi MQ Pro](#mangopi).

![MangoPi MQ Pro](assets/images/mq-pro-pink-t.png)
<br><sup>[Image credit](#mangopi)</sup>

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | 1 GHz 64 bit RISC-V             |
| Memory               | 512 MB or 1 GB DRAM             |
| Storage              | MicroSD                         |
| Linux kernel         | 5.18 w/ patches                 |
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


## Depedencies

* OTP 25 or higher
* Nerves archive `mix archive.install hex nerves_bootstrap` [See here](https://github.com/nerves-project/nerves/blob/main/docs/Installation.md)

### Example


Creating a new hello world application

```
# This assumes you have used nerves before
mix nerves.new hello_mango
cd hello_mango
echo "elixir 1.13.4-otp-25" > .tool-versions
echo "erlang 25.0.2" >> .tool-versions 
asdf install
```

Open up your `mix.exs` and update it to include

```mix.exs
{:nerves_system_mangopi_mq_pro, runtime: false, targets: :mangopi, nerves: [compile: true], git: "https://github.com/fhunleth/nerves_system_mangopi_mq_pro", branch: "main"}
```


```
export MIX_TARGET=mangopi
mix deps.get
mix firmware
mix burn
```

## Console access

The console is configured to output to the UART on pins 8 and 10 on the 40-pin
GPIO connector. This is just like the Raspberry Pi. A 3.3V FTDI cable is needed
to access the output.

## Networking

The board has two network interfaces, a WiFi module and a virtual Ethernet on
the USB C connector marked "OTG".

## Thanks

The most helpful Allwinner D1 information comes from
[linux-sunxi.org/Allwinner_Nezha](https://linux-sunxi.org/Allwinner_Nezha). All
of the work here wouldn't have been possible with out it. Thanks especially to
[smaeul's Allwinner D1 Linux fork](https://github.com/smaeul/linux/tree/riscv/d1-wip/arch/riscv)

[Image credit](#mangopi): This image is from [mangopi.cc](https://mangopi.cc/mangopi_mqpro).

