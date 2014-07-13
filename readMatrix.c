#include <stdio.h>
#include <stdlib.h>

int** readMatrix(FILE* file, int** matrix)
{
int matrixSize;
fscanf(file, "%d", &matrixSize);
printf("Matrix size: %d\n", matrixSize);

matrix = (int **)malloc(matrixSize *  sizeof(int *));

int i;
int j;
for (i = 0; i < matrixSize; i++) {
    matrix[i] = (int *) malloc(sizeof(int) * matrixSize);
  }

for(i = 0; i < matrixSize; i++)
{
for(j = 0; j < matrixSize; j++)
{
int digit;
fscanf(file, " %d", &digit);
matrix[i][j] = digit;
}
}

fclose(file);
printf("Finsihed reading in matrix\n");

return matrix;

}

int main(void)
{
FILE * file = fopen("/home/tenhavej/Matrix.txt", "r");

int** matrix;
matrix = readMatrix(file, matrix);

int i;
int j;
for(i = 0; i < 3; i++)
{
for(j = 0; j < 3; j++)
{
printf("%i ", matrix[i][j]);
}

printf("\n");
}

return 0;
}