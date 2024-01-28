export function score(x: number, y: number): number {
  var distanceFromCentre = Math.sqrt(Math.abs(x) ** 2 + Math.abs(y) ** 2);

  if (distanceFromCentre > 10) return 0;
  if (distanceFromCentre > 5) return 1;
  if (distanceFromCentre > 1) return 5;

  return 10;
}
