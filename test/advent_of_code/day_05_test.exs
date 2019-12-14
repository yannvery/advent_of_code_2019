defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05
  import ExUnit.CaptureIO

  @tag :skip
  test "part1" do
    assert part1("1002,4,3,4,33") == [1002, 4, 3, 4, 99]
  end

  @tag :skip
  test "part2" do
    input = "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"

    assert capture_io([input: "0\n", capture_prompt: false], fn ->
             part2(input)
           end) == "Output: 0\n"

    assert capture_io([input: "9\n", capture_prompt: false], fn ->
             part2(input)
           end) == "Output: 1\n"
  end

  @tag :skip
  test "part2 larger example" do
    input =
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"

    assert capture_io([input: "8\n", capture_prompt: false], fn ->
             part2(input)
           end) == "Output: 1000\n"

    assert capture_io([input: "9\n", capture_prompt: false], fn ->
             part2(input)
           end) == "Output: 1001\n"
  end
end
