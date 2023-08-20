defmodule Mix.Tasks.RochaMatinal.Task do
  use Mix.Task

  alias HTTPoison, as: HTTP
  alias ClipProvider
  alias DiscordSender

  @spec run(any) :: :ok
  def run(_) do
    HTTP.start

    ClipProvider.get_random_clip |> DiscordSender.send_clip

    :ok
  end
end
