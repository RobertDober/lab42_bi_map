defmodule Lab42.BiMap do

  @moduledoc """
  ## Introduction

  BiMap, a bidrectional map.

  As in a traditional map we _assign_ values to keys however the keys are **also assigned**
  to values.

  The following assertion holds therefore all the time:

  * If a value `v` is assigned to a key `k`, the key `k` is assigned to the value `v`.

  For that reason there is no pendant to the following `Map` in a `BiMap`.

  `%{a: 1, b: 1}`

  We refer to the mapping from keys to values as the _left_ map and the reverse mapping
  from values to keys as _right_ map.

  ## Genesis

  In the beginning it is empty

      iex(0)> bimap = Lab42.BiMap.new
      %Lab42.BiMap{}

  Or not

      iex(1)> bimap = new(a: 1, b: 2)
      %Lab42.BiMap{left: %{a: 1, b: 2}, right: %{1 => :a, 2 => :b}}


  Not all input is valid, last erases first

      iex(2)> new(a: 1, b: 1)
      %Lab42.BiMap{left: %{b: 1}, right: %{1 => :b}}


  Construction can came from a map...

      iex(3)> %{a: 1, b: 2} |> Enum.into(new)
      %Lab42.BiMap{left: %{a: 1, b: 2}, right: %{1 => :a, 2 => :b}}

  ... or a tuple list

      iex(3)> [{1, :a}, {2, :b}] |> Enum.into(new)
      %Lab42.BiMap{left: %{1 => :a, 2 => :b}, right: %{a: 1, b: 2}}

  ## Curriculum

      iex(6)> new(a: 1, b: 2)
      ...(6)> |> put(:c, 3)
      %Lab42.BiMap{left: %{a: 1, b: 2, c: 3}, right: %{1 => :a, 2 => :b, 3 => :c}}

      iex(7)> new(a: 1, b: 2)
      ...(7)> |> put(:b, 3)
      %Lab42.BiMap{left: %{a: 1, b: 3}, right: %{1 => :a, 3 => :b}}

  Assigning an already present value to a new key, replaces the old key

      iex(8)> new(a: 1, b: 2)
      ...(8)> |> put(:b, 1)
      %Lab42.BiMap{left: %{b: 1}, right: %{1 => :b}}

      iex(9)> new(a: 1, b: 2)
      ...(9)> |> update_left(%{a: 3, c: 4})
      %Lab42.BiMap{left: %{a: 3, b: 2, c: 4}, right: %{3 => :a, 2 => :b, 4 => :c}}
  """
  defstruct left: %{}, right: %{}

  @type t :: %__MODULE__{left: map(), right: map()}


  @spec new(Enumerable.t) :: t() 
  def new(enum \\ []) do
    enum
    |> Enum.into( %__MODULE__{} )
  end

  @spec put( t(), any(), any() ) :: t()
  def put(%__MODULE__{left: l, right: r}, k, v) do
    r1 = Map.delete(r, Map.get(l, k, nil)) |> Map.put(v, k)
    l1 = Map.delete(l, Map.get(r, v, nil)) |> Map.put(k, v)
    %__MODULE__{left: l1, right: r1}
  end

  def update_left(bimap, enum) do
    enum |> Enum.into(bimap)
  end
end
