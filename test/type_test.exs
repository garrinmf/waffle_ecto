defmodule WaffleTest.Ecto.Type do
  use ExUnit.Case, async: false

  test "dumps filenames with timestamp" do
    {:ok, value} = DummyDefinition.Type.dump("file.png")
    assert value == "file.png"
  end

  test "loads filenames with timestamp" do
    {:ok, value} = DummyDefinition.Type.load("file.png")
    assert value == "file.png"
  end

  test "loads pathological filenames" do
    {:ok, value} = DummyDefinition.Type.load("image.php")
    assert value == "image.php"
  end

  test "loads pathological filenames without timestamps" do
    {:ok, value} = DummyDefinition.Type.load("image^!?*!=@$.php")
    assert value == "image^!?*!=@$.php"
  end

  test "dumps without updated_at" do
    {:ok, dumped_type} = DummyDefinition.Type.dump("file.png")
    assert dumped_type == "file.png"
  end
end
