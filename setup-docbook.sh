#!/bin/bash
set -xe

DBXSL=http://iweb.dl.sourceforge.net/project/docbook/docbook-xsl-ns/1.78.1/docbook-xsl-ns-1.78.1.tar.bz2
DBRNG=http://www.docbook.org/xml/5.1b8/rng/docbookxi.rng
DBRNC=http://www.docbook.org/xml/5.1b8/rng/docbookxi.rnc
SOURCESANS=http://iweb.dl.sourceforge.net/project/sourcesans.adobe/SourceSansPro_FontsOnly-1.050.zip
SOURCECODE=http://iweb.dl.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip
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
