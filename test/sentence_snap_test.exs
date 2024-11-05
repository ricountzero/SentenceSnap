defmodule SentenceSnapTest do
  use ExUnit.Case
  doctest SentenceSnap

  test "greets the world" do
    assert SentenceSnap.hello() == :world
  end
end
