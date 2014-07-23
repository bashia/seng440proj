#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "ImageIO.h"
#include "matrixMult.h"

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
