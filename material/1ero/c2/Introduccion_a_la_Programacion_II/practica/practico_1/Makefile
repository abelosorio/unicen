## $Id: Makefile,v 1.12 2016/01/30 19:06:33 aosorio Exp $

TARGETS = ejercicio2a ejercicio2b ejercicio2c ejercicio3a ejercicio3b \
  ejercicio4 ejercicio5 ejercicio6a ejercicio6b ejercicio7 ejercicio8

TARGETS_OBJECTS = $(TARGETS:=.o)

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TARGETS_OBJECTS)
