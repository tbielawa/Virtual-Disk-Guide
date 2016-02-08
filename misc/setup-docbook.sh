#!/bin/bash
set -xe
DBXSL=http://netcologne.dl.sourceforge.net/project/docbook/docbook-xsl-ns/1.79.1/docbook-xsl-ns-1.79.1.tar.bz2
#DBXSL=http://iweb.dl.sourceforge.net/project/docbook/docbook-xsl-ns/1.78.1/docbook-xsl-ns-1.78.1.tar.bz2
DBRNG=http://www.docbook.org/xml/5.1b8/rng/docbookxi.rng
DBRNC=http://www.docbook.org/xml/5.1b8/rng/docbookxi.rnc
SOURCESANS=https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.zip
SOURCECODE=https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
DLDEST=`mktemp -d`
DEST=~/opt/docbook
RNGDEST=$DEST/rng
SCHEMADEST=$DEST/stylesheets

setup_install_dest() {
    mkdir -vp $RNGDEST
}

download_bits() {
    wget $DBXSL $DBRNG $DBRNC $SOURCESANS $SOURCECODE
}

install_fonts() {
    mkdir -pv ~/.fonts
    unzip \*.zip
    find . -name "*.ttf" -print0 | xargs -0 -I{} mv -v '{}' ~/.fonts/
}

install_grammar() {
    for e in rnc rng; do
	mv -v $DLDEST/docbookxi.${e} $RNGDEST/
    done
}

install_stylesheets() {
    tar -xf `basename $DBXSL`
    xsldir=`basename $DBXSL .tar.bz2`
    mv -v $xsldir $SCHEMADEST
}

install_dblatex_hack() {
    :
}


cleanup() {
    rm -fR $DLDEST
}

rm -fR ~/opt/ ~/.fonts/

setup_install_dest
pushd $DLDEST
download_bits
install_fonts
install_grammar
install_stylesheets
popd
cleanup
