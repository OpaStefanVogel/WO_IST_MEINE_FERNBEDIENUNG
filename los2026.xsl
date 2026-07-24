<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html> <!--xmlns='http://www.w3.org/1999/xhtml'-->
    <head>
      <meta http-equiv="expires" content="0"/>
      <link rel="stylesheet" type="text/css" href="los2025.css"/>
      <style>
        STROM {border:double}
        .http {color:orange; display:flex; white-space:pre-wrap; overflow:auto}
        </style>
      <script><![CDATA[ 
function init() {
   el=document.getElementById("copy_of");
//alert(el.lastChild.firstChild.nodeName+" wird zur Zeit neu gestaltet");
  }
function liste(tagname) {
  del=document.getElementById("ergänz");
  del.removeChild(del.lastChild);
  tl=document.getElementsByTagName(tagname);
//  alert(tl.length);
//  alert(tl[0].nodeName);
//  alert(tl[0].firstChild.nodeValue);
  textteil="";
  divges=document.createElement("ol");
  for (var i=0;i<tl.length;i++) {
    //alert(tl[i].normalize());
    divel=document.createElement("li");
    divel.setAttribute("liste","liste");
    dive=tl[i].cloneNode(true);
    divel.appendChild(dive);
    divges.appendChild(divel);
    }
  textel=document.createTextNode("\n<"+tagname+"></"+tagname+">");
  divel.appendChild(textel);
  del.appendChild(divges);
//  alert(textteil);
  }
         ]]></script>
      </head>
    <body class="los" onload="init()" onclick='if (debug.checked) alert(event.target.outerHTML)'>
      <span><input id='debug' type='checkbox'/> debug</span>,
      <a href="#letztes_ok" class="button">zum letzten ok</a>
      <xsl:apply-templates />
 <!-- <u id="copy_of" style="display:none"><xsl:copy-of select="." /></u>
   -->
<script><![CDATA[
function Anfangssumme(tagn) {
  var Liste=document.getElementsByTagName(tagn);
  var Summe=0;
  for (var i=0;i<Liste.length;i++) {
    var text=Liste[i].firstChild.nodeValue;
    if (text==null) text="";
    text=text+" ";
    var pos=text.indexOf(" ");
    if (pos>0) {
      var textanf=text.slice(0,pos);
      if (textanf.slice(0,1)=="=") {
        textanf=textanf.slice(1);
        text=text.slice(1);
        Summe=0
        }
      var wert=eval(textanf);
      var neueSumme=Summe+wert;
      //alert(Summe);
      Liste[i].firstChild.nodeValue=neueSumme+"="+Summe+"+"+text;
      Summe=neueSumme;
      }
    }
  }

Anfangssumme("KWEG");
Anfangssumme("HOLZ");
Anfangssumme("SPAT");
Anfangssumme("SCHUBK");
Anfangssumme("HEU");//als letztes lassen

  ]]></script>
      <xsl:call-template name="ZUSAMMEN">
        <!--<xsl:with-param name="Zaehler" select="BESUCH" />-->
        </xsl:call-template>
      <script src="../../WO_IST_MEINE_FERNBEDIENUNG/REZEPT_UHR.js" type="text/javascript"></script>
      </body>
    </html>
  </xsl:template>


<xsl:template match="letztes_ok">
  <div onload="alert(88)" class="buttonlist" id="letztes_ok">
    <a class="button" target='_blank' href="../../WO_IST_MEINE_FERNBEDIENUNG/SONNE_UND_MOND.xml">ggg<iframe src="../../WO_IST_MEINE_FERNBEDIENUNG/SONNE_UND_MOND.xml" type="text/xml" width="60" height="60"/></a>
    <xsl:for-each select="..//file">
      <xsl:sort select="@id" />
      <span><a class="button"><xsl:attribute name="href">#<xsl:value-of select="@id" /></xsl:attribute>
        <xsl:value-of select="@id" />
        </a> </span>
      </xsl:for-each>
    <xsl:for-each select="//@funkt">
      <xsl:sort select="../@tagname" />
      <span><a class="button" href="#xx"><xsl:attribute name="onclick">liste("<xsl:value-of select="../@tagname" />")</xsl:attribute>
        <xsl:value-of select="../@tagname" />
        </a> </span>
      </xsl:for-each>
    </div>
  </xsl:template>

<xsl:template match="file">
  <div> </div>
  <span>z <a class="file_a">
    <xsl:attribute name="href">#letztes_ok</xsl:attribute>
    <xsl:value-of select="@id" /></a>
  <span class="file">
    <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
    <xsl:apply-templates />
    </span></span>
  </xsl:template>

<xsl:template match="BILD">
  <img><xsl:attribute name="src"><xsl:value-of select="." /></xsl:attribute></img>
  </xsl:template>

<xsl:template match="a">
  <a><xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute>
    <xsl:attribute name="target">_blank</xsl:attribute>
    <u><xsl:value-of select="." /></u></a>
  </xsl:template>

<xsl:template match="sid">
  <a><xsl:attribute name="href">../../gespeicherteOperaSeiten201409/9218.mhtml#14</xsl:attribute>
    <u><xsl:value-of select="." /></u></a>
  </xsl:template>

<xsl:template match="UHR"><span class="UHR" ontouchstart="CLICKI(event)" onclick="CLICKM(event)"
  ontouchmove="DRAGGI(event)"
  angehalten="ja"><xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
  <!--img>
    <xsl:attribute name="src"><xsl:value-of select="$Pfad" />REZEPT_UHR.svg</xsl:attribute>
    </img-->
  <button angehalten="ja">
    <xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
    <xsl:attribute name="Sprich"><xsl:value-of select="@Sprich" /></xsl:attribute>
    <xsl:value-of select="." />
    </button>
  </span>
</xsl:template>

<xsl:template match="TIME">
  <span class="TIME" ontouchstart="CLICKTIME()">
    <xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
    <xsl:value-of select="." />
    </span>
  </xsl:template>

<xsl:template match="BLATT">
  <BLATT class="BLATT">
    <xsl:apply-templates />
    </BLATT>
  </xsl:template>

<xsl:template match="file/BLATT/TIME">
  <span class="BLATTTIME" ontouchstart="CLICKTIME()">
    <xsl:attribute name="Anfangszeit"><xsl:value-of select="." /></xsl:attribute>
    <xsl:value-of select="." />
    </span>
  </xsl:template>

<xsl:template match="NEUMOND">
  <iframe src="SONNE_UND_MOND.xml" type="text/xml" width="120" height="120"/>
  </xsl:template>


<xsl:template match="FREQMESS">
  <span class="FREQMESSRAHMEN">
  im Durchschnitt <span class="FREQMESS">00.0</span> je Minute 
  bei <span class="FREQMESS">--</span> Pochern 
  <span class="FREQMESS" ontouchstart="CLICKFREQMESS()">hier poch</span>
  </span>
  </xsl:template>


<xsl:template match="ab">
  <li class="ab">
    <xsl:apply-templates />
    </li>
  </xsl:template>

<xsl:template match="table"><xsl:copy-of select="." /></xsl:template>
<xsl:template match="h1"><xsl:copy-of select='.'/></xsl:template>
<xsl:template match="span"><xsl:copy-of select='.'/></xsl:template>
<xsl:template match="aktuell"><span id='aktuell'/></xsl:template>
<xsl:template match="ol"><ol style="list-style-position:inside" start="-20"><li>gezählt ab Eisheilige</li><xsl:apply-templates /></ol></xsl:template>

<xsl:template match="x"><input type="checkbox"/></xsl:template>

<xsl:template match="t">
  <span class="tn"><xsl:value-of select="@n" /></span>
  <span>in der Woche <xsl:value-of select="../@woche" /></span>
  <span class="t"><xsl:apply-templates /></span>
  </xsl:template>

<xsl:template match="style"><xsl:copy-of select="." /></xsl:template>
<xsl:template match="script"><xsl:copy-of select="." /></xsl:template>
<xsl:template match="*">
  <xsl:if test="@tagname">
    <style>
      <xsl:value-of select="@tagname"/>:before {content:'<xsl:value-of select="@tagname"/>: '}
      <xsl:value-of select="@tagname"/> {background-color:<xsl:value-of select="@color"/>; opacity: 1 }
      </style>
    <span style='display:block'></span>
    </xsl:if>
  <xsl:copy><xsl:apply-templates /></xsl:copy>
  </xsl:template>

<xsl:template match="Alizee">
<div>
  <!--audio id="Alizee_Player1" src="../../Moi Lolita (alizee) [Mp3glu.eu].mp3" controls="controls" volume="0.5"></audio-->
  <audio id="Alizee_Player" src="../../alizee-moi-lolita.mp3" controls="controls" volume="0.5"></audio>
</div>
  </xsl:template>

<xsl:template match="Al">
<span class="Al_class">
  <button><xsl:attribute name="onclick">document.getElementById('Alizee_Player').play();document.getElementById('Alizee_Player').currentTime=<xsl:value-of select="." />;/*alert(<xsl:value-of select="." />);alert(document.getElementById('Alizee_Player').currentTime)*/;document.getElementById('Alizee_Player').requestFullscreen;document.getElementById('Alizee_Player').play()</xsl:attribute><xsl:value-of select="." /></button><button onclick="document.getElementById('Alizee_Player').pause()">Pause</button>
</span> 
  </xsl:template>

<xsl:template name="ZUSAMMEN">ZUSAMMEN
  <!--<xsl:param name="Zaehler" select="7777" />-->
    <hr id="ZUSAMMEN"/><div><xsl:value-of select="..//schn" /></div>
    <a href="#BESU" class="button">BESU</a>
    <a href="#bir" class="button">bir</a>
    <a href="#BUDD" class="button">BUDD</a>
    <a href="#BLAU" class="button">BLAU</a>
    <a href="#DROH" class="button">DROH</a>
    <a href="#ERNT" class="button">ERNT</a>
    <a href="#Heu" class="button">Heu</a>
    <a href="#KARTOFFRAUS" class="button">KARTOFFRAUS</a>
    <a href="#maeh" class="button">mäh</a>
    <a href="#MPLA" class="button">MPLA</a>
    <a href="#POCH" class="button">POCH</a>
    <a href="#schn" class="button">schn</a>
    <a href="#STROM" class="button">STROM</a>
    <a href="#WER" class="button">WER</a>
    
    <span class="zusammen" id="MPLA">MPLA</span>
    <ol>
    <xsl:for-each select="//MPLA">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="BLAU">BLAU</span>
    <ol>
    <xsl:for-each select="//BLAU">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="WER">WER</span>
    <ol>
    <xsl:for-each select="//WER">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="schn">schn</span>
    <xsl:for-each select="//schn">
      <div><xsl:value-of select="." /></div>
      </xsl:for-each>
    <hr/>
    <hr/>$Zaehler
    <xsl:for-each select="//BESUCH">
      <xsl:value-of select="../@n" />
      <div><xsl:value-of select="." /></div>
      </xsl:for-each>
    <hr/>
    <hr/>
    <xsl:for-each select="//BLAU">
      <xsl:value-of select="../@n" />
      <div><xsl:value-of select="." /></div>
      </xsl:for-each>
    <hr/>
    <hr/>
    <span class="zusammen" id="Heu">Heu</span>
    <ol>
    <xsl:for-each select="//Heu">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="maeh">mäh</span>
    <ol>
    <xsl:for-each select="//mäh">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="bir">bir</span>
    <ol>
    <xsl:for-each select="//bir">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <span class="zusammen" id="ERNT">ERNT</span>
    <ol><xsl:for-each select="//ERNT">
      <li>
        <span><xsl:value-of select="../../TIME" />+<xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="BUDD">BUDD</span>
    <ol><xsl:for-each select="//BUDD">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="DROH">DROH</span>
    <ol><xsl:for-each select="//DROH">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="BESU">BESU</span>
    <ol>
    <xsl:for-each select="//BESU">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="STROM">STROM</span>
    <ol>
    <xsl:for-each select="//STROM">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
    <hr/>
    <hr/>
    <span class="zusammen" id="POCH">POCH</span>
    <ol><xsl:for-each select="//POCH">
      <li>
        <span><xsl:value-of select="../@n" />: </span>
        <xsl:value-of select="." />
        </li>
      </xsl:for-each></ol>
      <a href="pochpoch.xml" target="_blank">pochpoch.xml</a>
    <hr/>
    <hr/>
    <span class="zusammen" id="KARTOFFRAUS">KARTOFFRAUS </span> <a href="KARTOFFELN.xml" target="_blank">Diagramm </a> <a href="los2019.xml#KARTOFFRAUS">2019 </a> <a href="los2018.xml#KARTOFFRAUS">2018 </a> <a href="los2017.xml#KARTOFFRAUS">2017 </a> <a href="los2016.xml#KARTOFFRAUS">2016 </a> <a href="los2015.xml#KARTOFFRAUS">2015 </a>
    <table style="white-space:wrap" border="0">
      <tr><td>wann</td><td>m</td><td>mges</td><td>Eim</td><td>Eimges</td><td>Sk</td><td>Skges</td><td>ki</td><td>kiges</td><td>ka</td><td>kages</td><td>sonst</td><td>g</td><td>gges</td><td>Bem.</td></tr>
      <xsl:for-each select="//KARTOFFRAUS">
        <tr>
          <td><xsl:value-of select="../@n" />-<xsl:value-of select="./t" /></td>
          <td><xsl:value-of select="./m" /></td><td class="mges">0</td>
          <td><xsl:value-of select="./e" /></td><td class="eges">0</td>
          <td><xsl:value-of select="./s" /></td><td class="sges">0</td>
          <td><xsl:value-of select="./ki"/></td><td class="iges">0</td>
          <td><xsl:value-of select="./ka"/></td><td class="ages">0</td>
          <td><xsl:value-of select="./w" /></td>
          <td><xsl:value-of select="./g" /></td><td class="gges">0</td>
          <td class="bem"><xsl:value-of select="./bem" /></td>
          </tr>
        </xsl:for-each>
      <tr><td colspace="3"><hr/></td></tr>
      <xsl:for-each select="//KARTOFFRAU2">
        <tr>
          <td><xsl:value-of select="../@n" />-<xsl:value-of select="./t" /></td>
          <td><xsl:value-of select="./m" /></td><td class="mges">0</td>
          <td><xsl:value-of select="./e" /></td><td class="eges">0</td>
          <td><xsl:value-of select="./s" /></td><td class="sges">0</td>
          <td><xsl:value-of select="./ki"/></td><td class="iges">0</td>
          <td><xsl:value-of select="./ka"/></td><td class="ages">0</td>
          <td><xsl:value-of select="./w" /></td>
          <td><xsl:value-of select="./g" /></td><td class="gges">0</td>
          <td class="bem"><xsl:value-of select="./bem" /></td>
          </tr>
        </xsl:for-each>
      <tr><td colspace="3"><hr/></td></tr>
      <xsl:for-each select="//KARTOFFRAU3">
        <tr id="KARTOFFRAU3">
          <td><xsl:value-of select="../@n" />-<xsl:value-of select="./t" /></td>
          <td><xsl:value-of select="./m" /></td><td class="mges">0</td>
          <td><xsl:value-of select="./e" /></td><td class="eges">0</td>
          <td><xsl:value-of select="./s" /></td><td class="sges">0</td>
          <td><xsl:value-of select="./ki"/></td><td class="iges">0</td>
          <td><xsl:value-of select="./ka"/></td><td class="ages">0</td>
          <td><xsl:value-of select="./w" /></td>
          <td><xsl:value-of select="./g" /></td><td class="gges">0</td>
          <td class="bem"><xsl:value-of select="./bem" /></td>
          </tr>
        </xsl:for-each>
      </table>
      <script><![CDATA[
        MGESNAME=["mges","eges","sges","iges","ages","gges"];
        for (var sel in MGESNAME) {
          MGESLIST=document.getElementsByClassName(MGESNAME[sel]);
          //alert(MGESLIST[0].previousSibling.firstChild);
          if (MGESLIST[0].previousSibling.firstChild==null) {
            MGESLIST[0].firstChild.nodeValue=0} else {
              MGESLIST[0].firstChild.nodeValue=
               MGESLIST[0].previousSibling.firstChild.nodeValue;
              }
          for ( var i=1; i<MGESLIST.length;i++) {
            if (MGESLIST[i].previousSibling.firstChild==null) {
              MGESLIST[i].firstChild.nodeValue=0} else {
                MGESLIST[i].firstChild.nodeValue=
                 MGESLIST[i].previousSibling.firstChild.nodeValue;
                }
//alert(MGESLIST[i].parentNode.lastChild.firstChild);
            if (MGESLIST[i].parentNode.lastChild.firstChild==null || MGESLIST[i].parentNode.lastChild.firstChild.nodeValue!="neue Reihe" || sel!=0) {
              MGESLIST[i].firstChild.nodeValue=
                eval(MGESLIST[i].firstChild.nodeValue)+
                eval(MGESLIST[i-1].firstChild.nodeValue);
              }
            }
          }
        ]]></script>
    <hr/>
    <hr/>
    <span class="zusammen" id="KWEG">KWEG</span> 
      <a href="#letztes_ok" class="button">zum letzten ok</a>
    <table style="white-space:wrap" border="0">
      <tr><td>wann</td><td>ki</td><td>kiges</td><td>ka</td><td>kages</td><td>wohin</td><td>g</td><td>gges</td><td>Bem.</td></tr>
      <xsl:for-each select="//KWEG">
        <tr>
          <td><xsl:value-of select="../../TIME" />+<xsl:value-of select="../@n" />: </td>
          <td><xsl:value-of select="./ki"/></td><td class="ige2">20</td>
          <td><xsl:value-of select="./ka"/></td><td class="age2">30</td>
          <td><xsl:value-of select="./w" /></td>
          <td><xsl:value-of select="./g" /></td><td class="gge2">40</td>
          <td><xsl:value-of select="./b" /></td>
          </tr>
        </xsl:for-each>
      </table>
      <script><![CDATA[//alert("KWEG");
        MGESNAME=["ige2","age2","gge2"];
        for (var sel in MGESNAME) {//alert(sel);
          MGESLIST=document.getElementsByClassName(MGESNAME[sel]);
          MGESLIST[0].firstChild.nodeValue=
            eval(MGESLIST[0].previousSibling.firstChild.nodeValue);
          for ( var i=1; i<MGESLIST.length;i++) {
            MGESLIST[i].firstChild.nodeValue=
              eval(MGESLIST[i].previousSibling.firstChild.nodeValue);
            if (MGESLIST[i].parentNode.lastChild.firstChild.nodeValue!="neue Ernte"||sel==2) {
              MGESLIST[i].firstChild.nodeValue=
                eval(MGESLIST[i].firstChild.nodeValue)+
                eval(MGESLIST[i-1].firstChild.nodeValue);
              } else {
                MGESLIST[i].firstChild.nodeValue=
                  eval(MGESLIST[i].firstChild.nodeValue);
                }
            }
          }
        ]]></script>
    <hr/>
    <hr/>
  </xsl:template>

<xsl:template match="http">
<div class='http'><xsl:value-of select="."></xsl:value-of></div> 
  </xsl:template>

</xsl:stylesheet>
