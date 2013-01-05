<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

  <xsl:param name="doc.collab.show">0</xsl:param>
  <xsl:param name="draft.mode">yes</xsl:param>
  <xsl:param name="latex.class.options">11pt</xsl:param>
  <xsl:param name="latex.output.revhistory">0</xsl:param>
  <xsl:param name="make.year.ranges" select="1" />
  <xsl:param name="term.breakline">1</xsl:param>

  <xsl:param name="xetex.font">
    <xsl:text>\setmainfont{Source Sans Pro}
    </xsl:text>
    <xsl:text>\setsansfont{Source Sans Pro}
    </xsl:text>
    <xsl:text>\setmonofont{Source Code Pro}
    </xsl:text>
  </xsl:param>

  <!-- These don't seem to work with the xetex backend -->
  <!-- <xsl:param name="draft.watermark">1</xsl:param> -->
  <!-- <xsl:param name="show.comments" select="1" /> -->
</xsl:stylesheet>
