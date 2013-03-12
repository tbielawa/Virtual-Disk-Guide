<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
  <xsl:param name="acknowledgements.tocdepth">0</xsl:param>

<xsl:template match="acknowledgements">
  <xsl:call-template name="section.unnumbered">
    <xsl:with-param name="tocdepth" select="number($acknowledgements.tocdepth)"/>
    <xsl:with-param name="title">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Acknowledgements'"/>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
</xsl:stylesheet>
