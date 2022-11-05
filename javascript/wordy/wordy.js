//
// This is only a SKELETON file for the 'Wordy' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const answer = (question) => {
  try {
    return answerValidQuestion(question);
  } catch (e) {
    handleInvalidQuestion(question);
  }
};

const operandRE = (id = "") => {
  return `(?<operand${id}>-?\\d+)`;
};
const prefixRE = "What is";
const operatorRE = "plus|minus|multiplied by|divided by";

const answerValidQuestion = (question) => {
  const validTwoOperatorRE = new RegExp(
    `${prefixRE} ${operandRE(1)} (?<operator>${operatorRE}) ${operandRE(
      2
    )} (?<operator2>${operatorRE}) ${operandRE(3)}\\?`
  );
  var matches = question.match(validTwoOperatorRE);
  if (matches) {
    return answerTwoOperatorQuestion(matches.groups);
  }

  const validOneOperatorRE = new RegExp(
    `${prefixRE} ${operandRE(1)} (?<operator>${operatorRE}) ${operandRE(2)}\\?`
  );
  var matches = question.match(validOneOperatorRE);
  if (matches) {
    return answerOneOperatorQuestion(matches.groups);
  }

  const validIdentityRE = new RegExp(`${prefixRE} ${operandRE(1)}\\?`);
  var matches = question.match(validIdentityRE);
  if (matches) {
    return answerIdentityQuestion(matches.groups);
  }

  throw new Error("invalid question");
};

function handleInvalidQuestion(question) {
  const invalidOneOperatorRE = new RegExp(
    `${prefixRE} ${operandRE(1)}(.*)${operandRE(2)}\\?`
  );
  var matches = question.match(invalidOneOperatorRE);
  if (matches) {
    throw new Error("Syntax error");
  }

  const unknownOneOperationRE = new RegExp(
    `${prefixRE} ${operandRE()} cubed\\?`
  );
  var matches = question.match(unknownOneOperationRE);
  if (matches) {
    throw new Error("Unknown operation");
  }

  // const invalidIdentityRE = /What is(.*)\?/i;
  const invalidIdentityRE = new RegExp(`${prefixRE}(.*)\\?`);
  var matches = question.match(invalidIdentityRE);
  if (matches) {
    throw new Error("Syntax error");
  }

  throw new Error("Unknown operation");
}

const resolveOneOperatorQuestion = (operand1, operator, operand2) => {
  switch (operator) {
    case "plus":
      return operand1 + operand2;
    case "minus":
      return operand1 - operand2;
    case "multiplied by":
      return operand1 * operand2;
    case "divided by":
      return operand1 / operand2;
  }
};

const answerOneOperatorQuestion = (groups) => {
  const operand1 = Number.parseInt(groups.operand1);
  const operand2 = Number.parseInt(groups.operand2);

  return resolveOneOperatorQuestion(operand1, groups.operator, operand2);
};

const answerTwoOperatorQuestion = (groups) => {
  let firstResult = answerOneOperatorQuestion(groups);

  return resolveOneOperatorQuestion(
    firstResult,
    groups.operator2,
    Number.parseInt(groups.operand3)
  );
};

const answerIdentityQuestion = (groups) => {
  return Number.parseInt(groups.operand1);
};
