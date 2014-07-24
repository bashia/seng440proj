#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"

<<<<<<< HEAD
unsigned char intToPixel(int integer)
{
	if(integer > 255)
	{
		return 255;
	}
	else if(integer < 0)
	{
		return 0;
	}
	return integer;
}
=======
>>>>>>> 50c07f0a43da2d958855297d40de7c6698053d62

/*
 Transforms an RGB image to YCbCr components. 
*/
void RGBtoYCC(char* filename)
{	
	int yRConst = 2498396;
	int yGConst = 4904878;
	int yBConst = 952566;

	int cbRConst = 2498407;
	int cbGConstA = 4904867;
	int cbGConstB = 1437774;
	int cbBConst = 7403274;

	int crRConst =  5857443;
	int crGConstA = 4904877;
	int crGConstB = 4272902;
	int crBConst =   952567;

	Image rgb = readImage(filename);
	Image yImage;
	Image cbImage;
	Image crImage;

	yImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	yImage.numPixels = rgb.numPixels;
	yImage.width = rgb.width;
	yImage.height = rgb.height;

	cbImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	cbImage.numPixels = rgb.numPixels;
	cbImage.width = rgb.width;
	cbImage.height = rgb.height;
		
	crImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	crImage.numPixels = rgb.numPixels;
	crImage.width = rgb.width;
	crImage.height = rgb.height;

	int i;
	for(i = 0; i < rgb.numPixels; i++)
	{
		int r = rgb.pixels[i].r;
		int g = rgb.pixels[i].g;
		int b = rgb.pixels[i].b;
	
		// Y values
		int y = ((yRConst * r + yGConst * g + yBConst * b) >> 23) + 16;
	
		yImage.pixels[i].r = intToPixel(y);
		yImage.pixels[i].g = intToPixel(y);
		yImage.pixels[i].b = intToPixel(y);
	
		// Cb Values
		int cb = (b * cbBConst - r * cbRConst - g * cbGConstA);
		cb = cb >> 23;

		int cbGreenInt = -(cb * cbGConstB);
		cbGreenInt = cbGreenInt >> 23;
		cbGreenInt += 128;
		int cbBlueInt = cb + 128;
		
		cbImage.pixels[i].r = 0;
		cbImage.pixels[i].g = intToPixel(cbGreenInt);
		cbImage.pixels[i].b = intToPixel(cbBlueInt);

		// Cr values
		int cr = (crRConst * r - crGConstA * g - crBConst * b);
		cr = cr >> 23;
		
		int crGreenInt = -(cr * crGConstB);
		crGreenInt = crGreenInt >> 23;
		crGreenInt += 128;
		int crRedInt = cr + 128;
	
		crImage.pixels[i].r = intToPixel(crRedInt);
		crImage.pixels[i].g = intToPixel(crGreenInt);
		crImage.pixels[i].b = 0;
	}	
	
	writeImage("outY.bmp", yImage);
	writeImage("outCb.bmp", cbImage);
	writeImage("outCr.bmp", crImage);

	free(rgb.pixels);
}

int YCCtoRGB(char* yfile, char* cbfile, char* crfile)
{
	Image yImage = readImage(yfile);
	Image cbImage = readImage(cbfile);
	Image crImage = readImage(crfile);
	Image rgbImage;

	rgbImage.pixels = (Pixel*) malloc(sizeof(Pixel) * yImage.numPixels);
	rgbImage.width = yImage.width;
	rgbImage.height = yImage.height;
	rgbImage.numPixels = yImage.numPixels;
	
	int i;
	for(i = 0; i < yImage.numPixels; i++)
	{

		int r = yImage.pixels[i].r + crImage.pixels[i].r - 128 - 16;
		int g = yImage.pixels[i].g + cbImage.pixels[i].g + crImage.pixels[i].g - 256 - 16;
		int b = yImage.pixels[i].b + cbImage.pixels[i].b - 128 - 16;

		rgbImage.pixels[i].r = intToPixel(r);
		rgbImage.pixels[i].g = intToPixel(g);
		rgbImage.pixels[i].b = intToPixel(b);
	}
	
	writeImage("outRGB.bmp", rgbImage);
	
	free(yImage.pixels);
	free(cbImage.pixels);
	free(crImage.pixels);

	return 0;
}

int main(int argc, char* argv[])
{
	
	if(argc == 2)
	{
		printf("RGB to YCC...\n");
		RGBtoYCC(argv[1]);
	}
	else if (argc == 4)
	{
		printf("YCC to RGB...\n");
		YCCtoRGB(argv[1],argv[2],argv[3]);
	}
	else
	{
		printf("Bad argument format.\n");
	}

	return 0;
}

