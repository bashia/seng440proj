/*

 This file reads and writes bmp image files.
	
 SENG 440 Project
 July 19th, 2013
 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ImageIO.h"

unsigned char headers[DATA_OFFSET];

/*
 Reads pixel data from an image file
 
 filename - The path and name of the file to read from

 return - The image data read from the file
*/
Image readImage(char* filename) {

	FILE* imageFile = fopen(filename, "r");
	Image image;
	int width;
	int height;

	// Read in the file header and determine the width and height
	fread(&headers, DATA_OFFSET, sizeof(char), imageFile);
	memcpy(&width, &headers[WIDTH_OFFSET], sizeof(int));
	memcpy(&height, &headers[WIDTH_OFFSET + sizeof(int)], sizeof(int));
	image.numPixels = width * height;

	// Read in the rgb pixel data
	image.pixels = (Pixel*) malloc(sizeof(Pixel) * image.numPixels);
	fread(image.pixels, sizeof(Pixel), image.numPixels, imageFile);

	fclose(imageFile);

	return image;
}

/*
 Writes pixel data to an image file
 
 filename - The path and name of the file to write to 
 image - The image data to write to the file
*/
void writeImage(char* filename, Image image)
{
	FILE* imageFile = fopen(filename, "w");

	// Write header and pixel data to the file
	fwrite(headers, sizeof(char), DATA_OFFSET, imageFile);
	fwrite(image.pixels, sizeof(Pixel), image.numPixels, imageFile);
	
	free(image.pixels);
	fclose(imageFile);
}

