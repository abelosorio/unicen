## $Id: Makefile,v 1.2 2016/01/30 19:06:47 aosorio Exp $

TARGETS = ejercicio4 ejercicio6 ejercicio7 ejercicio8 ejercicio10 \
  ejercicio11 ejercicio12 ejercicio14

TARGETS_OBJECTS = ejercicio4.o ejercicio6.o ejercicio7.o ejercicio8.o \
  ejercicio10.o ejercicio11.0 ejercicio12.o ejercicio14.o

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TARGETS_OBJECTS)
