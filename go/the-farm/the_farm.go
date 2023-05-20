package thefarm

import (
	"errors"
	"fmt"
)

// See types.go for the types defined for this exercise.

// TODO: Define the SillyNephewError type here.
type SillyNephewError struct {
	cowCount int
}

func (e *SillyNephewError) Error() string {
	return fmt.Sprintf("silly nephew, there cannot be %d cows", e.cowCount)
}

// DivideFood computes the fodder amount per cow for the given cows.
func DivideFood(weightFodder WeightFodder, cows int) (float64, error) {
	amount, error := weightFodder.FodderAmount()

	switch error {
	case ErrScaleMalfunction:
		if amount >= 0 {
			return (amount * 2) / float64(cows), nil
		} else {
			return 0.0, errors.New("negative fodder")

		}
	case nil:
		if amount < 0 {
			return 0.0, errors.New("negative fodder")
		}

		if cows > 0 {
			return amount / float64(cows), nil
		} else if cows < 0 {
			return 0, &SillyNephewError{cows}
		} else {
			return 0.0, errors.New("division by zero")
		}

	default:
		if amount < 0 {
			return 0.0, errors.New("non-scale error")
		} else {
			return 0, error
		}

	}

}
