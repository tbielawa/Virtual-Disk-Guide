<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 version="1.0">
  <xsl:import href="/home/tbielawa/opt/docbook/stylesheets/html/docbook.xsl"/>

  <!-- output styling/format -->
  <xsl:param name="html.stylesheet">./lnx-docbook-stylesheet.css</xsl:param>
  <xsl:template name="user.head.content">
    <xsl:variable name="codefile" select="document('js/vdg.js',/)"/>
    <xsl:copy-of select="$codefile/html/node()"/>
  </xsl:template>
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:param name="generate.id.attributes" select="1"/>
  <xsl:param name="admon.graphics">1</xsl:param>
  <xsl:param name="draft.mode">yes</xsl:param>
  <xsl:param name="make.year.ranges">1</xsl:param>
  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>

  <!-- Don't include examples and figure and stuff -->
  <xsl:param name="generate.toc">
    appendix  toc,title
    article/appendix  nop
    article   toc,title
    book      toc,title
    chapter   toc,title
    part      toc,title
    preface   toc,title
    qandadiv  toc
    qandaset  toc
    reference toc,title
    sect1     toc
    sect2     toc
    sect3     toc
    sect4     toc
    sect5     toc
    section   toc
    set       toc,title
  </xsl:param>

  <!-- Make admonitions not be so far indented -->
  <xsl:param name="admon.style">
    <xsl:value-of select="concat('margin-', $direction.align.start,            ': 0.10in; margin-', $direction.align.end, ': 0.10in;')"/>
  </xsl:param>


  <!-- Ensure that the HTML TOC Generates an ID attribute -->
  <xsl:template name="make.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>
    <xsl:param name="nodes" select="/NOT-AN-ELEMENT"/>

    <!-- Not sure why, but trying to override this template (orig:
         html/autotoc.xsl) didn't work unless I commented out the
         nodes.plus var -->
    <!-- <xsl:variable name="nodes.plus" select="$nodes | d:qandaset"/> -->

    <xsl:variable name="toc.title">
      <xsl:if test="$toc.title.p">
	<xsl:choose>
          <xsl:when test="$make.clean.html != 0">
            <div class="toc-title">
              <xsl:call-template name="gentext">
		<xsl:with-param name="key">TableofContents</xsl:with-param>
              </xsl:call-template>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <p>
              <b>
		<xsl:call-template name="gentext">
                  <xsl:with-param name="key">TableofContents</xsl:with-param>
		</xsl:call-template>
              </b>
            </p>
          </xsl:otherwise>
	</xsl:choose>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$manual.toc != ''">
	<xsl:variable name="id">
          <xsl:call-template name="object.id"/>
	</xsl:variable>
	<xsl:variable name="toc" select="document($manual.toc, .)"/>
	<xsl:variable name="tocentry" select="$toc//d:tocentry[@linkend=$id]"/>
	<xsl:if test="$tocentry and $tocentry/*">
          <div class="toc">
            <xsl:copy-of select="$toc.title"/>
            <xsl:element name="{$toc.list.type}">
              <xsl:call-template name="toc.list.attributes">
		<xsl:with-param name="toc-context" select="$toc-context"/>
		<xsl:with-param name="toc.title.p" select="$toc.title.p"/>
		<xsl:with-param name="nodes" select="$nodes"/>
              </xsl:call-template>
              <xsl:call-template name="manual-toc">
		<xsl:with-param name="tocentry" select="$tocentry/*[1]"/>
              </xsl:call-template>
            </xsl:element>
          </div>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:choose>
          <xsl:when test="$qanda.in.toc != 0">
            <xsl:if test="$nodes.plus">
              <div class="toc">
		<xsl:copy-of select="$toc.title"/>
		<xsl:element name="{$toc.list.type}">
                  <xsl:call-template name="toc.list.attributes">
                    <xsl:with-param name="toc-context" select="$toc-context"/>
                    <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
                    <xsl:with-param name="nodes" select="$nodes"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="$nodes.plus" mode="toc">
                    <xsl:with-param name="toc-context" select="$toc-context"/>
                  </xsl:apply-templates>
		</xsl:element>
              </div>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$nodes">
	      <!-- This is the only actual thing we're overriding here -->
	      <!-- Ensure the table of contents includes an ID attribute for anchoring -->
              <div class="toc" id="VDG-TOC">
		<xsl:copy-of select="$toc.title"/>
		<xsl:element name="{$toc.list.type}">
                  <xsl:call-template name="toc.list.attributes">
                    <xsl:with-param name="toc-context" select="$toc-context"/>
                    <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
                    <xsl:with-param name="nodes" select="$nodes"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="$nodes" mode="toc">
                    <xsl:with-param name="toc-context" select="$toc-context"/>
                  </xsl:apply-templates>
		</xsl:element>
              </div>
            </xsl:if>
          </xsl:otherwise>
	</xsl:choose>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
