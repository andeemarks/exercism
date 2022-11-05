//
// This is only a SKELETON file for the 'Secret Handshake' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const commands = (command) => {
  let handshake = [];
  if (command & 1) handshake.push("wink");
  if (command & 2) handshake.push("double blink");
  if (command & 4) handshake.push("close your eyes");
  if (command & 8) handshake.push("jump");
  if (command >= 16) handshake.reverse();

  return handshake;
};
