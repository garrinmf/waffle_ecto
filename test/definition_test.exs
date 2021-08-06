defmodule WaffleTest.Ecto.Definition do
  use ExUnit.Case

  test "defines Definition.Type module" do
    assert DummyDefinitionTwo.Type.type() == Waffle.Ecto.Type.type()
  end

  test "falls back to pre-defined url" do
    assert DummyDefinitionTwo.url("test.png", :original, []) == "fallback"
  end

  test "url appends timestamp to url with no query parameters" do
    url = DummyDefinitionTwo.url({"test.png", :scope}, :original, [])
    assert url == "fallback"
  end

  test "url appends timestamp to url with query parameters" do
    url = DummyDefinitionTwo.url({"test.png", :scope}, :signed, [])
    assert url == "fallback?a=1&b=2"
  end

  test "url is unchanged if no timestamp is present" do
    url = DummyDefinitionTwo.url({"test.png", :scope}, :original, [])
    assert url == "fallback"
  end

  test "url is nil if version is skipped" do
    url = DummyDefinitionTwo.url({"test.png", :scope}, :skipped, [])
    assert is_nil(url)
  end
end
