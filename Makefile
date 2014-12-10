CC=clang++
CFLAGS=-Wall -Wextra -O3

all:	parse

parse:	parse.cpp
	$(CC) -o parse parse.cpp $(CFLAGS)

.PHONY: clean

clean:
	rm parse
