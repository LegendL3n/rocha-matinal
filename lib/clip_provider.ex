defmodule ClipProvider do
  @extract_clip_name_regex ~r/.+\/\d\d\. (.+) -.+\.mp3/U
  @sanitize_regex ~r/[^a-zA-Z0-9 -.]+/

  def get_all_clips do
    Path.wildcard("clips/*/*.mp3") |> Enum.filter(&is_not_intro_clip/1)
  end

  def build_clip(path) do
    IO.puts "Building clip '#{path}'"
    [name: get_clip_name(path), path: path]
  end

  defp is_not_intro_clip(clip), do: !(clip =~ "01")

  def get_clip_name(path) do
    path = path |> String.normalize(:nfd)
    [_, name] = Regex.run(@extract_clip_name_regex, path)
    Regex.replace(@sanitize_regex, name, "") |> String.replace(" ", "_")
  end
end
