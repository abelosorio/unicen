## $Id: Makefile,v 1.3 2016/01/30 19:06:47 aosorio Exp $

TARGETS = entrega3

all: $(TARGETS)

%: %.pas
	fpc $^

.PHONY: clean
clean:
	rm -f $(TARGETS) *.o *~
