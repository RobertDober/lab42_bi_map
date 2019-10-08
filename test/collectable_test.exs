defmodule CollectableTest do
  use ExUnit.Case
  
  import Lab42.BiMap

  describe "map" do
    test "empty" do
      result = %{} |> Enum.into(new())
      assert result == make()
    end

    test "one element" do
      result = %{a: 1} |> Enum.into(new())
      assert result == make(a: 1)
    end
  end


  defp make(pairs \\ []) do
    left = pairs |> Enum.into(%{})
    right = pairs |> Enum.map(fn {l, r} -> {r, l} end) |> Enum.into(%{})
    %Lab42.BiMap{
      left: left,
      right: right
    }
  end
end
