# pylint: disable=C0116,C0114,C0115
from datetime import datetime
from abc import ABC,abstractmethod

class Ledger:
    def __init__(self, entries):
        self.entries = entries

    def sort(self):
        return sorted(self.entries,
                        key=lambda entry: (entry.date, entry.change, entry.description))

class LedgerEntry():
    def __init__(self, date, description, change):
        self.date = date
        self.description = description
        self.change = change


    def format_description(self):
        if len(self.description) > 25:
            return f"{self.description[0:22]}..."

        return  str.ljust(self.description, 25)

class LedgerPrinter(ABC):
    def __init__(self, locale, currency):
        self.locale = locale
        self.currency = currency
        self.result = ''

    currency_delimiters = {'USD': '$', 'EUR': '€'}

    def output(self):
        return self.result

    def add_entry(self, entry):
        self.result += f'\n{self.format_date(entry.date)} | {entry.format_description()} | '
        self.result += self.format_change(entry.change)

    @abstractmethod
    def format_change(self, change):
        pass

    @abstractmethod
    def add_header(self):
        pass

    def generate_header(self, header_info):
        header = str.ljust(header_info['col1'], 11)
        header += f"| {str.ljust(header_info['col2'], 26)}"
        header += f"| {str.ljust(header_info['col3'], 13)}"

        return header

    @abstractmethod
    def format_date(self, date):
        pass

    def format_year(self, date):
        return zero_pad_field_to_width(str(date.year), 4)

    def format_month(self, date):
        return zero_pad_field_to_width(str(date.month), 2)

    def format_day(self, date):
        return zero_pad_field_to_width(str(date.day), 2)

    def chunk_change_by_thousands(self, change):
        change_euro = abs(int(change / 100.0))
        groups_of_thousands = []
        while change_euro > 0:
            groups_of_thousands.insert(0, str(change_euro % 1000))
            change_euro = change_euro // 1000

        return groups_of_thousands

    def handle_groups_of_thousands(self, change, delimiter):
        groups_of_thousands = self.chunk_change_by_thousands(change)
        if len(groups_of_thousands) == 0:
            return '0'

        return delimiter.join(groups_of_thousands)

    def handle_cents(self, change):
        change_cents = abs(change) % 100

        return zero_pad_field_to_width(str(change_cents), 2)

class ENLedgerPrinter(LedgerPrinter):
    def __init__(self, currency):
        super().__init__("en_US", currency)

    def add_header(self):
        self.result += self.generate_header({'col1': 'Date',
                              'col2': 'Description', 
                              'col3': 'Change'})

    def format_date(self, date):
        return f"{self.format_month(date)}/{self.format_day(date)}/{self.format_year(date)}"

    def format_change(self, change):
        change_str = ''
        if change < 0:
            change_str += '('
        change_str += self.currency_delimiters[self.currency]
        change_str += self.handle_groups_of_thousands(change, ',')
        change_str += '.'
        change_str += self.handle_cents(change)
        if change < 0:
            change_str += ')'
        else:
            change_str += ' '

        return str.rjust(change_str, 13)

class NLLedgerPrinter(LedgerPrinter):
    def __init__(self, currency):
        super().__init__("nl_NL", currency)

    def add_header(self):
        self.result += self.generate_header({'col1': 'Datum',
                              'col2': 'Omschrijving', 
                              'col3': 'Verandering'})        

    def format_date(self, date):
        return f"{self.format_day(date)}-{self.format_month(date)}-{self.format_year(date)}"

    def format_change(self, change):
        change_str = f'{self.currency_delimiters[self.currency]} '
        if change < 0:
            change_str += '-'
        change_str += self.handle_groups_of_thousands(change, '.')
        change_str += ','
        change_str += self.handle_cents(change)
        change_str += ' '

        return str.rjust(change_str, 13)

def create_entry(date, description, change):
    return LedgerEntry(datetime.strptime(date, '%Y-%m-%d'), description, change)


def format_entries(currency, locale, entries):
    if locale == 'en_US':
        printer = ENLedgerPrinter(currency)
    if locale == 'nl_NL':
        printer = NLLedgerPrinter(currency)

    printer.add_header()

    ledger = Ledger(entries)
    for entry in ledger.sort():
        printer.add_entry(entry)

    return printer.output()

def zero_pad_field_to_width(field, width):
    if len(field) < width:
        field = '0' + field

    return field
