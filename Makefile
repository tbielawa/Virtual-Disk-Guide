#!/usr/bin/make

pdf:
	xmllint --xinclude Virtual-Disk-Operations.xml | xsltproc ~/cache/DocumentEditing/DocBook/XSLSheets/docbook-xsl-1.75.2/fo/docbook.xsl - > tmp.fo && fop tmp.fo tmp.pdf
