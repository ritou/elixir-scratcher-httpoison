defmodule Scratcher.HTTPoison.MixProject do
  use Mix.Project

  def project do
    [
      app: :scratcher_httpoison,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: "Module for using HTTPoison as Scratcher's HTTP Client",
      package: [
        maintainers: ["Ryo Ito"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/ritou/elixir-scratcher-httpoison"}
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:scratcher, "~> 0.1"},
      {:httpoison, "~> 1.7"},

      # for docs
      {:ex_doc, "~> 0.21.3", only: :dev, runtime: false}
    ]
  end
end
