defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip
  test "part1" do
    input = [12]
    assert part1(input) == 2
    input = [14]
    assert part1(input) == 2
    input = [1969]
    assert part1(input) == 654
    input = [100_756]
    assert part1(input) == 33583
    input = [12, 14]
    assert part1(input) == 4
  end

  @tag :skip
  test "part2" do
    input = [14]
    assert part2(input) == 2
    input = [1969]
    assert part2(input) == 966
    input = [100_756]
    assert part2(input) == 50346
    input = [14, 1969]
    assert part2(input) == 968
  end
end
