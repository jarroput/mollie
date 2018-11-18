defmodule Molliex.MixProject do
  use Mix.Project

  def project do
    [
      app: :molliex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:jason, "~> 1.1"},
      {:credo, "~> 1.0", only: [:test, :dev], runtime: false}
    ]
  end
end
