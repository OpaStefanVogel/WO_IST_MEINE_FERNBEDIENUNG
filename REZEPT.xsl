<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/REZEPT">
<html>
 <head>
   <link rel="stylesheet" type="text/css" href="http://opastefanvogel.github.io/WO_IST_MEINE_FERNBEDIENUNG/REZEPT.css" />
   </head>
 <body class="REZEPT">Test
<xsl:apply-templates />
<script src="http://opastefanvogel.github.io/WO_IST_MEINE_FERNBEDIENUNG/REZEPT_UHR.js" type="text/javascript"/>
 </body></html>
</xsl:template>

<xsl:template match="UHR">
<span class="UHR" ontouchstart="CLICKI(event)"
  ontouchmove="DRAGGI(event)"
  angehalten="ja"><xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
  <img src="http://opastefanvogel.github.io/WO_IST_MEINE_FERNBEDIENUNG/REZEPT_UHR.svg"/>
  <xsl:value-of select="." />
  </span>
</xsl:template>

<xsl:template match="TITEL">
<div><span style="vertical-align:top">Rezept </span>
<svg style="border:solid" width="100%" height="110px" font-family="Helvicta">
<text transform="scale(6,4) rotate(0) translate(0,16)" stroke="red" fill="green">
  * *    * <xsl:value-of select="." /> * * *
   <xsl:value-of select="." /> * * *
    <xsl:value-of select="." /> * * *
     <xsl:value-of select="." /> * * *
      <xsl:value-of select="." /> * * *
    <animate attributeType="XML" attributeName="x"     
    begin="0s" dur="200s"   
    from="0" to="-800"
    accumulate="sum"
    additive="sum"
    repeatCount="50"    
    fill="freeze" />
    
 </text>
</svg>
</div>
</xsl:template>

<xsl:template match="ZUTATEN">
 <span class="ZUTATEN"><xsl:value-of select="." /></span>
</xsl:template>

<xsl:template match="ZUBEREITUNG">
  
 <span class="ZUBEREITUNG"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="ZUBEREITUNG/a">
 <a><xsl:attribute name="href"><xsl:value-of select="." />.xml</xsl:attribute>
  <u><xsl:value-of select="." /></u></a>
 </xsl:template>

<xsl:template match="BILD">
 <img><xsl:attribute name="src"><xsl:value-of select="." /></xsl:attribute></img>
 </xsl:template>

<xsl:template match="a">
 <a><xsl:attribute name="href"><xsl:value-of select="." />.xml</xsl:attribute>
  <u><xsl:value-of select="." /></u></a>;
 </xsl:template>

</xsl:stylesheet>
