ExUnit.start()

defmodule Chapter1.PatternMatching do
  defmodule Exercise1.Tests do
    use ExUnit.Case, async: true

    test "reassigning variables using pattern matching" do
      assert _value = [1, 2, 3]
      assert _value = [[1, 2, 3]]
    end

    test "reassigning existing variables using pattern matching" do
      _value = [1, 2, 3]
      assert _value = 4
    end

    test "right hand side pattern matching using a variable" do
      value = [1, 2, 3]
      assert [1, 2, 3] = value
    end

    test "destructuring a list into a list of the same length using pattern matching" do
      assert [_value] = [[1, 2, 3]]
    end

    test "destructuring a list into a list of a different length using pattern matching" do
      assert_raise MatchError, fn ->
        [_value1, _value2] = [1, 2, 3]
      end

      assert_raise MatchError, fn ->
        [[_value]] = [[1, 2, 3]]
      end
    end
  end

  defmodule Exercise2.Tests do
    use ExUnit.Case, async: true

    test "variables are bound once in a pattern match" do
      assert [value1, _value2, value1] = [1, 2, 1]

      assert_raise MatchError, fn ->
        [value1, _value2, value1] = [1, 2, 3]
      end
    end
  end

  defmodule Exercise3.Tests do
    use ExUnit.Case, async: true

    test "using the pin operator on a preassigned variable does not reassign the variable" do
      value = 1

      assert_raise MatchError, fn ->
        ^value = 2
      end
    end
  end
end

defmodule Chapter5.AnonymousFunctions do
  defmodule Exercise1.Tests do
    use ExUnit.Case, async: true

    test "concating lists using an anonymous function" do
      list_concat = fn a, b ->
        a ++ b
      end

      list1 = [:value1, :value2]
      list2 = [:value3, :value4]

      assert list_concat.(list1, list2) === [:value1, :value2, :value3, :value4]
    end

    test "summing values using an anonymous function" do
      sum = fn a, b, c ->
        a + b + c
      end

      value1 = 1
      value2 = 2
      value3 = 3

      assert sum.(value1, value2, value3) === 6
    end
  end

  defmodule Exercise2And3.Tests do
    use ExUnit.Case, async: true

    test "naive FizzBuzz implementation using an anonymous function" do
      fizzbuzz = fn
        (0, 0, _) -> "FizzBuzz"
        (0, _, _) -> "Fizz"
        (_, 0, _) -> "Buzz"
        (_, _, value) -> value
      end

      generator = &(fizzbuzz.(rem(&1, 3), rem(&1, 5), &1))

      values = for n <- 10..16, do: generator.(n)

      assert values === ["Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16]
    end
  end

  defmodule Exercise4.Tests do
    use ExUnit.Case, async: true

    test "partial application in anonymous functions" do
      prefix = fn prefix -> (fn term -> "#{prefix} #{term}" end) end

      mrs = prefix.("Mrs")

      assert mrs.("Smith") === "Mrs Smith"
      assert prefix.("Elixir").("Rocks") === "Elixir Rocks"
    end
  end

  defmodule Exercise5.Tests do
    use ExUnit.Case, async: true

    test "shorthand anonymous functions as function parameters" do
      assert Enum.map [1, 2, 3, 4], &(&1 + 2) === [3, 4, 5, 6]
    end
  end
end

defmodule Chaper6.ModulesAndNamedFunctions do
  defmodule Exercise4.Tests do
    use ExUnit.Case, async: true

    defmodule Sum do
      def to(n), do: to(n, 0)

      defp to(0, accummlator), do: accummlator

      defp to(n, accumulator) do
        accumulator = accumulator + n
        to(n - 1, accumulator)
      end
    end

    test "recursive sum function" do
      assert Sum.to(3) == 6
      assert Sum.to(5) == 15
      assert Sum.to(400) == 80200
    end
  end

  defmodule Exercise5.Tests do
    use ExUnit.Case, async: true

    defmodule GCD do
      def calculate(x, 0), do: x

      def calculate(x, y), do: calculate(y, rem(x, y))
    end

    test "greatest common divisor function" do
      assert GCD.calculate(123, 321) === 3
    end
  end

  defmodule Exercise6.Tests do
    use ExUnit.Case, async: true

    defmodule Chop do
      def guess(actual, range) do
        lower..upper = range
        new_guess = div(lower + upper, 2)

        guess(actual, range, new_guess)
      end

      defp guess(actual, range, current_guess) when current_guess > actual do
        lower.._ = range

        new_upper = current_guess - 1

        guess(actual, lower..new_upper)
      end

      defp guess(actual, range, current_guess) when current_guess < actual do
        _..upper = range

        new_lower = current_guess + 1

        guess(actual, new_lower..upper)
      end

      defp guess(actual, _, current_guess) when current_guess === actual do
        actual
      end
    end

    test "function guard clauses" do
     assert Chop.guess(273, 1..1000) === 273
    end
  end

  defmodule Exercise7.Tests do
    use ExUnit.Case, async: true

    test "float to string with two decimal places using the Erlang API" do
      assert :erlang.float_to_binary(1.2367, [{:decimals, 2}]) === "1.24"
    end
  end
end

defmodule Play do
end
