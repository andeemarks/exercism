using System.IO.Pipelines;
using System.Text.RegularExpressions;

public static class Wordy
{
    public static int Answer(string question)
    {

        try
        {
            var threeOperandTest = Regex.Match(question, @"What is (?<Op1>-?\d+) (?<Operator>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+) (?<Operator2>\b(divided by|plus|multiplied by|minus)\b) (?<Op3>-?\d+)\?");
            if (threeOperandTest.Success)
            {
                var twoOperandResult = ResolveTwoOperandEquation(threeOperandTest);
                var op2 = threeOperandTest.Groups["Operator2"].Value;
                var operand3 = Int32.Parse(threeOperandTest.Groups["Op3"].Value);

                return ParseEquationOperator(twoOperandResult, operand3, op2);
            }

            var twoOperandTest = Regex.Match(question, @"What is (?<Op1>-?\d+) (?<Operator>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+)\?");
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
        switch (op)
        {
            case "divided by":
                return operand1 / operand2;
            case "plus":
                return operand1 + operand2;
            case "multiplied by":
                return operand1 * operand2;
            case "minus":
                return operand1 - operand2;
            default:
                throw new ArgumentException();
        }
    }
}