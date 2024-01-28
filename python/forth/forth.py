class StackUnderflowError(Exception):
    pass

def assert_min_stack_size(stack, min_size):
    try:
        assert stack
        assert len(stack) >= min_size
    except AssertionError:
        raise StackUnderflowError("Insufficient number of items in stack")

def evaluate(input_data):
    words = {}
    for line in input_data:
        tokens = line.split()
        stack = []
        try:
            for token in tokens:
                stack = process_token(line, words, stack, token.lower())
        except StopIteration:
            pass
    return stack

def process_token(line, words, stack, token):
    if token in words:
        return process_word(stack, token, words)
    
    match token:
        case "+":
            stack = process_addition(stack)
        case "-":
            stack = process_subtraction(stack)
        case "*":
            stack = process_multiplication(stack)
        case "dup":
            stack = process_duplication(stack)
        case "/":
            stack = process_division(stack)
        case "drop":
            stack = process_drop(stack)
        case "over":
            stack = process_over(stack)
        case "swap":
            stack = process_swap(stack)
        case ":":
            words = parse_word(line, words)
            raise StopIteration("Rest of line has been consumed")
        case _:
            stack = process_operand(stack, token)
            
    return stack

def process_operand(stack, operand):
    try:
        stack.append(int(operand))

        return stack
    except ValueError:
        raise ValueError("undefined operation")

def process_word(stack, word, words):
    for token in words[word]:
        stack = process_token("", words, stack, token)

    return stack

def parse_word(line, words):
    _, word, *definition = line.split()
    definition.pop() 
    try:
        int(word)
    except ValueError:
        words[word.lower()] = evaluate_definition(words, definition)

        return words
    
    raise ValueError("illegal operation")

def evaluate_definition(words, definition):
    evaluated_definition = []
    for word in definition:
        word = word.lower()
        if (word in words.keys()):
            evaluated_definition.append(words[word][0])
        else:
            evaluated_definition.append(word)

    return evaluated_definition

def process_addition(stack):
    assert_min_stack_size(stack, 2)

    return [sum(stack)]

def process_subtraction(stack):
    assert_min_stack_size(stack, 2)

    return [stack[0] - stack[1]]

def process_multiplication(stack):
    assert_min_stack_size(stack, 2)

    return [stack[0] * stack[1]]

def process_duplication(stack):
    assert_min_stack_size(stack, 1)

    *rest, last = stack

    return rest + [last, last]

def process_division(stack):
    assert_min_stack_size(stack, 2)
    if stack[1] == 0:
        raise ZeroDivisionError("divide by zero")
    
    return [stack[0] // stack[1]]

def process_swap(stack):
    assert_min_stack_size(stack, 2)

    *rest, second_last, last = stack

    return rest + [last, second_last]

def process_drop(stack):
    assert_min_stack_size(stack, 1)

    *rest, _ = stack

    return rest

def process_over(stack):
    assert_min_stack_size(stack, 2)

    return stack + [stack[-2]]
