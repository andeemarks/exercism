using System.IO.Pipelines;
using System.Text.RegularExpressions;

public static class Wordy
{
    public static int Answer(string question)
    {

        try
        {
            var threeOperandTest = Regex.Match(question, @"What is (?<Op1>-?\d+) (?<Operator1>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+) (?<Operator2>\b(divided by|plus|multiplied by|minus)\b) (?<Op3>-?\d+)\?");

            if (threeOperandTest.Success)
            {
                var operand1 = Int32.Parse(threeOperandTest.Groups["Op1"].Value);
                var operand2 = Int32.Parse(threeOperandTest.Groups["Op2"].Value);
                var operand3 = Int32.Parse(threeOperandTest.Groups["Op3"].Value);
                var op1 = threeOperandTest.Groups["Operator1"].Value;
                var op2 = threeOperandTest.Groups["Operator2"].Value;

                var result = ResolveTwoOperandEquation(operand1, operand2, op1);

                return ResolveTwoOperandEquation(result, operand3, op2);
            }

            var twoOperandTest = Regex.Match(question, @"What is (?<Op1>-?\d+) (?<Operator>\b(divided by|plus|multiplied by|minus)\b) (?<Op2>-?\d+)\?");

            if (twoOperandTest.Success)
            {
                var operand1 = Int32.Parse(twoOperandTest.Groups["Op1"].Value);
                var operand2 = Int32.Parse(twoOperandTest.Groups["Op2"].Value);
                var op = twoOperandTest.Groups["Operator"].Value;
                return  ResolveTwoOperandEquation(operand1, operand2, op);
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

    private static int ResolveTwoOperandEquation(int operand1, int operand2, string op)
    {
        if (op == "divided by")
        {
            return operand1 / operand2;
        }
        if (op == "plus")
        {
            return operand1 + operand2;
        }
        if (op == "multiplied by")
        {
            return operand1 * operand2;
        }
        if (op == "minus")
        {
            return operand1 - operand2;
        }

        throw new ArgumentException();
    }
}