#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"


#define yRConst 2498396
#define yGConst 4904878
#define yBConst 952566

#define cbRConst 2498407
#define cbGConstA 4904867
#define cbGConstB 1437774
#define cbBConst 7403274

#define crRConst  5857443
#define crGConstA 4904877
#define crGConstB 4272902
#define crBConst  952567

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

/*
 Transforms an RGB image to YCbCr components. 
*/
void RGBtoYCC(char* filename)
{	
	

	Image rgb = readImage(filename);
	Image yImage;
	Image cbImage;
	Image crImage;

	yImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	yImage.numPixels = rgb.numPixels;
	yImage.width = rgb.width;
	yImage.height = rgb.height;

	cbImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	cbImage.numPixels = (rgb.numPixels >> 1);
	cbImage.width = (rgb.width >> 1);
	cbImage.height = rgb.height;
		
	crImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	crImage.numPixels = (rgb.numPixels >> 1);
	crImage.width = (rgb.width >> 1);
	crImage.height = rgb.height;

	int i;
	for(i = 0; i < rgb.numPixels; i += 2)
	{
		int k = i + 1;
			
		int rA = rgb.pixels[i].r;
		int gA = rgb.pixels[i].g;
		int bA = rgb.pixels[i].b;

		int rB = rgb.pixels[k].r;
		int gB = rgb.pixels[k].g;
		int bB = rgb.pixels[k].b;
	
		// Y values
		int y = ((yRConst * rA + yGConst * gA + yBConst * bA) >> 23) + 16;
		yImage.pixels[i].r = intToPixel(y);
		yImage.pixels[i].g = intToPixel(y);
		yImage.pixels[i].b = intToPixel(y);

		y = ((yRConst * rB + yGConst * gB + yBConst * bB) >> 23) + 16;
		yImage.pixels[k].r = intToPixel(y);
		yImage.pixels[k].g = intToPixel(y);
		yImage.pixels[k].b = intToPixel(y);
		
		// Cb Values
		int cbA = (bA * cbBConst - rA * cbRConst - gA * cbGConstA);
		cbA = cbA >> 23;

		int cbGreenIntA = -(cbA * cbGConstB);
		cbGreenIntA = cbGreenIntA >> 23;
		cbGreenIntA += 128;
		int cbBlueIntA = cbA + 128;

		int cbB = (bB * cbBConst - rB * cbRConst - gB * cbGConstA);
		cbB = cbB >> 23;

		int cbGreenIntB = -(cbB * cbGConstB);
		cbGreenIntB = cbGreenIntB >> 23;
		cbGreenIntB += 128;
		int cbBlueIntB = cbB + 128;
		
		cbImage.pixels[i >> 1].r = 0;
		cbImage.pixels[i >> 1].g = intToPixel((cbGreenIntA + cbGreenIntB) >> 1);
		cbImage.pixels[i >> 1].b = intToPixel((cbBlueIntA + cbBlueIntB) >> 1);

		// Cr values
		int crA = (crRConst * rA - crGConstA * gA - crBConst * bA);
		crA = crA >> 23;
		
		int crGreenIntA = -(crA * crGConstB);
		crGreenIntA = crGreenIntA >> 23;
		crGreenIntA += 128;
		int crRedIntA = crA + 128;

		int crB = (crRConst * rB - crGConstA * gB - crBConst * bB);
		crB = crB >> 23;
		
		int crGreenIntB = -(crB * crGConstB);
		crGreenIntB = crGreenIntB >> 23;
		crGreenIntB += 128;
		int crRedIntB = crB + 128;

		crImage.pixels[i >> 1].r = intToPixel((crRedIntA + crRedIntB) >> 1);
		crImage.pixels[i >> 1].g = intToPixel((crGreenIntA + crGreenIntB) >> 1);
		crImage.pixels[i >> 1].b = 0;
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
		int r = yImage.pixels[i].r + crImage.pixels[i >> 1].r - 128 - 16;
		int g = yImage.pixels[i].g + cbImage.pixels[i >> 1].g + crImage.pixels[i >> 1].g - 256 - 16;
		int b = yImage.pixels[i].b + cbImage.pixels[i >> 1].b - 128 - 16;

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

