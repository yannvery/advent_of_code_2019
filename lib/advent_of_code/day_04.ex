defmodule AdventOfCode.Day04 do
  @doc """
  You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.
  However, they do remember a few key facts about the password:

  It is a six-digit number.
  The value is within the range given in your puzzle input.
  Two adjacent digits are the same (like 22 in 122345).
  Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
  Other than the range rule, the following are true:

  111111 meets these criteria (double 11, never decreases).
  223450 does not meet these criteria (decreasing pair of digits 50).
  123789 does not meet these criteria (no double).

  How many different passwords within the range given in your puzzle input meet these criteria?
  """
  def part1(value) do
    value
    |> to_range()
    |> Stream.filter(fn x -> adjacent_digit?(x) end)
    |> Stream.filter(fn x -> not_decreasing?(x) end)
    |> Enum.to_list()
    |> Enum.count()
  end

  def to_range(string) do
    [first, last] =
      string
      |> String.split("-")
      |> Enum.map(fn x -> String.to_integer(x) end)

    Range.new(first, last)
  end

  def adjacent_digit?(number) do
    {_, state} =
      number
      |> Integer.to_string()
      |> String.to_charlist()
      |> Enum.reduce({nil, false}, fn x, {prev_number, status} ->
        with false <- status,
             ^prev_number <- x do
          {x, true}
        else
          true -> {x, true}
          _ -> {x, false}
        end
      end)

    state
  end

  def not_decreasing?(number) do
    {_, state} =
      number
      |> Integer.to_string()
      |> String.to_charlist()
      |> Enum.reduce({0, :increasing}, fn x, {prev_number, status} ->
        with :increasing <- status,
             true <- x >= prev_number do
          {x, :increasing}
        else
          _ -> {x, :decreasing}
        end
      end)

    case state do
      :decreasing -> false
      :increasing -> true
    end
  end

  @doc """
    An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.

  Given this additional criterion, but still ignoring the range rule, the following are now true:

  112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
  123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
  111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
  How many different passwords within the range given in your puzzle input meet all of the criteria?
  """
  def part2(value) do
    value
    |> to_range()
    |> Stream.filter(fn x -> adjacent_digit?(x) end)
    |> Stream.filter(fn x -> not_decreasing?(x) end)
    |> Stream.filter(fn x -> at_least_a_double?(x) end)
    |> Enum.to_list()
    |> Enum.count()
  end

  def at_least_a_double?(number) do
    number
    |> Integer.to_charlist()
    |> Enum.reduce(%{}, fn x, acc ->
      count = Map.get(acc, x, 0) + 1
      Map.put(acc, x, count)
    end)
    |> Enum.reduce(false, fn {_k, v}, state ->
      state || v == 2
    end)
  end

  def debug do
    value = "264793-803935"
    part1(value) -- part2(value)
  end
end
