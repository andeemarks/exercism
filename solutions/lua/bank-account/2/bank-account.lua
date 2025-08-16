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
    if self.is_open == false then
        error()
    end

    self._balance = 0
    self.is_open = false
end

function BankAccount:balance()
    if self.is_open == false then
        error()
    end

    return self._balance
end

function BankAccount:deposit(amount)
    if self.is_open == false then
        error()
    end

    if amount < 0 then
        error()
    end

    self._balance = self._balance + amount
end

function BankAccount:withdraw(amount)
    if self.is_open == false then
        error()
    end

    if self._balance - amount < 0 or amount < 0 then
        error()
    end

    self._balance = self._balance - amount
end

return BankAccount
