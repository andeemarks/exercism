const roundTo2Places = (n: number): number => {
  return Math.round(n * 100) / 100;
};

export default class SpaceAge {
  private readonly secondsOnEarth: number;
  private readonly earthYearInSeconds =
    365.25 * // days
    24 * // hours
    60 * // minutes
    60; // seconds

  private readonly orbitalPeriods = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  };

  onPlanet(planetOrbitalPeriod: number): number {
    return roundTo2Places(this.secondsOnEarth / planetOrbitalPeriod);
  }
  onNeptune(): number {
    return this.onPlanet(this.orbitalPeriods.neptune);
  }
  onUranus(): number {
    return this.onPlanet(this.orbitalPeriods.uranus);
  }
  onSaturn(): number {
    return this.onPlanet(this.orbitalPeriods.saturn);
  }
  onJupiter(): number {
    return this.onPlanet(this.orbitalPeriods.jupiter);
  }
  onMars(): number {
    return this.onPlanet(this.orbitalPeriods.mars);
  }
  onVenus(): number {
    return this.onPlanet(this.orbitalPeriods.venus);
  }
  onMercury(): number {
    return this.onPlanet(this.orbitalPeriods.mercury);
  }
  onEarth(): number {
    return this.onPlanet(this.orbitalPeriods.earth);
  }

  constructor(public readonly seconds: number) {
    this.secondsOnEarth = seconds / this.earthYearInSeconds;
  }
}
