<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:output method="text" omit-xml-declaration="yes"/>
 
 <xsl:variable name="body" select="//*:body"/>
 
  
<xsl:template match="*:sp">
<xsl:value-of select="concat(@who, *:speaker)"/>
</xsl:template>

<xsl:template match="/">

<xsl:for-each select="distinct-values(//*:sp/@who)">
 <xsl:variable name="id"><xsl:value-of select="."/></xsl:variable>
 <xsl:value-of select="."/>  <xsl:text> : </xsl:text><xsl:value-of select="count($body//*:sp[@who eq $id])"/><xsl:text> sps ; </xsl:text>
 <xsl:for-each select="distinct-values($body//*:sp[@who eq $id]/*:speaker)">
  <xsl:text> "</xsl:text><xsl:value-of select="."/><xsl:text>" </xsl:text>
 </xsl:for-each><xsl:text>
 </xsl:text> </xsl:for-each>
 
<!-- <xsl:for-each select="distinct-values(//*:speaker)">
     <xsl:value-of select="."/>
  </xsl:for-each>-->
</xsl:template> 
</xsl:stylesheet>