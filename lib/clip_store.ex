defmodule ClipStore do

  def init do
    {:ok, db} = CubDB.start_link(data_dir: "database")
    db
  end

  @spec store_sent_clip(pid(), %Clip{name: String, path: String}) :: :ok
  def store_sent_clip(db, clip) do
    CubDB.put(db, clip.name, clip.path)
  end
end
