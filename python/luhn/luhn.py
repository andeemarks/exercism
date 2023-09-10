class Luhn:
    def __init__(self, card_num):
        self.card_num = card_num

    def valid(self):
        clean_card_num = self.card_num.replace(" ", "")

        if (len(clean_card_num) <= 1):
            return False
        
        try:
            processed_digits = [self.process_digits(i, d) for i, d in enumerate(clean_card_num[::-1])]
        except ValueError:
            return False

        return sum(processed_digits) % 10 == 0

    def process_digits(self, position, digit):
        if (position % 2 == 1):
            return self.double_digit(int(digit))
        else:
            return int(digit)

    def double_digit(self, digit):
        result = 2 * digit

        return result if result <= 9 else result - 9