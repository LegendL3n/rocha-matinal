defmodule RochaMatinal.CLI do
  alias HTTPoison, as: HTTP
  alias ClipProvider
  alias DiscordSender

  def main(args) do
    args = args |> parse_args

    HTTP.start()

    sent_clips = DiscordSourcer.get_sent_clips(args[:channel_id])

    unsent_clips =
      ClipProvider.get_all_clips()
      |> Enum.filter(fn clip_path ->
        !Enum.any?(sent_clips, &(&1[:name] == ClipProvider.get_clip_name(clip_path)))
      end)

    if Enum.empty?(unsent_clips) do
      IO.puts("All clips have been sent!!")
      System.halt(1)
    end

    unsent_clips |> Enum.random() |> ClipProvider.build_clip() |> DiscordSender.send_clip(args[:webhook_url])
  end

  defp parse_args(args) do
    {opts, _, _} =
      args
      |> OptionParser.parse(aliases: [w: :webhook_url, c: :channel_id], strict: [webhook_url: :string, channel_id: :integer])

    opts
  end
end
