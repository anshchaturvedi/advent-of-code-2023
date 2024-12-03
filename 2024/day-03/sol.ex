defmodule Day03 do
  def part1(file_name) do
    input = file_name |> File.read!()

    ~r/mul\([0-9]*,[0-9]*\)/
    |> Regex.scan(input)
    |> List.flatten()
    |> Enum.reduce(0, fn mult, acc ->
      [a, b] =
        mult
        |> String.slice(4..String.length(mult)-2)
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      acc + (a * b)
    end)
  end

  def part2(file_name) do
    input = file_name |> File.read!()

    {ans, _} =
      ~r/mul\([0-9]*,[0-9]*\)|don\'t\(\)|do\(\)/
      |> Regex.scan(input)
      |> List.flatten()
      |> Enum.reduce({0, true}, fn operation, {res, is_on?} ->
        case operation do
          "don't()" -> {res, false}
          "do()" -> {res, true}
          _ ->
            if is_on? do
              [a, b] =
                operation
                |> String.slice(4..String.length(operation)-2)
                |> String.split(",")
                |> Enum.map(&String.to_integer/1)

              {res + (a * b), true}
            else
              {res, false}
            end
        end
      end)

    ans
  end
end

IO.puts("Part 1:")
IO.puts(" " <> Integer.to_string(Day03.part1("sample.txt")))
IO.puts(" " <> Integer.to_string(Day03.part1("full.txt")))

IO.puts("Part 2:")
IO.puts(" " <> Integer.to_string(Day03.part2("sample2.txt")))
IO.puts(" " <> Integer.to_string(Day03.part2("full.txt")))
