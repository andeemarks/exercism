const LAST_LINE =
  "I don't know why she swallowed the fly. Perhaps she'll die.\n";

interface ChainLink {
  byline?: string;
  next?: Food;
  nextLabel?: string;
}

type Food = | "fly" | "spider" | "bird" | "cat" | "dog" | "goat" | "cow" | "horse";

const CHAIN: Map<Food, ChainLink> = new Map([
  ["fly", {}],
  [
    "spider",
    { byline: "It wriggled and jiggled and tickled inside her.", next: "fly" },
  ],
  [
    "bird",
    {
      byline: "How absurd to swallow a bird!",
      next: "spider",
      nextLabel: "spider that wriggled and jiggled and tickled inside her",
    },
  ],
  ["cat", { byline: "Imagine that, to swallow a cat!", next: "bird" }],
  ["dog", { byline: "What a hog, to swallow a dog!", next: "cat" }],
  [
    "goat",
    { byline: "Just opened her throat and swallowed a goat!", next: "dog" },
  ],
  ["cow", { byline: "I don't know how she swallowed a cow!", next: "goat" }],
  ["horse", { byline: "She's dead, of course!" }],
]);

export default class FoodChain {
  private static unwindFoodChain(food: Food, chain: string): string {
    let link = CHAIN.get(food);
    let nextFood = link?.next;
    let nextFoodLabel = link?.nextLabel || nextFood;

    if (nextFood) {
      let foodChain = FoodChain.unwindFoodChain(nextFood, chain);
      return `She swallowed the ${food} to catch the ${nextFoodLabel}.\n${foodChain}`;
    } else {
      return "";
    }
  }

  private static createVerse(food: Food): string {
    let link = CHAIN.get(food);
    let byline = link?.byline ? "\n" + link?.byline + "\n" : "\n";
    let foodChain = FoodChain.unwindFoodChain(food, "");

    return `I know an old lady who swallowed a ${food}.${byline}${foodChain}`;
  }

  static VERSES: string[] = [
    FoodChain.createVerse("fly") + LAST_LINE,
    FoodChain.createVerse("spider") + LAST_LINE,
    FoodChain.createVerse("bird") + LAST_LINE,
    FoodChain.createVerse("cat") + LAST_LINE,
    FoodChain.createVerse("dog") + LAST_LINE,
    FoodChain.createVerse("goat") + LAST_LINE,
    FoodChain.createVerse("cow") + LAST_LINE,
    FoodChain.createVerse("horse"),
  ];

  static verse(i: number): string {
    return this.VERSES[i - 1];
  }

  static verses(from: number, to: number): string {
    return this.VERSES.slice(from - 1, to).join("\n");
  }
}
