type MatrixData = number[][];

class Matrix {
  public rows: MatrixData;
  public columns: MatrixData;

  constructor(readonly matrixSpec: string) {
    this.rows = this.matrixSpecToMatrix(matrixSpec.split("\n"));
    this.columns = this.rotateMatrix(this.rows);
  }

  rotateMatrix(matrix: MatrixData): MatrixData {
    let rotatedMatrix: MatrixData = [[]];

    for (let i = 0; i < matrix[0].length; i++) {
      rotatedMatrix[i] = matrix.map((row: number[]) => {
        return row[i];
      });
    }

    return rotatedMatrix;
  }

  matrixSpecToMatrix(rawRows: string[]): MatrixData {
    let matrix: MatrixData = [[]];

    rawRows.forEach((row: string, i: number) => {
      matrix[i] = row.split(" ").map((element: string) => {
        return Number(element);
      });
    });

    return matrix;
  }
}

export default Matrix;
