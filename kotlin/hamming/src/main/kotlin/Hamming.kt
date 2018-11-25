import java.lang.IllegalArgumentException

class Hamming {
    companion object {
        fun compute(s1: String, s2: String): Int {
            require(s1.length == s2.length) { "left and right strands must be of equal length." }

            return s1.zip(s2).filter { pair -> pair.first != pair.second }.size
        }
    }
}
