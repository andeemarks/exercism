class Triangle(s1: Double, s2: Double, s3: Double) {

    constructor(s1: Int, s2: Int, s3: Int) : this(s1.toDouble(), s2.toDouble(), s3.toDouble())

    val isEquilateral: Boolean
    val isIsosceles: Boolean
    val isScalene: Boolean

    init {
        require(s1 > 0 && s2 > 0 && s3 > 0) {"Some sides are 0-length; %d, %d, %d".format(s1, s2, s3)}
        val sideList = listOf(s1, s2, s3).sorted()
        require(sideList[0] + sideList[1] > sideList[2]) {"Side lengths are too short to describe a triangle; %d, %d, %d".format(s1, s2, s3)}

        val numberOfUniqueSideLengths = sideList.distinct().size
        isEquilateral = numberOfUniqueSideLengths == 1
        isScalene = numberOfUniqueSideLengths == 3
        isIsosceles = numberOfUniqueSideLengths <= 2
    }
}
