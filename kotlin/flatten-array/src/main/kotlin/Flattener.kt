class Flattener {
    companion object {
        fun flatten(list: List<Any?>): List<Any?> {
            val result: MutableList<Any?> = mutableListOf()

            recursiveFlatten(list, result)

            return result.filter { i: Any? -> i != null }
        }

        private fun recursiveFlatten(list: List<Any?>, result: MutableList<Any?>) {
            list.forEach { i ->
                when (i) {
                    !is List<Any?> -> result.add(i)
                    else -> recursiveFlatten(i, result)
                }
            }
        }
    }
}
