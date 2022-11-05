//
// This is only a SKELETON file for the 'Space Age' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const secondsToYears = (seconds, planetaryAdjustment = 1) => {
  const years = seconds / 31557600 / planetaryAdjustment;

  return parseFloat(years.toFixed(2));
};

const planetAdjustments = new Map();

planetAdjustments.set("earth", 1);
planetAdjustments.set("mercury", 0.2408467);
planetAdjustments.set("venus", 0.61519726);
planetAdjustments.set("mars", 1.8808158);
planetAdjustments.set("saturn", 29.447498);
planetAdjustments.set("uranus", 84.016846);
planetAdjustments.set("neptune", 164.79132);
planetAdjustments.set("jupiter", 11.862615);

export const age = (planet, seconds) => {
  const adjustment = planetAdjustments.get(planet);

  return secondsToYears(seconds, adjustment);
};
