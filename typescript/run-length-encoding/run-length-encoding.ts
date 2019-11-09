class RunLengthEncoding {
  static encode(input: string): string {
    let encodedInput: string = input;

    encodedInput = encodeCharRange("A", "Z", encodedInput);
    encodedInput = encodeCharRange("a", "z", encodedInput);
    encodedInput = encodeCharRange(" ", " ", encodedInput);

    return encodedInput;
  }

  static decode(input: string): string {
    let decodedInput: string = input;

    decodedInput = decodeCharRange("A", "Z", decodedInput);
    decodedInput = decodeCharRange("a", "z", decodedInput);
    decodedInput = decodeCharRange(" ", " ", decodedInput);

    return decodedInput;
  }
}

function decodeCharRange(start: string, end: string, source: string): string {
  for (let i = start.charCodeAt(0); i <= end.charCodeAt(0); i++) {
    const re = new RegExp(`([0-9]+)(${String.fromCharCode(i)}+)`, "g");
    source = source.replace(re, decoder);
  }

  return source;
}

function encodeCharRange(start: string, end: string, source: string): string {
  for (let i = start.charCodeAt(0); i <= end.charCodeAt(0); i++) {
    const char = String.fromCharCode(i);
    const re = new RegExp(`(${char})([${char}]+)`, "g");
    source = source.replace(re, encoder);
  }

  return source;
}

function decoder(_match: string, runLength: number, letter: string): string {
  return letter.repeat(runLength);
}

function encoder(_match: string, letter: string, run: string): string {
  return (run.length + 1) + letter;
}

export default RunLengthEncoding;
