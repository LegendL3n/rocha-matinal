defmodule ClipProvider do
  @extract_clip_name_regex ~r/.+\/\d\d\. (.+) -.+\.mp3/U
  @sanitize_regex ~r/[^a-zA-Z0-9]+/

  @spec get_random_clip :: [{:name, binary} | {:path, binary}]
  @doc """
  Returns a random clip from the clips/ folder, ignoring the first of a CD. (e.g. "01. Introdução")
  """
  def get_random_clip do
    get_all_clips() |> Enum.filter(&is_not_intro_clip/1) |> Enum.random |> build_clip
  end

  defp get_all_clips do
    Path.wildcard("./clips/Volume 3/12. Zero Mil, Zero Centos - Fernando Rocha - vol.3.mp3")
  end

  defp is_not_intro_clip(clip), do: !(clip =~ "01")

  defp build_clip(path) do
    [name: get_clip_name(path), path: path]
  end

  defp get_clip_name(path) do
    [_, name] = Regex.run(@extract_clip_name_regex, path)
    Regex.replace(@sanitize_regex, name, "_")
  end
end
