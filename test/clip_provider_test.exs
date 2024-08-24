ExUnit.start()

defmodule ClipProviderTest do
  alias ClipProvider
  use ExUnit.Case, async: true

  test "when a clip is provided, the clip name should return normalized with all letters" do
    IO.puts "hi"
    ClipProvider.get_clip_name("simple.mp3")
    assert ClipProvider.get_clip_name("simple.mp3") == "simple.mp3"
  end

  test "when a clip with a comma is passed, the clip name should return normalized with all letters" do
    IO.puts "hi"
    ClipProvider.get_clip_name("Sanção, Adão, Davinci - Fernando Rocha - vol.6.mp3")
    assert ClipProvider.get_clip_name("Sanção, Adão, Davinci - Fernando Rocha - vol.6.mp3") == "Sancao_Adao_Davinci.mp3"
  end
end
