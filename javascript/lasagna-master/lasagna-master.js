/// <reference path="./global.d.ts" />

export function cookingStatus(timeRemaining) {
  if (timeRemaining === 0) return "Lasagna is done.";

  if (!timeRemaining) return "You forgot to set the timer.";

  return "Not done, please wait.";
}

export function preparationTime(layers, timePerLayer) {
  return layers.length * (timePerLayer || 2);
}

function countIngredient(layers, ingredient) {
  return layers.filter((layer) => {
    return layer === ingredient;
  }).length;
}

export function quantities(layers) {
  let noodleCount = countIngredient(layers, "noodles");
  let sauceCount = countIngredient(layers, "sauce");

  return { noodles: noodleCount * 50, sauce: sauceCount * 0.2 };
}

export function scaleRecipe(recipe, servingsNeeded) {
  let DEFAULT_SERVINGS_NEEDED = 2;
  let scale = servingsNeeded / DEFAULT_SERVINGS_NEEDED;

  Object.keys(recipe).map((ingredient) => {
    recipe[ingredient] *= scale;
  });

  return recipe;
}

export function addSecretIngredient(secretIngredients, ingredients) {
  ingredients.push(secretIngredients[secretIngredients.length - 1]);
}
