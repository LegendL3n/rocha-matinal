defmodule DiscordSender do
  alias HTTPoison, as: HTTP
  alias Poison

  @username "Fernando Rocha"
  @avatar_url "https://i.ibb.co/QHHPPH4/roch1.jpg"

  def send_clip(clip) do
    build_json_payload() |> send_discord_request(clip)
  end

  defp build_json_payload do
    Poison.encode!(%{"username" => @username, "avatar_url" => @avatar_url})
  end

  defp send_discord_request(json_payload, clip) do
    webhook_url = File.read!(".webhook_url")

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
