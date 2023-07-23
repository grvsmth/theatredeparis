<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:t="http://www.tei-c.org/ns/1.0"
 xmlns:h="http://www.w3.org/1999/xhtml"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs t h" version="2.0">
 <!-- TODO
  multiple speeches
 -->
 <xsl:output xpath-default-namespace="http://www.tei-c.org/ns/1.0"/>
 
 <xsl:variable name="today">
  <xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
 </xsl:variable> 
 
 <xsl:variable name="inputFile">
  <xsl:value-of select="tokenize(base-uri(.), '/')[last()]"/>       
 </xsl:variable>  
 
 <xsl:variable name="inputURL">
  <xsl:value-of select="concat('https://github.com/grvsmth/theatredeparis/blob/master/texts/',$inputFile)"/>
 </xsl:variable>
 
 <xsl:variable name="idno">
  <xsl:value-of select="replace($inputFile,'[a-zA-Z\.]','')"/>
 </xsl:variable>
 
 <xsl:variable name="sourceURL">
  <xsl:value-of select="document('/home/lou/Public/theatredeparis/TEI/napoleonicSample.xml')//*:row[*:cell[@n='2'] eq $idno]/*:cell[@n='6']"/>
 </xsl:variable>

 <xsl:template match="/ | @* | node()">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <xsl:param name="wicks">9999_</xsl:param>

<xsl:template match="h:head">
 <xsl:comment><xsl:value-of select="."/></xsl:comment>
</xsl:template>
 
<xsl:template match="h:html">
 <xsl:message><xsl:value-of select="concat('Converting ',$inputFile, ' from ', $sourceURL, ' to W', $idno)"/></xsl:message>
 
 <TEI   xmlns="http://www.tei-c.org/ns/1.0" xml:lang="fr">
 <xsl:attribute name="xml:id"><xsl:value-of select="concat('W',$idno)"/></xsl:attribute>
  <teiHeader>
   <fileDesc>
    <titleStmt><title><xsl:value-of select="concat(h:head/h:title,': TEI edition (Wicks no. ', $idno, ')')"/></title>
   <author> <xsl:choose> <xsl:when test="h:head/h:meta[@name='author']">
      <xsl:value-of select="h:head/h:meta[@name='author']"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="document('/home/lou/Public/theatredeparis/TEI/napoleonicSample.xml')//*:row[*:cell[@n='2'] eq $idno]/*:cell[@n='4']"/>
     </xsl:otherwise> 
     </xsl:choose></author>
    <respStmt><resp>Original transcription by </resp><name>Angus B. Grieve-Smith</name></respStmt>
     <respStmt><resp>TEI conversion by </resp><name>Lou Burnard</name></respStmt>
    </titleStmt>
    <publicationStmt><distributor> The Digital Parisian Stage Corpus. GitHub. https://github.com/grvsmth/theatredeparis
    </distributor></publicationStmt>
    <sourceDesc><p>Original page images downloaded from <ref target="{$sourceURL}"/>.</p>
     <p>HTML transcription downloaded from <ref target="{$inputURL}">https://github.com/grvsmth/theatredeparis</ref></p>
   </sourceDesc>
   </fileDesc>
   <revisionDesc>
    <change when="{$today}">Header confected</change>
   </revisionDesc>
  </teiHeader>
 <text> 
  <front>
    <titlePage>
<docTitle> <titlePart> <xsl:comment><xsl:value-of select="h:body/h:p"/></xsl:comment>
 </titlePart></docTitle> 
     <byline><docAuthor></docAuthor></byline> 
     <docImprint></docImprint></titlePage>
   <xsl:apply-templates select="h:body/h:table"/>
   </front>
  <xsl:apply-templates select="h:body/h:div"/>
 </text></TEI>
</xsl:template> 
 
 <xsl:template match="h:tbody">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="h:table">
  <castList xmlns="http://www.tei-c.org/ns/1.0">   
   <xsl:apply-templates/>
  </castList>
 </xsl:template>
 
 <xsl:template match="h:table/h:thead|h:table/h:th">
  <head xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="."/></head>
 </xsl:template>
 
 <xsl:template match="h:tr">
  <castItem xmlns="http://www.tei-c.org/ns/1.0">
   <role><xsl:value-of select="h:td[1]"/></role>
   <actor><xsl:value-of select="h:td[2]"/></actor>
  </castItem>
 </xsl:template>
 
 <xsl:template match="h:div[matches(@class,'[cC]ontent')]">
  <body xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:for-each-group select="*" group-starting-with="h:h3|h:h2">
    <div type="scene">
     <xsl:for-each select="current-group()">
      <xsl:apply-templates select="."/>
     </xsl:for-each>
    </div>
   </xsl:for-each-group>
  </body>
 </xsl:template>

 <xsl:template match="h:h4|h:h3|h:h2|h:h1">
  <head xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </head>
 </xsl:template>

 <xsl:template match="h:p[@class='heading']"/>
 <!-- only present in one text: could be fw but not useful -->
 
 <xsl:template match="h:p[@class='pagenum']">
  <pb xmlns="http://www.tei-c.org/ns/1.0" n="{.}"/>
  <!--<xsl:if test="following-sibling::h:p[1][matches(@class,'char\d')]">
   <xsl:apply-templates select="following-sibling::h:p[1]" mode="keep"/>
  </xsl:if>-->
 </xsl:template>
 
 <xsl:template match="h:p[@class eq 'stage']">
  <stage xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </stage>
 </xsl:template>
 
 
 <xsl:template match="h:p[starts-with(@class, 'charn')]">
  <speaker xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:attribute name="n">
     <xsl:value-of select="concat('#TDP', $idno, '_', substring-after(@class, 'charn'))"/>
    </xsl:attribute>
    <xsl:apply-templates/>
   </speaker>
 </xsl:template>


 <xsl:template match="h:p[matches(@class, 'char\d+')]">
  <xsl:choose>
   <xsl:when test="h:br">
    <xsl:for-each select="h:br">
     <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of 
      select="preceding-sibling::text()[1]"/></l>
    </xsl:for-each>
    <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of 
     select="h:br[position() eq last()]/following-sibling::text()[1]"/></l>   
   </xsl:when>
   <xsl:when test="h:i/h:br">
    <xsl:for-each select="h:i/h:br">
     <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of 
      select="preceding-sibling::text()[1]"/></l>
    </xsl:for-each>
    <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of 
     select="h:i/h:br[position() eq last()]/following-sibling::text()[1]"/></l>
   </xsl:when>
   <xsl:otherwise>
    <p xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:apply-templates/>
    </p> 
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="h:span[@class eq 'sstage']">
  <stage xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </stage>
 </xsl:template>
 
 <xsl:template match="h:span[@class eq 'stage']">
  <stage xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates/>
  </stage>
 </xsl:template>
 
 
 <xsl:template match="h:sup">
  <xsl:apply-templates/>
 </xsl:template>
 
<xsl:template match="h:i">
  <hi xmlns="http://www.tei-c.org/ns/1.0"> <xsl:apply-templates/></hi>
 </xsl:template>
</xsl:stylesheet>
