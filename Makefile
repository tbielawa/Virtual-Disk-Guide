#!/usr/bin/make -f

##################################################################
# General settings
#
# INPUT - Main including file without .xml suffix
# OUTPUT - Generated document minus target suffix
# DEST - Destination for (non-chunked) transformations
# CHUNKDIR - Destination for chunked HTML transformations
# OUTPUT - "Path/Name" of generated (non-chunked) documents.
##################################################################
INPUT = Virtual-Disk-Operations
OUTPUT = $(INPUT)
DEST = output
CHUNKDIR = html
OUTFILE = $(DEST)/$(OUTPUT)
GENERATION_TIMESTAMP = $(shell date +"%c")
GENERATION_COMMIT_HASH = $(shell git reflog -1 | cut -d' ' -f1)

##################################################################
# Stylesheet configuration
#
# Uncomment the proper stylesheet directory for your machine
#
# STYLEDIR - Directory holding xsl-ns stylesheet distribution
# HTML_xsl - Stylesheet for HTML transformations
# HTML_CHUNKED_xsl - Stylesheet for Chunked HTML transformations
##################################################################
# Fedora - Package: docbook5-style-xsl
STYLEDIR = ~/opt/docbook/stylesheets/

# Ubuntu - Package: docbook-xsl-ns
# STYLEDIR = /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/

# OS X - Package (Macports): docbook-xsl
# STYLEDIR = /opt/local/share/xsl/docbook-xsl

HTML_xsl = $(STYLEDIR)profiling/profile.xsl
HTML_CUSTOM_XSL = ./xsl/docbook-html.xsl
HTML_XSLTPROC_PARAMS = --xinclude --param profile.attribute "'audience'" \
	--param profile.value "'html'" \
	$(HTML_xsl)

#HTML_CHUNKED_xsl = $(STYLEDIR)/html/chunk.xsl
HTML_CHUNKED_xsl = xsl/docbook-html-chunked.xsl

##################################################################
# Options for transformations
#
# XSLTPARAMS - Options applicable to single/chunked output
# XSLT_HTML_PARAMS - Options specific to sigle HTML output
# DBLATEX_PARAMS - Options specific to dblatex PDF output
##################################################################
XSLTPARAMS = --xinclude

# -o $(OUTFILE).html
#XSLT_HTML_PARAMS =

XSLT_CHUNKED_PARAMS = --stringparam base.dir $(CHUNKDIR)/

# -o $(OUTFILE).pdf
DBLATEX_PARAMS = -p xsl/dblatex-pdf.xsl \
	-p xsl/dblatex-acknowledgements.xsl \
	-b xetex -T vdg
DBLATEX_XSLTPROC_PARAMS = --xinclude \
	--param profile.attribute "'audience'" \
	--param profile.value "'pdf'" \
	$(STYLEDIR)profiling/profile.xsl

##################################################################
# Use the proper options for the target platform
##################################################################
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

##################################################################
# DocBook5 Schema
#
# Uncomment the applicable path to your system
#
# SCHEMADIR - Directory holding the DocBook5 RNC/RNG DTDs
##################################################################
# Fedora - Package: docbook5-schemas
SCHEMADIR = ~/opt/docbook/rng

# OS X - Package (MacPorts): docbook-xml-5.0
# SCHEMADIR = /opt/local/share/xml/docbook/5.0/rng

# Ubuntu - Package: docbook5-xml
# SCHEMADIR = /usr/share/xml/docbook/schema/rng/5.0

##################################################################
# Build targets
##################################################################
all: clean docbook/Introduction.xml docs

# Support a rendered-on timestamp in HTML *and* PDF output. Removes
# the reliance on the <?dbtimestamp> element
docbook/Introduction.xml: docbook/Introduction.xml.in
	sed -e "s/GENERATION_TIMESTAMP/$(GENERATION_TIMESTAMP)/" \
	-e "s/GENERATION_COMMIT_HASH/$(GENERATION_COMMIT_HASH)/g" $< > $@

timestamp: docbook/Introduction.xml

docdir:
	mkdir -p $(DEST)
	@ln -s ../css/lnx-docbook-stylesheet.css $(DEST)/lnx-docbook-stylesheet.css || true
	@ln -s ../js/vdg.js $(DEST)/vdg.js || true
	@ln -s ../images $(DEST)/images || true
	mkdir -p $(CHUNKDIR)
	@ln -s ../css/lnx-docbook-stylesheet.css $(CHUNKDIR)/lnx-docbook-stylesheet.css || true
	@ln -s ../js/vdg.js $(CHUNKDIR)/vdg.js || true
	@ln -s ../images $(CHUNKDIR)/images || true

# chunked:
# 	@echo "#############################################"
# 	@echo "     BUILDING HTML (CHUNKED) OUTPUT NOW"
# 	@echo "#############################################"
# 	xsltproc $(XSLTPARAMS) $(XSLT_CHUNKED_PARAMS) $(HTML_CHUNKED_xsl) $(INPUT).xml

# %.html: %.xml
# This is a target for <somedocument>.html. %.xml is a target for
# <somedocument>.xml (to ensure it exists or has been generated)
# If $(OUTFILE) = output/somedocument.html and it has not been generated
# Then somedocument.xml must exist in the PWD.
# Special vars:
#   $@ - The evaluated name of the target rule, e.g., output/somedocument.html $(OUTFILE).html
#   $< - The evaluated name of the dependency rule, e.g., somedocument.xml $(INPUT).xml

# The called target should be the last transformation. I.E.,
# somefile.pdf, or somefile.html.  The depend target (%.xml below) are
# recursively evaluated until all required targets have been met.
%.html: docbook/Introduction.xml
	@echo "#############################################"
	@echo "       BUILDING HTML OUTPUT NOW"
	@echo "#############################################"
	xsltproc $(HTML_XSLTPROC_PARAMS) Virtual-Disk-Operations.xml | \
	xsltproc $(XSLTPARAMS) $(XSLT_HTML_PARAMS) -o $(DEST)/$@ $(HTML_CUSTOM_XSL) -

html: timestamp docdir $(OUTPUT).html

%.pdf: %.xml
	@echo "#############################################"
	@echo "       BUILDING PDF OUTPUT NOW"
	@echo "#############################################"
	xsltproc $(DBLATEX_XSLTPROC_PARAMS) Virtual-Disk-Operations.xml | \
	dblatex $(DBLATEX_PARAMS) -o $(DEST)/$@ -

%.tex: %.xml
	@echo "#############################################"
	@echo "       BUILDING TEX OUTPUT NOW"
	@echo "#############################################"
	xsltproc $(DBLATEX_XSLTPROC_PARAMS) Virtual-Disk-Operations.xml | \
	dblatex -d $(DBLATEX_PARAMS) -t tex -o $(DEST)/$@ -


pdf: timestamp docdir $(OUTPUT).pdf

tex: timestamp docdir $(OUTPUT).tex

docs: docdir $(OUTPUT).html $(OUTPUT).pdf

locator:
	sed "s'%SCHEMADIR%'$(SCHEMADIR)'" .schemas.xml > schemas.xml

clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete
	rm -fR output html docbook/Introduction.xml

spell:
	for i in `find . -name "*.xml"`; do aspell -H -c $$i; done
