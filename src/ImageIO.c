/*

 This file reads and writes bmp image files.
	
 SENG 440 Project
 July 19th, 2013
 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ImageIO.h"

/*
 Reads pixel data from an image file
 
 filename - The path and name of the file to read from

 return - The image data read from the file
*/
Image readImage(char* filename) {

	FILE* imageFile = fopen(filename, "r");
	Image image;

	// Read in width and height
	fseek(imageFile, WIDTH_OFFSET, SEEK_SET);
	fread(&image.width, sizeof(int), 1, imageFile);
	fread(&image.height, sizeof(int), 1, imageFile);
	image.numPixels = image.width * image.height;

	// Read in the rgb pixel data
	image.pixels = (Pixel*) malloc(sizeof(Pixel) * image.numPixels);
	fseek(imageFile, DATA_OFFSET, SEEK_SET);
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

	char header[] = {'B', 'M', /* Size*/ 0, 0, 0, 0, /*Reserved*/ 0, 0, 0, 0, /*Offset*/ 0x36, 0, 0, 0,
		/*Header*/ 0x28, 0, 0, 0, /*Width*/ 0, 0, 0, 0, /*Height*/ 0, 0, 0, 0, /*Planes*/ 0, 0, 
		/*BitCount*/ 0x18, 0, /*Rest*/ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	
	// Prepare header
	int fileSize = (image.numPixels * 3) + DATA_OFFSET;
	memcpy(&header[SIZE_OFFSET], &fileSize, sizeof(int));
	memcpy(&header[WIDTH_OFFSET], &image.width, sizeof(int));
	memcpy(&header[WIDTH_OFFSET] + sizeof(int), &image.height, sizeof(int));

	// Write header and pixel data to the file
	fwrite(header, sizeof(char), DATA_OFFSET, imageFile);
	fwrite(image.pixels, sizeof(Pixel), image.numPixels, imageFile);
	
	free(image.pixels);
	fclose(imageFile);


}

