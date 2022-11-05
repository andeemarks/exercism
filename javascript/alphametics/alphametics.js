const possibleValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].reverse();

export const solve = (puzzle) => {
  try {
    const precomputedValues = precomputeValues(puzzle);
    const expression = simplifyExpression(puzzle, precomputedValues);
    const letters = extractUniqueLetters(expression);
    const remainingValues = possibleValues.filter((value) => {
      return !Object.values(precomputedValues).includes(value);
    });
    const validValues = findValuesForLetters(
      expression,
      letters,
      remainingValues
    );

    return assocValuesToLetters(letters, validValues, precomputedValues);
  } catch (e) {
    return null;
  }

  // const arr = [];
  // arr.push("Hello");
};

const findValuesForLetters = (puzzle, letters, possibleValues) => {
  const valueCache = permute(possibleValues);
  for (let x = 0; x < valueCache.length; x++) {
    if (testExpression(puzzle, letters, valueCache[x])) {
      console.log(`Solved ${puzzle} in ${x} tries`);

      return valueCache[x].slice(0, letters.length);
    }
  }

  throw new Error("exhausted all values");
};

const isValidExpression = (expression) => {
  const validExpressionRegex = new RegExp("(^|[^0-9])0+", "g");
  return !validExpressionRegex.test(expression);
};

const extractUniqueLetters = (puzzle) => {
  const parts = puzzle.match(/[A-Za-z]/g);

  return [...new Set(parts)];
};

const precomputeValues = (puzzle) => {
  const parts = puzzle.match(/(?<lhs>.+) == (?<rhs>\w+)/).groups;
  const lhsLetters = parts["lhs"].split(" + ");
  const rhsLetters = parts["rhs"];
  const lhsWordsByLength = lhsLetters.sort((w1, w2) => w2.length - w1.length);
  const biggestLHSWord = lhsWordsByLength[0];

  if (rhsLetters.length < biggestLHSWord.length) {
    throw new Error("impossible to solve - rhs too small");
  }

  if (lhsLetters.length === 1 && lhsLetters[0] != rhsLetters) {
    throw new Error("impossible to solve - values are not unique");
  }

  const precomputedValues = {};
  if (rhsLetters.length > biggestLHSWord.length) {
    precomputedValues[rhsLetters[0]] = 1;
    precomputedValues[rhsLetters[1]] = 0;
  }

  return precomputedValues;
};

const simplifyExpression = (puzzle, precomputedValues) => {
  for (const value in precomputedValues) {
    puzzle = puzzle.replaceAll(value, precomputedValues[value]);
  }

  return puzzle;
};

const testExpression = (puzzle, letters, values) => {
  const expression = buildExpression(puzzle, letters, values);
  if (isValidExpression(expression)) {
    return eval(expression);
  }
};

const permute = (nums) => {
  var result = [];

  var backtrack = (i, nums) => {
    if (i === nums.length) {
      result.push(nums.slice());

      return;
    }

    for (let j = i; j < nums.length; j++) {
      [nums[i], nums[j]] = [nums[j], nums[i]];

      backtrack(i + 1, nums);

      [nums[i], nums[j]] = [nums[j], nums[i]];
    }
  };

  backtrack(0, nums);

  return result;
};

const assocValuesToLetters = (letters, values, precomputedValues) => {
  let assoc = {};
  letters.forEach((letter, index) => {
    assoc[letter] = parseInt(values[index]);
  });

  return { ...assoc, ...precomputedValues };
};

const buildExpression = (puzzle, letters, values) => {
  let expression = puzzle;
  let substitutionIndex = 0;

  letters.forEach((letter) => {
    expression = expression.replaceAll(letter, values[substitutionIndex++]);
  });

  return expression;
};
