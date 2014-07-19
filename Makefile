CC = arm-linux-gcc
FLAGS = -static
SRC = src
BIN = bin

compile: clean
	$(CC) $(FLAGS) -o $(BIN)/colourspace.exe $(SRC)/*.[ch]

clean:
	rm -f $(BIN)/*
