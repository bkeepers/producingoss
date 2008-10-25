<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

  <xsl:import href="../fo.xsl"/>

  <xsl:param name="l10n.gentext.language" select="'zh_cn'"/>

  <xsl:param name="hyphenate">false</xsl:param>

  <!-- Font related Settings -->
  <xsl:param name="body.font.family">simsun</xsl:param>
  <xsl:param name="body.font.size">12</xsl:param>
  <xsl:param name="dingbat.font.family">simhei</xsl:param>
  <!--xsl:param name="monospace.font.family">simsun</xsl:param-->
  <xsl:param name="title.font.family">simhei</xsl:param>
  <xsl:param name="title.font.size">14</xsl:param>

  <!-- Admonitions -->
  <xsl:param name="admon.graphics" select="1"/>

  <xsl:param name="callout.unicode.font">simsun</xsl:param>
  <xsl:param name="callout.unicode.start.character">10102</xsl:param>

<!--Font Families -->

<xsl:param name="body.start.indent">
  <xsl:choose>
    <xsl:when test="$fop.extensions != 0">0pt</xsl:when>
    <xsl:when test="$passivetex.extensions != 0">0pt</xsl:when>
    <xsl:otherwise>0pc</xsl:otherwise>
  </xsl:choose>
</xsl:param>

</xsl:stylesheet>
