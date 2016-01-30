## $Id: Makefile,v 1.2 2016/01/30 19:06:47 aosorio Exp $

TARGETS = ejercicio9

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o *~
