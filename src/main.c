#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"


/*

 Transforms an RGB image to YCbCr components. The colour saturation issues when doing the inverse
 is due to the loss of information when casting the floating point values to integers. Hopefully this
 issue can be elimated with fixed point arithemtic. The maximum green values seen in the inverse 
 transform is due to the lack of saturation arithmetic The commented code in this function does the 
 inverse transform using the floating point values and it outputs the correct image.

*/
void RGBtoYCC(char* filename)
{
	Image rgb = readImage(filename);
	Image yImage;
	Image cbImage;
	Image crImage;
	//Image inverse;

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

	/*inverse.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	inverse.numPixels = rgb.numPixels;
	inverse.width = rgb.width;
	inverse.height = rgb.height;*/

	int i;
	for(i = 0; i < rgb.numPixels; i++)
	{
		double y = (0.297832031 * rgb.pixels[i].r + 0.584706994 * rgb.pixels[i].g + 0.11355468 * rgb.pixels[i].b);
		yImage.pixels[i].r = y;
		yImage.pixels[i].g = y;
		yImage.pixels[i].b = y;

		double cb = (-0.297833292 * rgb.pixels[i].r - 0.584705764 * rgb.pixels[i].g + 0.882539056 * rgb.pixels[i].b);
		cbImage.pixels[i].r = 0;
		cbImage.pixels[i].g = (cb * 0.194207836);
		cbImage.pixels[i].b = cb;

		double cr = (0.698261648 * rgb.pixels[i].r - 0.584706847 * rgb.pixels[i].g - 0.1135548 * rgb.pixels[i].b);
		crImage.pixels[i].r = cr;
		crImage.pixels[i].g = (cr * 0.509369676);
		crImage.pixels[i].b = 0;

	 	//This code will out put an inverse transform using floating point calclations

		/*double r = y + cr;
		double g = y - (cb * 0.194207836) - (cr * 0.509369676);
		double b = y + cb;
		
		inverse.pixels[i].r = r;
		inverse.pixels[i].g = g;
		inverse.pixels[i].b = b;*/
	}
	
	writeImage("outY.bmp", yImage);
	writeImage("outCb.bmp", cbImage);
	writeImage("outCr.bmp", crImage);
	//writeImage("inverse.bmp", inverse);

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
		rgbImage.pixels[i].r = yImage.pixels[i].r + crImage.pixels[i].r;
		rgbImage.pixels[i].g = yImage.pixels[i].g - cbImage.pixels[i].g - crImage.pixels[i].g;
		rgbImage.pixels[i].b = yImage.pixels[i].b + cbImage.pixels[i].b;
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

