## $Id: Makefile,v 1.9 2016/01/30 19:06:34 aosorio Exp $

TARGETS = ejercicio1 ejercicio2 ejercicio3 ejercicio4 ejercicio5 ejercicio6 \
          ejercicio7 ejercicio8 ejercicio9

TARGETS_OBJECTS = $(TARGETS:=.o)

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TARGETS_OBJECTS)
