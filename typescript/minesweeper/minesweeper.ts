class Minesweeper {
  annotate(board: Array<string>): Array<string> {
    const positions = this.boardToPositions(board);
    // console.log(`"${positions}"`);
    const adjacents = this.adjacentOffsets(board);
    // console.log(adjacents);
    let annotatedBoard: string = positions;
    for (var i = 0; i < positions.length; i++) {
      if (positions[i] == "*") {
        console.log(`Found mine at ${i}`);
        const adjacentPositions = this.mapOffsets(adjacents, i, positions);
        console.log(adjacentPositions);
        adjacentPositions.forEach(adjacentPosition => {
          annotatedBoard = this.rewriteBoard(annotatedBoard, adjacentPosition);
          // console.log(`"${annotatedBoard}"`);
        });
      }
    }
    return this.positionsToBoard(annotatedBoard, (board[0] || []).length);
  }

  boardToPositions(board: Array<string>): string {
    return board.join("");
  }

  positionsToBoard(positions: string, rowLength: number): Array<string> {
    return this.addRowToBoard([], positions, rowLength);
  }

  addRowToBoard(
    board: Array<string>,
    positions: string,
    rowLength: number
  ): Array<string> {
    board.push(positions.substr(0, rowLength));

    if (positions.length <= rowLength) {
      return board;
    }

    return this.addRowToBoard(board, positions.substring(rowLength), rowLength);
  }

  rewriteBoard(board: string, adjacentPosition: number): string {
    let newBoard: string = "";

    if (adjacentPosition > 0) {
      newBoard = newBoard.concat(board.substr(0, adjacentPosition));
    }

    newBoard = newBoard.concat(this.markPosition(board[adjacentPosition]));

    if (adjacentPosition < board.length - 1) {
      newBoard = newBoard.concat(board.substring(adjacentPosition + 1));
    }

    return newBoard;
  }

  markPosition(position: string): string {
    // console.log(`"${position}"`);
    if (position == " ") {
      return "1";
    }
    if (position == "*") {
      return "*";
    }

    return `${+position + 1}`;
  }

  dedupe(offsets: Array<number>): Array<number> {
    return Array.from(new Set(offsets));
  }
  withoutMinePosition(offsets: Array<number>): Array<number> {
    return offsets.filter(offset => offset != 0);
  }
  aroundPosition(offsets: Array<number>, position: number): Array<number> {
    return offsets.map(offset => offset + position);
  }

  trimToBoard(offsets: Array<number>, boardSize: number): Array<number> {
    return offsets.filter(offset => offset >= 0 && offset < boardSize);
  }

  mapOffsets(
    offsets: Array<number>,
    factor: number,
    positions: string
  ): Array<number> {
    return this.trimToBoard(
      this.aroundPosition(
        this.withoutMinePosition(this.dedupe(offsets)),
        factor
      ),
      positions.length
    );
  }

  adjacentOffsets(board: Array<string>): Array<number> {
    const rowWidth = (board[0] || []).length;
    return [
      (rowWidth > 1 ? -1 : 0), // left
      (rowWidth > 2 ? 1 : 0) , // right
      -rowWidth, // top
      rowWidth, // bottom
      -rowWidth - 1, // top left
      -rowWidth + 1, // top right
      rowWidth + 1, // boottom right
      rowWidth - 1 // bottom left
    ];
  }
}

export default Minesweeper;
