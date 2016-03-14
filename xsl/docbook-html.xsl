<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:d="http://docbook.org/ns/docbook"
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

  <xsl:param name="body.font.family">Source Sans Pro</xsl:param>
  <xsl:param name="sans.font.family">Source Sans Pro</xsl:param>
  <xsl:param name="monospace.font.family">Source Code Pro</xsl:param>

  <!-- <xsl:param name="css.decoration">0</xsl:param> -->

  <!-- VDG: Don't include examples and figure and stuff -->
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

  <!-- VDG: Make admonitions not be so far indented -->
  <xsl:param name="admon.style">
    <xsl:value-of select="concat('margin-', $direction.align.start,            ': 0.10in; margin-', $direction.align.end, ': 0.10in;')"/>
  </xsl:param>


  <!-- VDG: Ensure that the HTML TOC Generates an ID attribute -->
  <xsl:template name="make.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>
    <xsl:param name="nodes" select="/NOT-AN-ELEMENT"/>

    <!-- VDG: Not sure why, but trying to override this template
         (orig: html/autotoc.xsl) didn't work unless I commented out
         the nodes.plus var -->
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
	      <!-- VDG This is the only actual thing we're overriding
	           here. Ensure the table of contents includes an ID
	           attribute for anchoring -->
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


  <!-- VDG: We want the revhistory table to have 'table' as the class
       attribute -->
  <xsl:template match="d:revhistory" mode="titlepage.mode">
    <xsl:variable name="numcols">
      <xsl:choose>
	<xsl:when test=".//d:authorinitials|.//d:author">3</xsl:when>
	<xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

    <xsl:variable name="title">
      <xsl:call-template name="gentext">
	<xsl:with-param name="key">RevHistory</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="contents">
      <div>
	<xsl:apply-templates select="." mode="common.html.attributes"/>
	<xsl:call-template name="id.attribute"/>
	<hr />
	<table>
	  <!-- VDG: We don't want the default style params for the rev table -->
          <!-- <xsl:if test="$css.decoration != 0"> -->
          <!--   <xsl:attribute name="style"> -->
          <!--     <xsl:text>border-style:solid; width:100%;</xsl:text> -->
          <!--   </xsl:attribute> -->
          <!-- </xsl:if> -->
          <!-- include summary attribute if not HTML5 -->
          <xsl:if test="$div.element != 'section'">
            <xsl:attribute name="summary">
              <xsl:call-template name="gentext">
		<xsl:with-param name="key">revhistory</xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
	  <xsl:attribute name="class">table table-striped</xsl:attribute>
          <tr>
            <th align="{$direction.align.start}" valign="top" colspan="{$numcols}">
              <b>
		<xsl:call-template name="gentext">
                  <xsl:with-param name="key" select="'RevHistory'"/>
		</xsl:call-template>
              </b>
            </th>
          </tr>
          <xsl:apply-templates mode="titlepage.mode">
            <xsl:with-param name="numcols" select="$numcols"/>
          </xsl:apply-templates>
	</table>
      </div>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$generate.revhistory.link != 0">

	<!-- Compute name of revhistory file -->
	<xsl:variable name="file">
	  <xsl:call-template name="ln.or.rh.filename">
	    <xsl:with-param name="is.ln" select="false()"/>
	  </xsl:call-template>
	</xsl:variable>

	<xsl:variable name="filename">
          <xsl:call-template name="make-relative-filename">
            <xsl:with-param name="base.dir" select="$chunk.base.dir"/>
            <xsl:with-param name="base.name" select="$file"/>
          </xsl:call-template>
	</xsl:variable>

	<a href="{$file}">
          <xsl:copy-of select="$title"/>
	</a>

	<xsl:call-template name="write.chunk">
          <xsl:with-param name="filename" select="$filename"/>
          <xsl:with-param name="quiet" select="$chunk.quietly"/>
          <xsl:with-param name="content">
            <xsl:call-template name="user.preroot"/>
            <html>
              <head>
		<xsl:call-template name="system.head.content"/>
		<xsl:call-template name="head.content">
                  <xsl:with-param name="title">
                    <xsl:value-of select="$title"/>
                    <xsl:if test="../../d:title">
                      <xsl:value-of select="concat(' (', ../../d:title, ')')"/>
                    </xsl:if>
                  </xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="user.head.content"/>
              </head>
              <body>
		<xsl:call-template name="body.attributes"/>
		<xsl:copy-of select="$contents"/>
              </body>
            </html>
            <xsl:text>&#x0a;</xsl:text>
          </xsl:with-param>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$contents"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
