package airportrobot

import "fmt"

// Write your code here.
// This exercise does not have tests for each individual task.
// Try to solve all the tasks first before running the tests.

func SayHello(name string, greeter Greeter) string {
	return fmt.Sprintf("I can speak %s: %s!", greeter.LanguageName(), greeter.Greet(name))
}

type Greeter interface {
	LanguageName() string
	Greet(name string) string
}

type Italian struct{}

func (i Italian) Greet(name string) string {
	return fmt.Sprintf("Ciao %s", name)
}

func (i Italian) LanguageName() string {
	return "Italian"
}

type Portuguese struct{}

func (i Portuguese) Greet(name string) string {
	return fmt.Sprintf("Olá %s", name)
}

func (i Portuguese) LanguageName() string {
	return "Portuguese"
}
