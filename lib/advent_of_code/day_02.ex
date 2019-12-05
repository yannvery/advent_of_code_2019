defmodule AdventOfCode.Day02 do
  def part1(list) do
    slice_and_do(list, 0)
  end

  defp slice_and_do(list, start) when length(list) > start do
    sublist = Enum.slice(list, start, 4)
    list = action(sublist, list)
    slice_and_do(list, start + 4)
  end

  defp slice_and_do(list, _start), do: list

  defp action([1, pos1, pos2, dest], list) do
    List.replace_at(list, dest, Enum.at(list, pos1) + Enum.at(list, pos2))
  end

  defp action([2, pos1, pos2, dest], list) do
    List.replace_at(list, dest, Enum.at(list, pos1) * Enum.at(list, pos2))
  end

  defp action(_, list) do
    list
  end

  def part2(list) do
    find_noun_verb(list, 19_690_720)
  end

  def find_noun_verb(list, expected_value) do
    do_find_noun_verb(0, 0, list, expected_value)
  end

  def do_find_noun_verb(noun, verb, list, expected_value) do
    updated_list =
      list
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)

    case slice_and_do(updated_list, 0) |> Enum.at(0) do
      ^expected_value ->
        noun * 100 + verb

      _ ->
        {new_noun, new_verb} = compute_noun_and_verb(noun, verb)
        do_find_noun_verb(new_noun, new_verb, list, expected_value)
    end
  end

  def compute_noun_and_verb(noun, verb) when verb < 99, do: {noun, verb + 1}
  def compute_noun_and_verb(noun, _verb), do: {noun + 1, 0}
end
