******************************************************************************************************************************
SENG 440 Summer 2014 
RGB To YCbCr Conversion

Jeff ten Have
Tony Bashi

******************************************************************************************************************************
Compiling Optimized C and ARM code - 
	
	C Code - To compile the optimized C code use the 'make' command in the root directory. 
	This will generate a binary file in the /bin folder.

	ARM Code - To compile the optimized ARM code use the 'make armc' command in the root directory. 
	This will generate a binary file in the /bin folder.

******************************************************************************************************************************
Running The Executable - 
	
	RGB To YCC - Use the 'qemu-arm bin/colourspace.exe testbench/[IMAGE NAME].jpg' command. This will generate
	three output images in the root directory. outY.bmp is Y component. outCb.bmp is the Cb component. outCr.bmp 
	is Cr component. To view any of these images with the default image viewer in linux use the 
	'eog out[Y, Cb, Cr].bmp'command.

	YCC To RGB - Use the 'qemu-arm bin/colourspace.exe outY.bmp outCb.bmp outCr.bmp' command. This will generate
	the output image outRGB.bmp image in the root directory. This image should look the same as the input image
	for the RGB to YCC conversion. To view this image use the 'eog outRGB.bmp' command.

******************************************************************************************************************************
File Structure -

	/arm - Contains the optimized ARM code files. These files are compiled using 'make armc'.

	/bin - Contains the generated executable file.

	/firmware - Contains the vertical and horizontal microcode and ARM code including the new instruction. Note this
	will not compile.
	
	/src - Contains the optimized C code. These file are compiled using 'make'.

	/testbench - Contains the test images to input to the program.

	/uml - Contains UML diagrams describing the system
	
	/vhdl - Contains VHDL code and test bench

