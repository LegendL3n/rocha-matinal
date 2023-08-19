defmodule ClipProvider do
  @extract_clip_name ~r/.+\/\d\d\. (.+) -.+\.mp3/U

  @doc """
  Returns a random clip from the clips/ folder, ignoring the first of a CD. (e.g. "01. Introdução")
  """
  def get_random_clip do
    get_all_clips() |> ignore_intro_clips |> Enum.random |> build_clip
  end

  defp get_all_clips do
    Path.wildcard("clips/*/*.mp3")
  end

  defp ignore_intro_clips(clips) do
    Enum.filter(clips, &(!(&1 =~ "01")))
  end

  defp build_clip(path) do
    [name: get_clip_name(path), path: path]
  end

  defp get_clip_name(path) do
    [_, name] = Regex.run(@extract_clip_name, path)
    name
  end
end
