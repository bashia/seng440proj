#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"

void transformInverse(char* yFileName, char* cbFileName, char * crFileName)
{
	Image yImage = readImage(yFileName);
	Image cbImage = readImage(cbFileName);
	Image crImage = readImage(crFileName);
	Image rgbImage;

	rgbImage.pixels = (Pixel*) malloc(sizeof(Pixel) * rgbImage.numPixels);
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
	
	writeImage("out.bmp", rgbImage);
}


void transformForward(char* filename)
{
	Image rgb = readImage(filename);
	Image yImage;
	Image cbImage;
	Image crImage;
	Image inverse;

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

	inverse.pixels = (Pixel*) malloc(sizeof(Pixel) * rgb.numPixels);
	inverse.numPixels = rgb.numPixels;
	inverse.width = rgb.width;
	inverse.height = rgb.height;
	
	int i;
	for(i = 0; i < rgb.numPixels; i++)
	{
		// 0.004548373
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

		/*double r = y + cr;
		double g = y - (cb * 0.194207836) - (cr * 0.509369676);
		double b = y + cb;
		
		inverse.pixels[i].r = yImage.pixels[i].r + crImage.pixels[i].r;
		inverse.pixels[i].g = yImage.pixels[i].g - crImage.pixels[i].g - cbImage.pixels[i].g;
		inverse.pixels[i].b = yImage.pixels[i].r + cbImage.pixels[i].b;*/	

		
		//printf("y: %f, cr: %f\n", y, cr);
		//printf("Inverse red: %d\n", inverse.pixels[i].r);
		//printf("Full red: %f\n", r);
	}

	writeImage("outY.bmp", yImage);
	writeImage("outCb.bmp", cbImage);
	writeImage("outCr.bmp", crImage);
	//writeImage("inverse.bmp", inverse);
}


// type mismatch- I'll fix this later.
int pixelTransform(Pixel in, Pixel* out)
{
	out->y = 16 + (65.481*in.r + 128.553*in.g + 24.966*in.b);
	out->cb = 128 + (-37.797*in.r - 74.203*in.g + 112*in.b);
	out->cr = 128 + (112*in.r - 93.786*in.g - 18.214*in.b);
	return 0;
}

int YCCCompstoRGB(Pixel iny, Pixel incb, Pixel incr, Pixel* out)
{
	return 0;
}

int RGBtoYCC(char* filename)
{
	char* inpath = filename;
	char* outpathy = malloc(sizeof(char*)*strlen(inpath)+1);
	char* outpathcb = malloc(sizeof(char*)*strlen(inpath)+2);
	char* outpathcr = malloc(sizeof(char*)*strlen(inpath)+2);
	outpathy = strcat(inpath,"y");
	outpathcb = strcat(inpath,"cb");
	outpathcr = strcat(inpath,"cr");
	//Declaring the input image, transformation matrix...
	Image inimage;
	Image outimagey;
	Image outimagecb;
	Image outimagecr;
	Matrix transmat;

	inimage = readImage(inpath);

	int i;
	for(i=0;i<inimage.numPixels;i++)
	{
		pixelTransform(inimage.pixels[i],&outimage.pixels[i]);
		// Once for each component YCC image
		// 
	}

	//writeImage- I'll figure this out later
	// write RGB approximation of YCC components (each in an Image struct) to the new filenames

	free(outpathy);
	free(outpathcb);
	free(outpathcr);

	return 0;
}

int YCCtoRGB(char* yfile, char* cbfile, char* crfile)
{
	char* outpath = "YccOutput";
	char* inpathy = yfile;
	char* inpathcb = cbfile;
	char* inpathcr = crfile;

	Image outimage;
	Image inimagey;
	Image inimagecb;
	Image inimagecr;
	Matrix transmat;
	inimagey = readImage(inpathy);
	inimagecb = readImage(inpathcb);
	inimagecr = readImage(inpathcr);

	int i;
	for(i=0;i<inimagey.numPixels;i++) //Is the size of the luminance component the size of the RGB image?
	{
		Pixel tempPixel;

		YCCCompstoRGB(inimagey.pixels[i],inimagecb.pixels[i],inimagecr.pixels[i],&outimage.pixels[i])
	}

	//writeImage- I'll figure this out later
	// write RGB Image to file

	return 0;
}

int main(int argc, char* argv[])
{

	if((argc != 2))
	{
		printf("Bad argument format.\n");
		return -1;
	}
	else if (argc==3)
	{
		printf("YCC to RGB...\n");
		YCCtoRGB(argv[1],argv[2],argv[3]);
		return 0
	}
	else
	{
		printf("RGBto YCC...\n");
		RGBtoYCC(argv[1]);
		return 0;
	}

	//Setting up outpaths, saving inpath...

}
