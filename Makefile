CC = arm-linux-gcc
FLAGS = -static -march=armv6
SRC = src
BIN = bin
ARM = arm

compile: clean
	$(CC) $(FLAGS) -o $(BIN)/colourspace.exe $(SRC)/*.[ch]

armc: clean
	$(CC) $(FLAGS) -o $(BIN)/colourspace.exe $(ARM)/*.s

clean:
	rm -f $(BIN)/*
