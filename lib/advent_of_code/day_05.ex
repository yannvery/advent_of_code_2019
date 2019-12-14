defmodule AdventOfCode.Day05 do
  # What I need is a pointer value and a list a value
  # I start at 0 and read the value.
  # The value is an OP code
  # With this OP code I known th enumbre of paramters I have to read
  # I can update the pointer and the list by doing the operation provided by the OP code

  def part1(value) do
    list = value_to_list(value)
    do_operations(0, list)
  end

  def value_to_list(value) do
    String.split(value, ",") |> Enum.map(&String.to_integer(&1))
  end

  def do_operations(-1, list), do: list

  def do_operations(position, list) do
    action_details = list |> Enum.at(position) |> action_and_modes()
    {next_position, new_list} = action(action_details, position, list)
    do_operations(next_position, new_list)
  end

  def action_and_modes(number) do
    number |> Integer.digits() |> Enum.reverse() |> format_action()
  end

  def format_action(list) do
    [do_format_action(list), mode(1, list), mode(2, list), mode(3, list)]
  end

  def do_format_action([a1 | [a2 | _tail]]), do: a2 * 10 + a1
  def do_format_action([a1 | _tail]), do: a1

  def mode(position, list) do
    Enum.at(list, position + 1) || 0
  end

  def action([1 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)
    dest = Enum.at(list, position + 3)
    new_list = List.replace_at(list, dest, param1 + param2)
    {position + 4, new_list}
  end

  def action([2 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)
    dest = Enum.at(list, position + 3)
    new_list = List.replace_at(list, dest, param1 * param2)
    {position + 4, new_list}
  end

  def action([3 | _modes], position, list) do
    value = IO.gets("Input: ") |> String.trim() |> String.to_integer()
    destination = Enum.at(list, position + 1)
    {position + 2, List.replace_at(list, destination, value)}
  end

  def action([4 | _modes], position, list) do
    destination = Enum.at(list, position + 1)
    IO.puts("Output: #{Enum.at(list, destination)}")
    {position + 2, list}
  end

  @doc """
  Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
  """
  def action([5 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)

    next_position =
      case param1 do
        0 -> position + 3
        _ -> param2
      end

    {next_position, list}
  end

  @doc """
  Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
  """

  def action([6 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)

    next_position =
      case param1 do
        0 -> param2
        _ -> position + 3
      end

    {next_position, list}
  end

  @doc """
  Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
  """
  def action([7 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)

    destination = Enum.at(list, position + 3)

    next_list =
      case param1 < param2 do
        true -> List.replace_at(list, destination, 1)
        _ -> List.replace_at(list, destination, 0)
      end

    {position + 4, next_list}
  end

  @doc """
  Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
  """

  def action([8 | modes], position, list) do
    [param1, param2] = get_params(modes, list, position + 1, 2)

    destination = Enum.at(list, position + 3)

    next_list =
      case param1 == param2 do
        true -> List.replace_at(list, destination, 1)
        _ -> List.replace_at(list, destination, 0)
      end

    {position + 4, next_list}
  end

  def action([99 | _modes], _position, list), do: {-1, list}

  def get_params(modes, list, position, nb_params) do
    list
    |> Enum.slice(position, nb_params)
    |> Enum.with_index()
    |> Enum.map(fn {v, i} ->
      case Enum.at(modes, i) do
        1 -> v
        0 -> Enum.at(list, v)
      end
    end)
  end

  def part2(args), do: part1(args)
end
