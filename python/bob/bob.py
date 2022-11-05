"""docstring"""


def response(hey_bob):
    """docstring"""

    hey_bob = hey_bob.strip()

    if len(hey_bob) == 0:
        return "Fine. Be that way!"

    has_letters = any(filter(lambda letter: letter.isalpha(), hey_bob))
    is_yelled = has_letters & (hey_bob.upper() == hey_bob)
    is_question = hey_bob.endswith("?")

    if is_question:
        if is_yelled:
            return "Calm down, I know what I'm doing!"

        return "Sure."

    if is_yelled:
        return "Whoa, chill out!"

    return "Whatever."
