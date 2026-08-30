local BankAccount = {}

function BankAccount:new()
    setmetatable({}, self)
    self.__index = self
    self._balance = 0
    self.is_open = false

    return self
end

function BankAccount:open()
    assert(self.is_open == false, "Already open")

    self.is_open = true
end

function BankAccount:close()
    assert(self.is_open == true, "Not open")

    self._balance = 0
    self.is_open = false
end

function BankAccount:balance()
    assert(self.is_open == true, "Not open")

    return self._balance
end

function BankAccount:deposit(amount)
    assert(self.is_open == true, "Not open")
    assert(amount >= 0)

    self._balance = self._balance + amount
end

function BankAccount:withdraw(amount)
    assert(self.is_open == true, "Not open")
    assert(amount >= 0)
    assert(self._balance - amount >= 0)

    self._balance = self._balance - amount
end

return BankAccount
