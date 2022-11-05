// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines how long it takes to prepare a certain juice.
 *
 * @param {string} name
 * @returns {number} time in minutes
 */
export function timeToMixJuice(name) {
  switch (name) {
    case "Pure Strawberry Joy":
      return 0.5;
    case "Energizer":
      return 1.5;
    case "Green Garden":
      return 1.5;
    case "Tropical Island":
      return 3;
    case "All or Nothing":
      return 5;
    default:
      return 2.5;
  }
}

function wedgesForLimeSize(limeSize) {
  return limeSize == "small" ? 6 : limeSize == "medium" ? 8 : 10;
}
/**
 * Calculates the number of limes that need to be cut
 * to reach a certain supply.
 *
 * @param {number} wedgesNeeded
 * @param {string[]} limes
 * @returns {number} number of limes cut
 */
export function limesToCut(wedgesNeeded, limes) {
  let limesProcessed = 0;
  let wedgesCut = 0;

  if (wedgesNeeded == 0) return 0;

  while (limesProcessed < limes.length) {
    wedgesCut += wedgesForLimeSize(limes[limesProcessed++]);
    if (wedgesCut >= wedgesNeeded) {
      return limesProcessed;
    }
  }

  return limes.length;
}

/**
 * Determines which juices still need to be prepared after the end of the shift.
 *
 * @param {number} timeLeft
 * @param {string[]} orders
 * @returns {string[]} remaining orders after the time is up
 */
export function remainingOrders(timeLeft, orders) {
  for (let timeToPrepare = 0, i = 0; i < orders.length; i++) {
    timeToPrepare += timeToMixJuice(orders[i]);
    if (timeToPrepare >= timeLeft) {
      return orders.slice(i + 1);
    }
  }

  return [];
}
