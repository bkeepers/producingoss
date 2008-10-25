<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0' xmlns:saxon="http://icl.com/saxon"
  extension-element-prefixes="saxon">

  <xsl:import href="html-import.xsl"/>

  <xsl:output method="html" encoding="utf-8" indent="yes" saxon:character-representation="native;decimal"/>
  <xsl:param name="use.id.as.filename">1</xsl:param>
  <xsl:param name="html.stylesheet">styles.css</xsl:param>

  <xsl:param name="l10n.gentext.language" select="'en'"/>
  

  <!--No adjustColumnWidths function available.-->
  <xsl:param name="use.extensions">1</xsl:param>
  <xsl:param name="tablecolumns.extension">1</xsl:param>
  <xsl:param name="callouts.extension">1</xsl:param>
  <xsl:param name="textinsert.extension">1</xsl:param>

</xsl:stylesheet>
