class BeerSong {
    companion object {
        fun verses(start: Int, end: Int): String {
            var song = emptyList<String>()
            for (i in start downTo end) {
                song = when (i) {
                    0 -> song.plus("No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n")
                    2 -> song.plus("2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n")
                    else -> song.plus(genericVerse(i))
                }
            }

            return song.joinToString("\n")
        }

        private fun genericVerse(start: Int): String {
            return if (start > 1) {
                "%d bottles of beer on the wall, %d bottles of beer.\nTake one down and pass it around, %s bottles of beer on the wall.\n".format(start, start, (start - 1))
            } else {
                "%d bottle of beer on the wall, %d bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n".format(start, start)
            }

        }
    }
}
