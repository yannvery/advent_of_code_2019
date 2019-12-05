defmodule AdventOfCode.Day03 do
  def part1(input) do
    input
    |> to_tuple_of_list
    |> generate_paths
    |> find_intersections
    |> sort_intersections
    |> first_one
  end

  def to_tuple_of_list(string) do
    string
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, ",") end)
    |> List.to_tuple()
  end

  def generate_paths({path1, path2}) do
    {generate_path(path1), generate_path(path2)}
  end

  def sort_intersections(list) do
    Enum.sort(list, fn {_k, d1}, {_k2, d2} -> d1 <= d2 end)
  end

  def find_intersections({path1, path2}) do
    Enum.reduce(path1, [], fn {key, _v}, acc ->
      case Map.get(path2, key) do
        v when is_integer(v) -> [{key, manathan_distance(key)} | acc]
        _ -> acc
      end
    end)
  end

  def manathan_distance({x, y}) do
    abs(x) + abs(y)
  end

  def first_one(list) do
    Enum.at(list, 1) |> elem(1)
  end

  def generate_path(path) do
    {_point, path, _step} =
      Enum.reduce(path, {{0, 0}, %{}, -1}, fn command, {point, path, step} ->
        {updated_point, delta_path, step} = point_and_path_from(point, command, step)
        {updated_point, Map.merge(path, delta_path), step - 1}
      end)

    IO.inspect(path)
    path
  end

  def point_and_path_from({x, y}, "R" <> length, step) do
    int = String.to_integer(length)

    Enum.reduce(x..(x + int), {{x, y}, %{}, step}, fn v, acc ->
      {{v, y}, Map.put(elem(acc, 1), {v, y}, elem(acc, 2) + 1), elem(acc, 2) + 1}
    end)
  end

  def point_and_path_from({x, y}, "L" <> length, step) do
    int = String.to_integer(length)

    Enum.reduce(x..(x - int), {{x, y}, %{}, step}, fn v, acc ->
      {{v, y}, Map.put(elem(acc, 1), {v, y}, elem(acc, 2) + 1), elem(acc, 2) + 1}
    end)
  end

  def point_and_path_from({x, y}, "D" <> length, step) do
    int = String.to_integer(length)

    Enum.reduce(y..(y - int), {{x, y}, %{}, step}, fn v, acc ->
      {{x, v}, Map.put(elem(acc, 1), {x, v}, elem(acc, 2) + 1), elem(acc, 2) + 1}
    end)
  end

  def point_and_path_from({x, y}, "U" <> length, step) do
    int = String.to_integer(length)

    Enum.reduce(y..(y + int), {{x, y}, %{}, step}, fn v, acc ->
      {{x, v}, Map.put(elem(acc, 1), {x, v}, elem(acc, 2) + 1), elem(acc, 2) + 1}
    end)
  end

  def part2(input) do
    input
    |> to_tuple_of_list
    |> generate_paths
    |> find_intersections_by_step
    |> sort_intersections
    |> first_one
  end

  def find_intersections_by_step({path1, path2}) do
    Enum.reduce(path1, [], fn {key, s1}, acc ->
      case Map.get(path2, key) do
        s2 when is_integer(s2) -> [{key, s1 + s2} | acc]
        _ -> acc
      end
    end)
  end
end
