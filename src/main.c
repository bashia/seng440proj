#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"

// type mismatch- I'll fix this later.
int pixelTransform(Pixel in, YCCPixel* out)
{
	out->y = 16 + (65.481*in.r + 128.553*in.g + 24.966*in.b);
	out->cb = 128 + (-37.797*in.r - 74.203*in.g + 112*in.b);
	out->cr = 128 + (112*in.r - 93.786*in.g - 18.214*in.b);
	return 0;
}

int main(int argc, char* argv[])
{

	if((argc != 2))
	{
		printf("Bad argument format.\n");
		return -1;
	}

	//Setting up outpaths, saving inpath...
	char* inpath = argv[1];
	char* outpathy = malloc(sizeof(char*)*strlen(inpath)+1);
	char* outpathcb malloc(sizeof(char*)*strlen(inpath)+2);
	char* outpathcr malloc(sizeof(char*)*strlen(inpath)+2);
	outpathy = strcat(inpath,"y");
	outpathcb = strcat(inpath,"cb");
	outpathcr = strcat(inpath,"cr");

	//Declaring the input image, transformation matrix...
	Image inimage;
	YCCImage outimage;
	Matrix transmat;

	inimage = readImage(inpath);

	int i;
	for(i=0;i<inimage.numPixels;i++)
	{
		pixelTransform(inimage.pixels[i],outimage.pixels[i]);
	}

	//writeImage- I'll figure this out tomorrow

	return 0;
}
