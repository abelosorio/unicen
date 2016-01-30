## $Id: Makefile,v 1.3 2016/01/30 19:06:34 aosorio Exp $

TARGETS = ejercicio1 ejercicio2

TARGETS_OBJECTS = $(TARGETS:=.o)

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) $(TARGETS_OBJECTS)
