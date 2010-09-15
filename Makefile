#!/usr/bin/make -f
#Template Makefile for working with DocBook XML projects

SHELL = /bin/sh
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


clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete

