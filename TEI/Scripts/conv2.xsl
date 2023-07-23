<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns:h="http://www.w3.org/1999/xhtml"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t h" version="2.0">
 
 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 

 <xsl:template match="/ | @* | node()" >
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="body/div"> 
  <div xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:for-each-group select="*" group-starting-with="speaker">              
    <sp  xmlns="http://www.tei-c.org/ns/1.0"  who="{current-group()/@n}">
     <xsl:for-each select="current-group()">
      <xsl:apply-templates select="."/>
     </xsl:for-each>
    </sp>        
   </xsl:for-each-group> 
  </div>
 </xsl:template>
 
 
 <xsl:template match="t:speaker/@n"/>
 
 <xsl:template match="t:speaker[t:stage]">
  <speaker xmlns="http://www.tei-c.org/ns/1.0"> <xsl:value-of select="text()"/></speaker>
  <xsl:copy-of select="t:stage"/>
 </xsl:template>
</xsl:stylesheet>
