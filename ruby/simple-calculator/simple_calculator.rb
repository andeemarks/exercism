class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError 
  end

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation if !(ALLOWED_OPERATIONS.include? operation)

    begin
      dispatch_operation(first_operand, second_operand, operation)
    rescue => e
      raise ArgumentError
    end
  end

  def self.dispatch_operation(op1, op2, operation)
    case operation 
    when "+"
      result = op1 + op2
    when "*"
      result = op1 * op2
    when "/"
      return "Division by zero is not allowed." if op2 == 0

      result = op1 / op2
    end
    
    format_calculation(op1, op2, operation, result)
    
  end

  def self.format_calculation(op1, op2, operation, result)
    "#{op1} #{operation} #{op2} = #{result}"
  end
end
