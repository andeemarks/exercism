function isConsonant(char: string): boolean {
  return /[aeiou]/.test(char.toLowerCase()) === false;
}

function is2LetterCluster(cluster: string): boolean {
  return /ch|qu|th/.test(cluster.toLowerCase());
}

function is3LetterCluster(cluster: string): boolean {
  return (
    /thr|sch/.test(cluster) ||
    (isConsonant(cluster.charAt(0)) && cluster.substr(1, 2) == "qu")
  );
}

function translateWord(word: string): string {
  let cluster = word.substring(0, 3);
  if (is3LetterCluster(cluster)) {
    return word.substring(3) + cluster + "ay";
  }

  cluster = word.substring(0, 2);
  if (is2LetterCluster(cluster)) {
    return word.substring(2) + cluster + "ay";
  }

  const firstChar = word.charAt(0);
  if (isConsonant(firstChar)) {
    return word.substring(1) + firstChar + "ay";
  }

  return word + "ay";
}

export default class PigLatin {
  static translate(phrase: string): string {
    return phrase
      .split(" ")
      .map((word) => {
        return translateWord(word);
      })
      .join(" ");
  }
}
