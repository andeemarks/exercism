// @ts-check

function arrayToNumber(array) {
  return parseInt(
    array
      .map((i) => {
        return "" + i;
      })
      .join("")
  );
}
/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  let n1 = arrayToNumber(array1);
  let n2 = arrayToNumber(array2);

  return n1 + n2;
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean}  whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  let numberForward = value.toString();
  let numberBackward = numberForward.split("").reverse().join("");

  return numberForward === numberBackward;
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (!input || input.trim() === "") {
    return "Required field";
  }

  let number = Number(input);
  if (Number.isNaN(number) || number === 0) {
    return "Must be a number besides 0";
  }

  return "";
}