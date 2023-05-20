package speed

type Car struct {
	speed        int
	batteryDrain int
	battery      int
	distance     int
}

// NewCar creates a new remote controlled car with full battery and given specifications.
func NewCar(speed, batteryDrain int) Car {
	return Car{speed: speed, batteryDrain: batteryDrain, battery: 100}
}

type Track struct {
	distance int
}

// NewTrack creates a new track
func NewTrack(distance int) Track {
	return Track{distance: distance}
}

// Drive drives the car one time. If there is not enough battery to drive one more time,
// the car will not move.
func Drive(car Car) Car {
	if sufficientBatteryToDrive(car) {
		car.battery -= car.batteryDrain
		car.distance += car.speed
	}

	return car
}

// CanFinish checks if a car is able to finish a certain track.
func CanFinish(car Car, track Track) bool {
	for (car.distance < track.distance) && sufficientBatteryToDrive(car) {
		car = Drive(car)
	}

	return car.distance >= track.distance
}

func sufficientBatteryToDrive(car Car) bool {
	return car.battery-car.batteryDrain >= 0
}
