/*
 * matrixMult.h
 *
 *  Created on: Jul 17, 2014
 *      Author: darius
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct Vector Vector;
struct Vector
{
	int r;
	int g;
	int b;
};

typedef struct Matrix Matrix;
struct Matrix
{
	int members[3][3];
};

//absAdd does an absorbing arithmetic addition, never overflowing the bounds given
//with its return value.

//TODO: determine if floats are needed, maybe replace upper and lower with a constant
int absAdd(int a, int b, int lower, int upper)
{
	int sum = a + b;

	if (sum < lower)
	{
		return lower;
	}
	if (sum>upper)
	{
		return upper;
	}
	else
	{
		return sum;
	}
}
//absMult does an absorbing arithmetic multiplication, never overflowing the bounds given
//with its return value.

//TODO: determine if floats are needed, maybe replace upper and lower with a constant
int absMult(int a, int b, int lower, int upper)
{
	int product = a * b;

		if (product < lower)
		{
			return lower;
		}
		if (product>upper)
		{
			return upper;
		}
		else
		{
			return product;
		}
}


//VectbyMat takes an input vector and an input matrix to put their product into
//the address pointed at by the third argument.

//TODO: integrate absorbing arithmetic to the calculations.
int VectbyMat(Vector in, Matrix matrix, Vector * out)
{
	out->r = matrix[0][0] * in.r + matrix[1][0] * in.g + matrix[2][0] * in.b;
	out->g = matrix[0][1] * in.r + matrix[1][1] * in.g + matrix[2][1] * in.b;
	out->b = matrix[0][2] * in.r + matrix[1][2] * in.g + matrix[2][2] * in.b;
	return 0;
}
