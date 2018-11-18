defmodule Mollie.MixProject do
  use Mix.Project

  @description """
  Elixir wrapper for the Mollie API
  """

  def project do
    [
      app: :mollie,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: @description,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:jason, "~> 1.1"},
      {:credo, "~> 1.0", only: [:test, :dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "mollie_ex",
      maintainers: ["Jarro Put"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jarroput/mollie"}
    ]
  end
end
