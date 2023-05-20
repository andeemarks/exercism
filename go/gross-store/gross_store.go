package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	units := map[string]int{
		"quarter_of_a_dozen": 3,
		"half_of_a_dozen":    6,
		"dozen":              12,
		"small_gross":        120,
		"gross":              144,
		"great_gross":        1728,
	}
	return units
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	return map[string]int{}
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	foundUnit, exists := units[unit]

	if !exists {
		return false
	}

	bill[item] = bill[item] + foundUnit
	return true
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	foundItem, itemExists := bill[item]
	foundUnit, unitExists := units[unit]

	switch {
	case !itemExists, !unitExists:
		return false
	case foundItem-foundUnit == 0:
		delete(bill, item)
		return true
	case foundItem-foundUnit < 0:
		return false
	default:
		bill[item] -= foundUnit
		return true
	}
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	foundItem, itemExists := bill[item]

	return foundItem, itemExists
}
