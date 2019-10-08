defmodule Lab42.BiMap.Collectable do

  @moduledoc false
  alias Lab42.BiMap


  defimpl Collectable, for: BiMap do

    @typep collector_t :: ((BiMap.t, Collectable.command) -> BiMap.t)

    @impl true

    @spec into( BiMap.t ) :: {BiMap.t, collector_t()}
    def into(original) do
      {original, &_collector/2}
    end


    @spec _collector( BiMap.t, Collectable.command) :: (:ok|BiMap.t) 
    defp _collector(bimap, command)
    defp _collector(_, :halt), do: :ok
    defp _collector(bimap, :done), do: bimap
    defp _collector(bimap, {:cont, {k, v}}) do
      BiMap.put(bimap, k, v)
    end
  end
end
