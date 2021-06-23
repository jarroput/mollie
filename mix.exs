defmodule Mollie.MixProject do
  use Mix.Project

  @description """
  Elixir wrapper for the Mollie API
  """

  def project do
    [
      app: :mollie,
      version: "0.5.0-dev",
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
      {:finch, "~> 0.7"},
      {:jason, "~> 1.2"},
      {:credo, "~> 1.0", only: [:test, :dev], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "mollie",
      maintainers: ["Jarro Put"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jarroput/mollie"}
    ]
  end
end
