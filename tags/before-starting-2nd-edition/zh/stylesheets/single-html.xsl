<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://icl.com/saxon" version='1.0'>

  
  <xsl:import href="single-html-import.xsl"/>
  <xsl:param name="html.stylesheet">styles.css</xsl:param>


  <xsl:output method="saxon:xhtml" encoding="utf-8" indent="yes"/>
  <xsl:param name="l10n.gentext.language" select="'en'"/>

  <!--No adjustColumnWidths function available.-->
  <xsl:param name="use.extensions">1</xsl:param>
  <xsl:param name="tablecolumns.extension">1</xsl:param>
  <xsl:param name="callouts.extension">1</xsl:param>
  <xsl:param name="textinsert.extension">1</xsl:param>

</xsl:stylesheet>
