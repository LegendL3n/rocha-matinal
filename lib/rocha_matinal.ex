defmodule Mix.Tasks.RochaMatinal.App do
  use Mix.Task

  alias HTTPoison, as: HTTP
  alias DiscordSender

  def run(_) do
    HTTP.start

    DiscordSender.send_message("Ola", "HEhe")

    :ok
  end
end
