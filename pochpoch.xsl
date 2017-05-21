<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <!--link rel="stylesheet" type="text/css" href="los.css" /-->
      <style type="text/css">
.FREQMESSRAHMEN {
  border:double;
  border-color:rgb(188,0,0);
  display:inline-block; 
  white-space:normal; 
  padding:10px;
  }
.FREQMESS {
  display:inline-block;
  font-size:300%;
  outline: dashed;
  background: yellow ;
  outline-color:white;
  padding-top:40px;
  padding-bottom:40px;
  }
        </style>
      <script type="application/ecmascript"><![CDATA[
//alert(document.documentElement.namespaceURI);
//fuer FREQMESS:
var FREQMESS=0;
var FREQMESSMERK=0;
var FREQMESSDIFF=0;
var FREQMESSSUM=0;
var FREQMESSCOUNT=0;
var FREQMESSDISP="00";
var FREQ=0;
function CLICKFREQMESS() {
  event.preventDefault();
  node=event.target;
//alert(screen.height);
//alert(screen.availHeight);
//alert(navigator.userAgent);
//scrollBy(10,10);
  FREQMESS=new Date();
  FREQMESSDIFF=FREQMESS-FREQMESSMERK;
  if (2000 > FREQMESSDIFF && FREQMESSDIFF > 300 ) {
    clearTimeout(pochtimer);
    FREQMESSCOUNT=FREQMESSCOUNT+1;
    FREQMESSSUM=FREQMESSSUM+FREQMESSDIFF;
    FREQ=(60000*FREQMESSCOUNT/(FREQMESSSUM)).toFixed(1);
    node.previousSibling.previousSibling.previousSibling.previousSibling.lastChild.nodeValue=FREQ;
    if (10>FREQMESSCOUNT) {FREQMESSDISP="0"+FREQMESSCOUNT} else {FREQMESSDISP=FREQMESSCOUNT}
    node.previousSibling.previousSibling.lastChild.nodeValue=FREQMESSDISP;
    } else {
      FREQMESSSUM=0;
      FREQMESSCOUNT=0;
      node.previousSibling.previousSibling.previousSibling.previousSibling.lastChild.nodeValue="00.0";
      node.previousSibling.previousSibling.lastChild.nodeValue="00";
      }
  FREQMESSMERK=FREQMESS;
  pochnode=node;
  pochtimer=setTimeout(function(){pochnode.previousSibling.previousSibling.lastChild.nodeValue="--"},2000);
  }
]]>        </script>
      </head>
    <body class="los">
      <xsl:apply-templates />
      
      </body>
    </html>
  </xsl:template>
 
<xsl:template match="FREQMESS">
  <span class="FREQMESSRAHMEN">
  im Durchschnitt <span class="FREQMESS">00.0</span> je Minute 
  bei <span class="FREQMESS">--</span> Pochern 
  <span class="FREQMESS" ontouchstart="CLICKFREQMESS()">hier poch</span>
  </span>
  </xsl:template>


</xsl:stylesheet>
