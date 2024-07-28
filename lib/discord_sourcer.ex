defmodule DiscordSourcer do
  alias Nostrum.Api, as: Discord

  @max_message_history 256

  def get_sent_clips(channel_id) do
    fetched_clips = fetch_all_sent_clips(channel_id)

    fetched_clips
      |> Enum.map(fn msg -> msg.attachments |> Enum.at(0) end)
      |> Enum.filter(& !is_nil(&1))
      |> Enum.map(fn attachment -> [name: attachment.filename |> String.trim_trailing(".mp3")] end)
  end

  defp fetch_all_sent_clips(channel_id, fetched_clips \\ []) do
    locator = if Enum.empty?(fetched_clips), do: {}, else: {:before, Enum.at(fetched_clips, -1).id}
    current_fetch = Discord.get_channel_messages!(channel_id, @max_message_history, locator)

    if length(current_fetch) == 0 do
      fetched_clips
    else
      fetch_all_sent_clips(channel_id, fetched_clips ++ current_fetch)
    end
  end
end
