#!/usr/bin/make -f

XSLTPARAMS = --xinclude -o output/Virtual-Disk-Operations.html \
	 --stringparam  section.autolabel 1

HTMLSTYLESHEET = /usr/share/xml/docbook5/stylesheet/docbook5/html/docbook.xsl
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
	xsltproc $(XSLTPARAMS) $(HTMLSTYLESHEET) $(DOCUMENT).xml

pdf:
	dblatex -o output/$(DOCUMENT).pdf -P latex.class.options=11pt -P term.breakline=1 $(DOCUMENT).xml

docs: html pdf

clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete
	rm -fR output/*
