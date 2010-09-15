#!/usr/bin/make -f

XSLTPARAMS = --xinclude -o Virtual-Disk-Operations.html
STYLESHEET = /usr/share/xml/docbook5/stylesheet/docbook5/html/docbook.xsl
DOCUMENT = Virtual-Disk-Operations


OSTYPE := $(shell uname -s)

# OS X?
ifeq ("$(findstring Darwin, $(OSTYPE))", "Darwin")
	SED = sed -E
	FIND = find . -E
# Assume GNU
else
	SED = sed -r
	FIND = find . -regextype posix-extended
endif

all: clean

html:
	xsltproc $(XSLTPARAMS) $(STYLESHEET) $(DOCUMENT).xml

pdf:
	dblatex -o $(DOCUMENT).pdf -P latex.class.options=11pt -P term.breakline=1 $(DOCUMENT).xml

clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete

