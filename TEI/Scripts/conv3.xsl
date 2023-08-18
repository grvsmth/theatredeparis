<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t " version="2.0">
 
 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 
 <!-- various patches for things i spotted after doing the first tranche conversion --> 

 <xsl:template match="/ | @* | node()" >
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

<!-- hi within speaker shd not be treated same as stage within speaker: it may be a title -->
 
<!--<xsl:template match="t:speaker[t:hi]">
 <xsl:copy>
  <xsl:value-of select="text()"/>
 </xsl:copy>
 <stage type="inline" xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:value-of select="t:hi"/>
 </stage>
</xsl:template>-->

<!-- div/@type should have a value -->

<xsl:template match="t:div[not(@type)]">
 <xsl:copy>
  <xsl:attribute name="type">scene</xsl:attribute>
  <xsl:apply-templates/>
 </xsl:copy>
</xsl:template>

<!-- tweak wording of Header -->
 
 <xsl:template match="t:titleStmt/t:respStmt[1]/t:resp">
  <resp xmlns="http://www.tei-c.org/ns/1.0">HTML version by</resp>
 </xsl:template>
 <xsl:template match="t:titleStmt/t:respStmt[2]/t:resp">
  <resp xmlns="http://www.tei-c.org/ns/1.0">TEI version by</resp>
 </xsl:template>
 <xsl:template match="t:distributor">
  <p xmlns="http://www.tei-c.org/ns/1.0">The Digital Parisian Stage Corpus is freely available from a GitHub
   repository at <ref target="https://github.com/grvsmth/theatredeparis"/></p>
 </xsl:template>
 <xsl:template match="t:sourceDesc/t:p">
  <p xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="replace(text()[1], 'downloaded','available')"/>
   <ref xmlns="http://www.tei-c.org/ns/1.0" target="{t:ref/@target}"/></p> 
 </xsl:template>
 <xsl:template match="t:revisionDesc">
  <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
   <change when="2023-07-31">Make headers and div/@type uniform</change>
   <xsl:apply-templates/>
  </revisionDesc>
 </xsl:template>
 
<!-- air titles -->
 
 <xsl:template match="t:stage/t:hi">
 <title xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:apply-templates/>
 </title>
</xsl:template>
 
 
</xsl:stylesheet>