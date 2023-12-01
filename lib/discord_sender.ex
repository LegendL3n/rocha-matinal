defmodule DiscordSender do
  alias HTTPoison, as: HTTP

  @username "Fernando Rocha"
  @avatar_url "https://i.ibb.co/QHHPPH4/roch1.jpg"

  @spec send_clip(nil | maybe_improper_list | map) :: :ok
  def send_clip(clip) do
    create_attachment_url(clip) |> IO.puts
    :ok
  end

  defp create_attachment_url(clip) do
    %{size: size} = File.stat! clip[:path]

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.post(
      "https://postman-echo.com/post",
      "{\"files\": [\"id\": 2, \"filename\": \"#{clip[:name] <> ".mp3"}, \"#{size}\"}\" ]}",
      [{"Content-Type", "application/json"}])
    args = Jason.decode!(body)[:data]
    IO.puts args
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
