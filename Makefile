# commands
INSTALL := install
MD	:= markdown
RM	:= rm

all: udev/ykfde README.html

udev/ykfde: udev/ykfde.c
	$(MAKE) -C udev

README.html: README.md
	$(MD) README.md > README.html

install: install-bin install-doc

install-bin: udev/ykfde
	$(MAKE) -C udev install
	$(INSTALL) -D -m0644 conf/ykfde.conf $(DESTDIR)/etc/ykfde.conf
	$(INSTALL) -D -m0755 bin/ykfde $(DESTDIR)/usr/bin/ykfde
	$(INSTALL) -D -m0644 install/ykfde $(DESTDIR)/usr/lib/initcpio/install/ykfde

install-doc: README.md README.html
	$(INSTALL) -D -m0644 README.md $(DESTDIR)/usr/share/doc/ykfde/README.md
	$(INSTALL) -D -m0644 README.html $(DESTDIR)/usr/share/doc/ykfde/README.html

clean:
	$(MAKE) -C udev clean
	$(RM) -f README.html