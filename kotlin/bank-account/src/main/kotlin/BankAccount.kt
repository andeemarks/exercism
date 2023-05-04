class BankAccount {
    private var isClosed: Boolean = false

    var balance: Long = 0
        get() {
            check(!isClosed)
            return field
        }

    @Synchronized fun adjustBalance(amount: Long){
        this.balance += amount
    }

    fun close() {
        this.isClosed = true
    }
}
