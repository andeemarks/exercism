using System.IO.Pipelines;
using System.Text.RegularExpressions;

public static partial class Wordy
{
    public static int Answer(string question)
    {

        try
        {
            var threeOperandTest = ThreeOperandRegex().Match(question);
            if (threeOperandTest.Success)
            {
                var twoOperandResult = ResolveTwoOperandEquation(threeOperandTest);
                var op2 = threeOperandTest.Groups["Operator2"].Value;
                var operand3 = Int32.Parse(threeOperandTest.Groups["Op3"].Value);

                return ParseEquationOperator(twoOperandResult, operand3, op2);
            }

            var twoOperandTest = TwoOperandRegex().Match(question);
            if (twoOperandTest.Success)
            {
                return ResolveTwoOperandEquation(twoOperandTest);
            }

            var identityTest = Regex.Match(question, @"What is (?<Value>\d+)\?");
            if (identityTest.Success)
            {
                return Int32.Parse(identityTest.Groups["Value"].Value);
            }

        }
        catch (System.FormatException)
        {
            throw new ArgumentException();
        }   
             
        throw new ArgumentException();
    }

    private static int ResolveTwoOperandEquation(Match equation)
    {
        var operand1 = Int32.Parse(equation.Groups["Op1"].Value);
        var operand2 = Int32.Parse(equation.Groups["Op2"].Value);
        var op = equation.Groups["Operator"].Value;

        return ParseEquationOperator(operand1, operand2, op);
    }

    private static int ParseEquationOperator(int operand1, int operand2, string op)
    {
        return op switch
        {
            "divided by" => operand1 / operand2,
            "plus" => operand1 + operand2,
            "multiplied by" => operand1 * operand2,
            "minus" => operand1 - operand2,
            _ => throw new ArgumentException(),
        };
    }

    [GeneratedRegex(@"What is (?<Op1>-?\d+) (?<Operator>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+) (?<Operator2>\b(divided by|plus|multiplied by|minus)\b) (?<Op3>-?\d+)\?")]
    private static partial Regex ThreeOperandRegex();
    
    [GeneratedRegex(@"What is (?<Op1>-?\d+) (?<Operator>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+)\?")]
    private static partial Regex TwoOperandRegex();
}