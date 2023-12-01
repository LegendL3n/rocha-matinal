defmodule Mix.Tasks.RochaMatinal.Task do
  use Mix.Task

  alias HTTPoison, as: HTTP
  import ClipProvider
  alias ClipStore, as: Store
  import DiscordSender

  @spec run(any) :: :ok
  def run(_) do
    HTTP.start

    clip = get_random_clip()

    send_clip(clip)

    Store.init |> Store.store_sent_clip(clip)

    :ok
  end
end
