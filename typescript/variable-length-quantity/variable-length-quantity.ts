export default class VLQ {
  static encode(input: number[]): number[] {
    let source = input[0];
    if (source >= 128) {
      console.log(parseInt(source, 128));
      return [source / 128, source % 128];
    } else {
      return input;
    }
  }

  static decode(input: number[]): number[] {
    return input.length == 0 ? [0] : [0];
  }
}
