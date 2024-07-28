defmodule DiscordSender do
  alias HTTPoison, as: HTTP

  @username "Fernando Rocha"
  @avatar_url "https://i.ibb.co/QHHPPH4/roch1.jpg"

  @spec send_clip(nil | maybe_improper_list | map, binary()) :: :ok
  def send_clip(clip, webhook_url) do
    send_discord_request(webhook_url, "{\"username\": \"#{@username}\", \"avatar_url\": \"#{@avatar_url}\"}", clip)
    :ok
  end

  defp send_discord_request(webhook_url, json_payload, clip) do
    HTTP.request!(
      :post,
      webhook_url,
      {:multipart,
       [
         {
           "file",
           json_payload,
           {"form-data", [name: "payload_json"]},
           []
         },
         {
           :file,
           clip[:path],
           {"form-data", [name: "files[0]", filename: clip[:name] <> ".mp3"]},
           []
         }
       ]}
    )
  end
end
