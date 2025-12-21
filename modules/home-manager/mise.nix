_:

{
  xdg.configFile."mise/config.toml".text = ''
    [settings]
    auto_install = true
    yes = true
    trusted_config_paths = ["~/dev", "~/systems"]
    env_file = ".env"

    idiomatic_version_file_enable_tools = [
      "terraform",
      "node",
      "python",
      "go",
      "ruby",
      "java",
      "elixir",
    ]

    [settings.status]
    missing_tools = "always"
    show_tools = true
    show_env = true
  '';
}
