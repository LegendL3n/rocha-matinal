defmodule RochaMatinal.MixProject do
  use Mix.Project

  def project do
    [
      app: :rocha_matinal,
      version: "0.2.0",
      elixir: "~> 1.16",
      escript: escript(),
      deps: deps()
    ]
  end

  defp escript do
    [main_module: RochaMatinal.CLI]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:nostrum, "~> 0.8"}
    ]
  end
end
