#include <stdlib.h>
#include <stdio.h>
#include "ImageIO.h"

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

unsigned char intToPixel(int* integer)
{
	if(*integer > 255)
	{
		return 255;
	}
	else if(*integer < 0)
	{
		return 0;
	}
	return *integer;
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

	int k;
	int chromaI;

	int rA;
	int gA;
	int bA;
	
	int rB;
	int gB;
	int bB;
	int yi;
	int yk;
	int cbA;
	int cbGreenIntA;
	int cbB;
	int cbGreenIntB;
	int crA;
	int crGreenIntA;
	int crB;
	int crGreenIntB;


			
	rA = rgb.pixels[0].r;
	gA = rgb.pixels[0].g;
	bA = rgb.pixels[0].b;

	rB = rgb.pixels[1].r;
	gB = rgb.pixels[1].g;
	bB = rgb.pixels[1].b;
	
	// Y values
	yi = ((yRConst * rA + yGConst * gA + yBConst * bA) >> 23) + 16;
	yImage.pixels[0].r = intToPixel(yi);
	yImage.pixels[0].g = intToPixel(yi);
	yImage.pixels[0].b = intToPixel(yi);

	yk = ((yRConst * rB + yGConst * gB + yBConst * bB) >> 23) + 16;
	yImage.pixels[1].r = intToPixel(yk);
	yImage.pixels[1].g = intToPixel(yk);
	yImage.pixels[1].b = intToPixel(yk);
		
	// Cb Values
	cbA = (bA * cbBConst - rA * cbRConst - gA * cbGConstA);
	cbA = cbA >> 24;

	cbGreenIntA = -(cbA * cbGConstB);
	cbGreenIntA = cbGreenIntA >> 23;

	cbB = (bB * cbBConst - rB * cbRConst - gB * cbGConstA);
	cbB = cbB >> 24;

	cbGreenIntB = -(cbB * cbGConstB);
	cbGreenIntB = cbGreenIntB >> 23;
		
	cbImage.pixels[0].r = 0;
	cbImage.pixels[0].g = intToPixel(cbGreenIntA + cbGreenIntB + 128);
	cbImage.pixels[0].b = intToPixel(cbA + cbB + 128);

	// Cr values
	crA = (crRConst * rA - crGConstA * gA - crBConst * bA);
	crA = crA >> 24;
		
	crGreenIntA = -(crA * crGConstB);
	crGreenIntA = crGreenIntA >> 23;

	crB = (crRConst * rB - crGConstA * gB - crBConst * bB);
	crB = crB >> 24;
		
	crGreenIntB = -(crB * crGConstB);
	crGreenIntB = crGreenIntB >> 23;

	crImage.pixels[0].r = intToPixel(crA + crB + 128);
	crImage.pixels[0].g = intToPixel(crGreenIntA + crGreenIntB + 128);
	crImage.pixels[0].b = 0;
	

	int i;
	for(i = 1; i < rgb.numPixels; i += 2)
	{
		k = i + 1;
		chromaI = i >> 1;
			
		rA = rgb.pixels[i].r;
		gA = rgb.pixels[i].g;
		bA = rgb.pixels[i].b;

		rB = rgb.pixels[k].r;
		gB = rgb.pixels[k].g;
		bB = rgb.pixels[k].b;
	
		// Y values
		yi = ((yRConst * rA + yGConst * gA + yBConst * bA) >> 23) + 16;
		yImage.pixels[i].r = intToPixel(yi);
		yImage.pixels[i].g = intToPixel(yi);
		yImage.pixels[i].b = intToPixel(yi);

		yk = ((yRConst * rB + yGConst * gB + yBConst * bB) >> 23) + 16;
		yImage.pixels[k].r = intToPixel(yk);
		yImage.pixels[k].g = intToPixel(yk);
		yImage.pixels[k].b = intToPixel(yk);
		
		// Cb Values
		cbA = (bA * cbBConst - rA * cbRConst - gA * cbGConstA);
		cbA = cbA >> 24;

		cbGreenIntA = -(cbA * cbGConstB);
		cbGreenIntA = cbGreenIntA >> 23;

		cbB = (bB * cbBConst - rB * cbRConst - gB * cbGConstA);
		cbB = cbB >> 24;

		cbGreenIntB = -(cbB * cbGConstB);
		cbGreenIntB = cbGreenIntB >> 23;
		
		cbImage.pixels[chromaI].r = 0;
		cbImage.pixels[chromaI].g = intToPixel(cbGreenIntA + cbGreenIntB + 128);
		cbImage.pixels[chromaI].b = intToPixel(cbA + cbB + 128);

		// Cr values
		crA = (crRConst * rA - crGConstA * gA - crBConst * bA);
		crA = crA >> 24;
		
		crGreenIntA = -(crA * crGConstB);
		crGreenIntA = crGreenIntA >> 23;

		crB = (crRConst * rB - crGConstA * gB - crBConst * bB);
		crB = crB >> 24;
		
		crGreenIntB = -(crB * crGConstB);
		crGreenIntB = crGreenIntB >> 23;

		crImage.pixels[chromaI].r = intToPixel(crA + crB + 128);
		crImage.pixels[chromaI].g = intToPixel(crGreenIntA + crGreenIntB + 128);
		crImage.pixels[chromaI].b = 0;
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
	
	int r;
	int g;
	int b;

	int i;
	for(i = 0; i < yImage.numPixels; i++)
	{
		r = yImage.pixels[i].r + crImage.pixels[i >> 1].r - 128 - 16;
		g = yImage.pixels[i].g + cbImage.pixels[i >> 1].g + crImage.pixels[i >> 1].g - 256 - 16;
		b = yImage.pixels[i].b + cbImage.pixels[i >> 1].b - 128 - 16;

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

