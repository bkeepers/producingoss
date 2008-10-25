<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="chm-import.xsl"/>

  <xsl:param name="l10n.gentext.language" select="'en'"/>

  <xsl:param name="htmlhelp.encoding" select="'UTF-8'"/>
  <xsl:param name="chunker.output.encoding" select="'UTF-8'"/>

  <xsl:param name="saxon.character.representation" select="'native'"/>

  <!--It maybe can prevent hhc crash.-->
  <xsl:param name="suppress.navigation" select="0"/>

  <!--No adjustColumnWidths function available.-->
  <xsl:param name="use.extensions">0</xsl:param>
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <xsl:param name="callouts.extension">0</xsl:param>
  <xsl:param name="textinsert.extension">0</xsl:param>

  <xsl:param name="base.dir" select="'htmlhelp/'"/>

  <xsl:param name="htmlhelp.chm" select="'svnbook.chm'"/>

  <xsl:param name="htmlhelp.title">
    <xsl:text>Version Control with Subversion</xsl:text>
  </xsl:param>

</xsl:stylesheet>
