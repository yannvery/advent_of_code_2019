defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @tag :skip
  test "part1" do
    input = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    """

    assert part1(input) == 42
  end

  @tag :skip
  test "get_orbits" do
    input = %{
      "B" => "COM",
      "C" => "B",
      "D" => "C",
      "E" => "D",
      "F" => "E",
      "G" => "B",
      "H" => "G",
      "I" => "D",
      "J" => "E",
      "K" => "J",
      "L" => "K"
    }

    assert get_orbits(input, "B") == ["COM"]
    assert get_orbits(input, "D") == ["C", "B", "COM"]
  end

  test "part2" do
    input = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    K)YOU
    I)SAN
    """

    assert part2(input) == 4
  end
end
