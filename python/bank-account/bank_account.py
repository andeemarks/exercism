import threading

class BankAccount:
    def __init__(self):
        self.balance = 0
        self.closed = True
        self.lock = threading.Lock()

    def get_balance(self):
        self.ensure_account_open()
        
        return self.balance

    def open(self):
        if not self.closed:
            raise ValueError("account already open")
        
        self.closed = False
        self.balance = 0

    def deposit(self, amount):
        self.ensure_account_open()
        self.ensure_positive_amount(amount)

        self.lock.acquire()
        self.balance += amount
        self.lock.release()

    def withdraw(self, amount):
        self.ensure_account_open()
        self.ensure_positive_amount(amount)
        
        if (self.balance - amount) < 0:
            raise ValueError("amount must be less than balance")
        
        self.lock.acquire()
        self.balance -= amount
        self.lock.release()

    def close(self):
        self.ensure_account_open()
        self.closed = True

    def ensure_positive_amount(self, amount):
        if (amount < 0):
            raise ValueError("amount must be greater than 0")

    def ensure_account_open(self):
        if self.closed:
            raise ValueError("account not open")
