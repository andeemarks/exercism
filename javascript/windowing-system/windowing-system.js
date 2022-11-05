// @ts-check

/**
 * Implement the classes etc. that are needed to solve the
 * exercise in this file. Do not forget to export the entities
 * you defined so they are available for the tests.
 */
export class Size {
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }

  resize = (/** @type {number} */ width, /** @type {number} */ height) => {
    this.width = width;
    this.height = height;
  };
}

export class Position {
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  move = (/** @type {number} */ x, /** @type {number} */ y) => {
    this.x = x;
    this.y = y;
  };
}

class BoundedValue {
  /**
   * @param {number} value
   */
  constructor(value) {
    this.value = value;
  }

  withLower = (/** @type {number} */ lower) => {
    return new BoundedValue(Math.max(this.value, lower));
  };

  withUpper = (/** @type {number} */ upper) => {
    return new BoundedValue(Math.min(this.value, upper));
  };
}

export class ProgramWindow {
  constructor() {
    this.size = new Size();
    this.position = new Position();
    this.screenSize = new Size(800, 600);
  }

  resize = (/** @type {Size} */ size) => {
    const widthWithinScreen = new BoundedValue(size.width)
      .withLower(1)
      .withUpper(this.screenSize.width - this.position.x).value;
    const heightWithinScreen = new BoundedValue(size.height)
      .withLower(1)
      .withUpper(this.screenSize.height - this.position.y).value;

    this.size = new Size(widthWithinScreen, heightWithinScreen);
  };

  move = (/** @type {Position} */ position) => {
    const xWithinScreen = new BoundedValue(position.x)
      .withLower(0)
      .withUpper(this.screenSize.width - this.size.width).value;
    const yWithinScreen = new BoundedValue(position.y)
      .withLower(0)
      .withUpper(this.screenSize.height - this.size.height).value;
    this.position = new Position(xWithinScreen, yWithinScreen);
  };
}

export function changeWindow(window) {
  window.size = new Size(400, 300);
  window.position = new Position(100, 150);

  return window;
}
