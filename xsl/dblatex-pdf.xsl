<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
  <xsl:param name="doc.collab.show">0</xsl:param>
  <xsl:param name="draft.mode">yes</xsl:param>
  <!-- <xsl:param name="latex.class.options">11pt</xsl:param> -->
  <xsl:param name="latex.output.revhistory">0</xsl:param>
  <xsl:param name="make.year.ranges" select="1" />
  <xsl:param name="term.breakline">1</xsl:param>
  <xsl:param name="doc.lot.show"></xsl:param>
  <xsl:param name="latex.hyperparam">colorlinks,linkcolor=blue,anchorcolor=blue,urlcolor=blue</xsl:param>
  <xsl:param name="xref.with.number.and.title" select="1"/>
  <xsl:param name="insert.xref.page.number">yes</xsl:param>
  <!-- <xsl:param name="latex.class.options">a4paper,10pt,twoside,openright</xsl:param> -->

  <xsl:param name="xetex.font">
    <xsl:text>\setmainfont{Source Sans Pro}
    </xsl:text>
    <xsl:text>\setsansfont{Source Sans Pro}
    </xsl:text>
    <xsl:text>\setmonofont{Source Code Pro}
    </xsl:text>
  </xsl:param>
</xsl:stylesheet>
