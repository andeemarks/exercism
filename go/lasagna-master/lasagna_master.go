package lasagna

const preparationTimePerLayer = 2
const noodleQuantityPerLayer = 50
const sauceQuantityPerLayer float64 = 0.2

// TODO: define the 'PreparationTime()' function
func PreparationTime(layers []string, timePerLayer int) int {
	if timePerLayer == 0 {
		timePerLayer = preparationTimePerLayer
	}

	return len(layers) * timePerLayer

}

// TODO: define the 'Quantities()' function
func Quantities(layers []string) (noodleQuantity int, sauceQuantity float64) {
	for i := 0; i < len(layers); i++ {
		switch layers[i] {
		case "noodles":
			noodleQuantity += noodleQuantityPerLayer
		case "sauce":
			sauceQuantity += sauceQuantityPerLayer
		}
	}

	return noodleQuantity, float64(sauceQuantity)

}

// TODO: define the 'AddSecretIngredient()' function
func AddSecretIngredient(friendsList []string, myList []string) {
	myList[len(myList)-1] = friendsList[len(friendsList)-1]
}

// TODO: define the 'ScaleRecipe()' function
func ScaleRecipe(quantitiesForTwoPortions []float64, numberOfPortions int) []float64 {
	scaleFactor := float64(numberOfPortions) / 2.0
	scaledQuantities := []float64{}

	for i := 0; i < len(quantitiesForTwoPortions); i++ {
		scaledQuantities = append(scaledQuantities, quantitiesForTwoPortions[i]*float64(scaleFactor))
	}

	return scaledQuantities
}
