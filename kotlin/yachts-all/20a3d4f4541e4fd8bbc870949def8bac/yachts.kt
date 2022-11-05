import YachtCategory.*
object Yacht {

    fun solve(category: YachtCategory, vararg dices: Int): Int {
        var inputdices = dices.toMutableList()
        if(category == YACHT){
            inputdices.removeAll { it != inputdices[0] }
            if(inputdices.size == 5) return 50
            else  return 0
        }else if(category == ONES){
            inputdices.removeAll { it != 1 }
            return inputdices.size*1
        }else if(category == TWOS){
            inputdices.removeAll { it != 2 }
            return inputdices.size*2
        }else if(category == FOURS){
            inputdices.removeAll { it != 4 }
            return inputdices.size*4
        }else if(category == THREES){
            inputdices.removeAll { it != 3 }
            return inputdices.size*3
        }else if(category == FIVES){
            inputdices.removeAll { it != 5}
            return inputdices.size*5
        }else if(category == SIXES){
            inputdices.removeAll { it != 6 }
            return inputdices.size*6
        }else if(category == FULL_HOUSE){
            var dicescount = inputdices.groupingBy { it }.eachCount()
            if(dicescount.keys.size == 2) {
                if ((dicescount[dicescount.keys.toList()[0]] == 3 || dicescount[dicescount.keys.toList()[0]] == 2 ) && (dicescount[dicescount.keys.toList()[1]] == 3 || dicescount[dicescount.keys.toList()[1]] == 2)){
                    return inputdices.sum()
                }else return 0
            }
            else return 0

        }else if(category == FOUR_OF_A_KIND){
            var dicescount = inputdices.groupingBy { it }.eachCount()
            if(dicescount.keys.size == 2 || dicescount.keys.size == 1) {
                if ((dicescount.getOrDefault(dicescount.keys.toList()[0],0) >= 4 || dicescount[dicescount.keys.toList()[0]] == 1 ) && (dicescount.getOrDefault(dicescount.keys.toList().getOrElse(1,{0}),4) == 4 || dicescount[dicescount.keys.toList().getOrElse(1,{1})] == 1)){
                    return dicescount.filterValues { it == dicescount.values.toList().maxBy{it} }.keys.toList()[0]*4
                }else return 0
            }
            else return 0

        }else if(category == LITTLE_STRAIGHT){
            if((1..5).all { inputdices.contains(it) }){
                return 30
            }else return 0
        }else if(category == BIG_STRAIGHT){
            if((2..6).all { inputdices.contains(it) }){
                return 30
            }else return 0
        }else if(category == CHOICE) return inputdices.sum()
        else return 0


    }
}