"""docstring"""

import re

VALID_Q = re.compile('(What is).*\\?')


def resolve_expression(value1, operator, value2):
    """docstring"""
    clean_operator = operator.strip()
    if clean_operator == 'plus':
        return value1 + value2
    if clean_operator == 'minus':
        return value1 - value2
    if clean_operator == 'multiplied_by':
        return value1 * value2
    if clean_operator == 'divided_by':
        return value1 / value2

    raise TypeError(operator)


def resolve_one_operator_question(value1, operator, value2):
    """docstring"""

    return resolve_expression((int)(value1), operator, (int)(value2))


def resolve_two_operator_question(value1, operator1, value2, operator2, value3):
    """docstring"""
    intermediate = resolve_expression((int)(value1), operator1, (int)(value2))

    return resolve_expression(intermediate, operator2, (int)(value3))


def resolve_identity_expression(value):
    """docstring"""

    return (int)(value)


VALID_OPERATORS = ["plus", "minus", "multiplied_by", "divided_by"]


def normalise_up_question(question):
    """docstring"""
    question = question.lstrip("What is").rstrip("?")
    question = question.replace("divided by", "divided_by")
    question = question.replace("multiplied by", "multiplied_by")

    return question.split()


def answer(question):
    """docstring"""
    matches = VALID_Q.match(question)
    if not matches:
        raise ValueError("unknown operation")

    parts = normalise_up_question(question)

    if len(parts) in [0, 4]:
        raise ValueError("syntax error")

    if len(parts) == 2:
        if parts[1] in VALID_OPERATORS:
            raise ValueError("syntax error")

        raise ValueError("unknown operation")

    try:
        if len(parts) == 1:
            return resolve_identity_expression(parts[0])

        if len(parts) == 3:
            return resolve_one_operator_question(parts[0], parts[1], parts[-1])

        if len(parts) == 5:
            return resolve_two_operator_question(parts[0], parts[1], parts[2], parts[3], parts[-1])

    except:
        raise ValueError("syntax error")

    raise ValueError("syntax error")
