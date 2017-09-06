CC = gcc
CFLAGS = -O2 -DHAVE_openpty
VERSION = 1.0.8

TARGET = ttyrec ttyplay ttytime
MAN.1 = ttyrec.1 ttyplay.1 ttytime.1

DIST =	ttyrec.c ttyplay.c ttyrec.h io.c io.h ttytime.c\
	README Makefile $(MAN.1)

PREFIX = /usr/local

all: $(TARGET)

ttyrec: ttyrec.o io.o
	$(CC) $(CFLAGS) -o ttyrec ttyrec.o io.o -lutil

ttyplay: ttyplay.o io.o
	$(CC) $(CFLAGS) -o ttyplay ttyplay.o io.o

ttytime: ttytime.o io.o
	$(CC) $(CFLAGS) -o ttytime ttytime.o io.o

clean:
	rm -f *.o $(TARGET) ttyrecord *~

dist:
	rm -rf ttyrec-$(VERSION)
	rm -f ttyrec-$(VERSION).tar.gz

	mkdir ttyrec-$(VERSION)
	cp $(DIST) ttyrec-$(VERSION)
	tar zcf ttyrec-$(VERSION).tar.gz  ttyrec-$(VERSION)
	rm -rf ttyrec-$(VERSION)

install: $(TARGET) $(MAN.1)
	install -D $(TARGET) $(PREFIX)/bin
	install -D $(MAN.1) $(PREFIX)/share/man/man1
