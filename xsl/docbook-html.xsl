<?xml version='1.0'?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 version="1.0">

  <xsl:import href="/usr/share/sgml/docbook/xsl-ns-stylesheets/html/docbook.xsl"/>
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>
  <xsl:param name="html.stylesheet">./lnx-docbook-stylesheet.css</xsl:param>
  <xsl:param name="make.year.ranges">1</xsl:param>
  <xsl:param name="draft.mode">yes</xsl:param>
</xsl:stylesheet>
