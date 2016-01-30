## $Id: Makefile,v 1.2 2016/01/30 19:06:46 aosorio Exp $

TARGETS = ejercicio1 ejercicio2 ejercicio3 ejercicio4 ejercicio5 ejercicio6 \
  ejercicio7 ejercicio8 ejercicio9 ejercicio10 ejercicio11 ejercicio12 \
  ejercicio13 ejercicio14

TARGETS_OBJECTS = ejercicio1.o ejercicio2.o ejercicio3.o ejercicio4.o \
  ejercicio5.o ejercicio6.o ejercicio7.o ejercicio8.o ejercicio9.o \
  ejercicio10.o ejercicio11.o ejercicio12.o ejercicio13.o ejercicio14.o

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TARGETS_OBJECTS)
