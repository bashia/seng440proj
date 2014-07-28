CC = arm-linux-gcc
FLAGS = -static -march=armv6
SRC = src
BIN = bin

compile: clean
	$(CC) $(FLAGS) -o $(BIN)/colourspace.exe $(SRC)/*.[ch]

clean:
	rm -f $(BIN)/*
