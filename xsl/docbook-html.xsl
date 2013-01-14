<?xml version='1.0'?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 version="1.0">
  <xsl:import href="/usr/share/sgml/docbook/xsl-ns-stylesheets/html/docbook.xsl"/>
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="admon.graphics">1</xsl:param>
  <xsl:param name="draft.mode">yes</xsl:param>
  <xsl:param name="html.stylesheet">./lnx-docbook-stylesheet.css</xsl:param>
  <xsl:param name="make.year.ranges">1</xsl:param>
  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>

  <!-- Make admonitions not be so far indented -->
  <xsl:param name="admon.style">
    <xsl:value-of select="concat('margin-', $direction.align.start,            ': 0.10in; margin-', $direction.align.end, ': 0.10in;')"/>
  </xsl:param>
</xsl:stylesheet>
