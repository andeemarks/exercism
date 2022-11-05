// @ts-check

import { count } from "console";

/**
 * Determine how many cards of a certain type there are in the deck
 *
 * @param {number[]} stack
 * @param {number} card
 *
 * @returns {number} number of cards of a single type there are in the deck
 */
export function cardTypeCheck(stack, card) {
  let countOfCard = 0;
  stack.forEach((current) => {
    if (current == card) countOfCard++;
  });

  return countOfCard;
}

/**
 * Determine how many cards are odd or even
 *
 * @param {number[]} stack
 * @param {boolean} type the type of value to check for - odd or even
 * @returns {number} number of cards that are either odd or even (depending on `type`)
 */
export function determineOddEvenCards(stack, isCountingEven) {
  let countOfType = 0;
  let expectedModRemainder = isCountingEven ? 0 : 1;
  stack.forEach((current) => {
    if (current % 2 == expectedModRemainder) countOfType++;
  });

  return countOfType;
}
