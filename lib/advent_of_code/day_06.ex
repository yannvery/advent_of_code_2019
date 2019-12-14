defmodule AdventOfCode.Day06 do
  @doc """
  The basic structure is a map like:
  %{
  "A" => "B",
  "C" => "A"
  }

  This describes that A orbits B directly and C orbits B.
  Also, C orbits B indirectly.

  A more complex structure could be
  %{
  "A" => ["B"],
  "C" => ["A", "B"]
  }

  where the first item is the direct orbit and the others are the indirect orbits.
  """
  def part1(args) do
    args
    |> build_inputs()
    |> build_direct_orbits()
    |> build_all_orbits()
    |> Enum.reduce(0, fn {_satellite, orbits}, acc ->
      acc + Enum.count(orbits)
    end)
  end

  def build_inputs(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ")"))
  end

  def build_direct_orbits(inputs) do
    Enum.reduce(inputs, %{}, fn [corpse, satellite], acc ->
      Map.put_new(acc, satellite, corpse)
    end)
  end

  def build_all_orbits(direct_orbits) do
    Enum.reduce(direct_orbits, %{}, fn {satellite, _orbit}, acc ->
      Map.put(acc, satellite, get_orbits(direct_orbits, satellite))
    end)
  end

  def get_orbits(map, corpse, corpses \\ [])
  def get_orbits(_map, nil, corpses), do: corpses

  def get_orbits(map, corpse, corpses) do
    next = map[corpse]

    corpses =
      case next do
        nil -> corpses
        value when is_list(value) -> corpses ++ value
        value when is_binary(value) -> corpses ++ [value]
      end

    get_orbits(map, next, corpses)
  end

  def count_all_orbits(orbits) do
    orbits
    |> Enum.reduce(0, fn {_k, sub_orbits}, acc ->
      Enum.count(sub_orbits) + acc
    end)
  end

  def part2(args) do
    all_orbits =
      args
      |> build_inputs()
      |> build_direct_orbits()
      |> build_all_orbits()

    find_common_points(all_orbits, "SAN", "YOU")
    |> find_shortest_path(all_orbits, "SAN", "YOU")
  end

  def find_common_points(orbits, position, destination) do
    Enum.filter(orbits[position], fn x -> Enum.member?(orbits[destination], x) end)
  end

  def find_shortest_path(unused_path, orbits, position, destination) do
    Enum.count(orbits[position] -- unused_path) + Enum.count(orbits[destination] -- unused_path)
  end
end
