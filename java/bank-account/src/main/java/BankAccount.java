
class BankAccount {

    private int balance = 0;
    private boolean open = false;

    public void open() {
        this.open = true;
    }

    public void close() {
        this.open = false;
    }

    public void deposit(int amount) throws BankAccountActionInvalidException {
        checkAccountIsOpen();
        checkAmountIsNotNegative(amount);

        adjustBalanceBy(amount);
    }

    public int getBalance() throws BankAccountActionInvalidException {
        checkAccountIsOpen();

        return this.balance;
    }

    public void withdraw(int amount) throws BankAccountActionInvalidException {
        checkAccountIsOpen();
        checkAmountIsNotNegative(amount);
        checkBalanceIsPositive();
        checkSufficientFunds(amount);

        adjustBalanceBy(-amount);
    }

    private void adjustBalanceBy(int amount) {
        synchronized (this) {
            this.balance += amount;
        }
    }

    private void checkSufficientFunds(int amount) throws BankAccountActionInvalidException {
        if (this.balance - amount < 0) {
            throw new BankAccountActionInvalidException("Cannot withdraw more money than is currently in the account");
        }
    }

    private void checkBalanceIsPositive() throws BankAccountActionInvalidException {
        if (this.balance <= 0) {
            throw new BankAccountActionInvalidException("Cannot withdraw money from an empty account");
        }
    }

    private void checkAccountIsOpen() throws BankAccountActionInvalidException {
        if (!this.open) {
            throw new BankAccountActionInvalidException("Account closed");
        }
    }

    private void checkAmountIsNotNegative(int amount) throws BankAccountActionInvalidException {
        if (amount < 0) {
            throw new BankAccountActionInvalidException("Cannot deposit or withdraw negative amount");
        }
    }

}