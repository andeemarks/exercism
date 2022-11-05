// This is only a SKELETON file for the 'Robot Name' exercise. It's been
// provided as a convenience to get your started writing code faster.

export class Robot {
  #name = "";

  get name() {
    return this.#name;
  }

  randomIntFrom0To = (max) => {
    return Math.floor(Math.random() * (max + 1));
  };

  randomChar = () => {
    return "abcdefghijklmnopqrstuvwxyz".charAt(this.randomIntFrom0To(26));
  };

  generateName() {
    return (
      this.randomChar() +
      this.randomChar() +
      this.randomIntFrom0To(9) +
      this.randomIntFrom0To(9) +
      this.randomIntFrom0To(9)
    ).toUpperCase();
  }

  assignName() {
    let potentialName = this.generateName();

    while (Robot.names.has(potentialName)) {
      potentialName = this.generateName();
    }

    this.#name = potentialName;
    Robot.names.add(potentialName);
  }

  constructor() {
    this.assignName();
  }

  reset = () => {
    this.assignName();
  };
}

Robot.names = new Set();

Robot.releaseNames = () => {};
