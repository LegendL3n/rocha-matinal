defmodule RochaMatinal.MixProject do
  use Mix.Project

  def project do
    [
      app: :rocha_matinal,
      version: "0.2.0",
      elixir: "~> 1.16",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:nostrum, "~> 0.8"},
      {:mox, "~> 0.5.2", only: :test}
    ]
  end
end
