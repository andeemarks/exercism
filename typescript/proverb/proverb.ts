export default Proverb;

function Proverb(...consequences: any[]): string {
  const lines = addlines([], consequences);
  lines.push(`And all for the want of a ${consequences[0]}.`);

  return lines.join("\n");
}

function addlines(lines: Array<string>, items: Array<string>) {
  if (items[1]) {
    lines.push(`For want of a ${items[0]} the ${items[1]} was lost.`);

    addlines(lines, items.slice(1));
  }
  return lines;
}
