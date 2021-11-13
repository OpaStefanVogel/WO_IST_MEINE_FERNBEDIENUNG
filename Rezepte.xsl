<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="Pfad" select="'Repositories/WO_IST_MEINE_FERNBEDIENUNG/'"/>
<xsl:template match="/REZEPTE">
<html>
 <head>
   <title>Rezepte</title>
   <link rel="stylesheet" type="text/css">
     <xsl:attribute name="href"><xsl:value-of select="$Pfad" />Rezepte.css</xsl:attribute>
     </link>
   <style>button {font-size:100%}</style> 
   </head>
<body class="REZEPT">
  <xsl:for-each select="//TITEL">
    <a>
      <xsl:attribute name="href">#<xsl:value-of select="." /></xsl:attribute>
      <xsl:attribute name="style">background-color:<xsl:value-of select="@ok"/></xsl:attribute>
      <xsl:value-of select="." />
      </a>,
    </xsl:for-each>
  <div style="height:600px"> </div>
  <xsl:apply-templates />
  <textarea cols="120" rows="20"><xsl:for-each select="//REZEPTE">
      <xsl:copy-of select="." />
      </xsl:for-each>
    </textarea>
<script type="text/javascript">
  <xsl:attribute name="src"><xsl:value-of select="$Pfad" />REZEPT_UHR.js</xsl:attribute>
  </script>
  </body></html>
</xsl:template>

<xsl:template match="UHR">
<span class="UHR" ontouchstart="CLICKI(event)"
  ontouchmove="DRAGGI(event)"
  angehalten="ja"><xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
  <img>
    <xsl:attribute name="src"><xsl:value-of select="$Pfad" />REZEPT_UHR.svg</xsl:attribute>
    </img>
  <button angehalten="ja"><xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute><xsl:value-of select="." /></button>
  </span>
</xsl:template>

<xsl:template match="REZEPT">
  <xsl:apply-templates />
  <div style="height:100px"> </div>
  <textarea cols="120" rows="20"><xsl:copy-of select="." />
    </textarea>
  <div style="height:600px"> </div>
  </xsl:template>



<xsl:template match="TITEL">
<div><span class="TITEL" style="vertical-align:top"><xsl:attribute name="id"><xsl:value-of select="." /></xsl:attribute>Rezept</span>
<svg style="border:solid" width="90%" height="110px" font-family="Helvicta" font-style="">
<text transform="scale(6,4) rotate(0) translate(0,16)" stroke="red" fill="green">
  * * * <xsl:value-of select="." /> * * *
   <xsl:value-of select="." /> * * *
    <xsl:value-of select="." /> * * *
     <xsl:value-of select="." /> * * *
      <xsl:value-of select="." /> * * *
   <xsl:value-of select="." /> * * *
    <xsl:value-of select="." /> * * *
     <xsl:value-of select="." /> * * *
      <xsl:value-of select="." /> * * *
   <xsl:value-of select="." /> * * *
    <xsl:value-of select="." /> * * *
     <xsl:value-of select="." /> * * *
      <xsl:value-of select="." /> * * *
   <xsl:value-of select="." /> * * *
    <xsl:value-of select="." /> * * *
     <xsl:value-of select="." /> * * *
      <xsl:value-of select="." /> * * *
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

<xsl:template match="BILD">
 <img><xsl:attribute name="src"><xsl:value-of select="." /></xsl:attribute></img>
 </xsl:template>

<xsl:template match="a[@href]">
 <a><xsl:attribute name="href"><xsl:value-of select="@href" /></xsl:attribute>
  <xsl:attribute name="target">_blank</xsl:attribute>
  <u><xsl:value-of select="." /></u></a>
 </xsl:template>

<xsl:template match="a">
 <a><xsl:attribute name="href">#<xsl:value-of select="." /></xsl:attribute>
  <u><xsl:value-of select="." /></u></a>
 </xsl:template>

<xsl:template match="*">
 <xsl:copy-of select="." />
 </xsl:template>

</xsl:stylesheet>
