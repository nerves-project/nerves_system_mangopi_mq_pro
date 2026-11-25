defmodule NervesSystemMangopiMQPro.MixProject do
  use Mix.Project

  @github_organization "nerves-project"
  @app :nerves_system_mangopi_mq_pro
  @source_url "https://github.com/#{@github_organization}/#{@app}"
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      # Because we're using OTP 27, we need to enforce Elixir 1.17 or later.
      elixir: "~> 1.17",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves: nerves(),
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  def cli do
    [
      preferred_envs: %{docs: :docs, "hex.build": :docs, "hex.publish": :docs},
      default_target: :target
    ]
  end

  defp nerves do
    [
      actions: [
        {Nerves.BuildAction.NervesV1System,
         app: @app,
         artifact_sites: artifact_sites(),
         package_env: package_env(),
         build_runner_opts: build_runner_opts()}
      ],
      config: [
        # The current MangoPi U-Boot version doesn't seem to like fragments so turn them off
        rootfs_type:
          {:squashfs,
           [
             "-no-fragments",
             "-no-tailends",
             "-mkfs-time",
             "0",
             "-all-time",
             "0",
             "-no-xattrs",
             "-quiet"
           ]}
      ]
    ]
  end

  defp nerves_package do
    [
      type: :system,
      artifact_sites: artifact_sites(),
      artifact_checksum: true,
      build_runner_opts: build_runner_opts(),
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      env: package_env(),
      checksum: source_finger_print_files()
    ]
  end

  defp artifact_sites do
    [
      {:github_releases, "#{@github_organization}/#{@app}"}
    ]
  end

  defp package_env do
    # baseline_rv64 enables the a, c, d, and m extensions in zig
    [
      {"TARGET_ARCH", "riscv64"},
      {"TARGET_CPU", "baseline_rv64"},
      {"TARGET_OS", "linux"},
      {"TARGET_ABI", "gnu"},
      {"TARGET_GCC_FLAGS",
       "-mabi=lp64d -fstack-protector-strong -march=rv64imafdc_zicsr_zifencei -fPIE -pie -Wl,-z,now -Wl,-z,relro"}
    ]
  end

  defp deps do
    [
      {:nerves, "~> 1.11 or ~> 2.0 or ~> 2.0.0-dev", runtime: false},
      {:nerves_system_br, "1.35.5", runtime: false},
      {:nerves_toolchain_riscv64_nerves_linux_gnu, "~> 15.3.0", runtime: false},
      {:nerves_system_linter, "~> 0.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :docs, runtime: false}
    ]
  end

  defp description do
    "Nerves System - MangoPi MQ-Pro"
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      main: "readme",
      assets: %{"assets" => "./assets"},
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp package do
    [
      files: package_files(),
      licenses: ["GPL-2.0-only", "GPL-2.0-or-later"],
      links: %{
        "GitHub" => @source_url,
        "REUSE Compliance" =>
          "https://api.reuse.software/info/github.com/nerves-project/nerves_system_mangopi_mq_pro"
      }
    ]
  end

  defp source_finger_print_files do
    [
      "config/config.exs",
      "fwup_include",
      "linux",
      "rootfs_overlay",
      "uboot",
      "fwup-ops.conf",
      "fwup.conf",
      "mix.exs",
      "nerves_defconfig",
      "post-build.sh",
      "post-createfs.sh"
    ]
  end

  defp package_files do
    [
      "CHANGELOG.md",
      "checksum.exs",
      "LICENSES/*",
      "README.md",
      "REUSE.toml",
      "VERSION"
    ] ++ source_finger_print_files()
  end

  defp build_runner_opts() do
    # Download source files first to get download errors right away.
    [make_args: primary_site() ++ ["source", "all", "legal-info"]]
  end

  defp primary_site() do
    case System.get_env("BR2_PRIMARY_SITE") do
      nil -> []
      primary_site -> ["BR2_PRIMARY_SITE=#{primary_site}"]
    end
  end
end
