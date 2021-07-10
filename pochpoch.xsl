<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <!--link rel="stylesheet" type="text/css" href="los.css" /-->
      <title>pochpoch.xml</title>
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
  font-family:Courier,monospace;
  font-size:500%;
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
var FREQMESSDIFFMERK=[];
var YPOS=0;
var XPOS=0;
var Logtext="";
function CLICKFREQMESS() {
  event.preventDefault();
  node=event.target;
//alert(screen.height);
//alert(screen.availHeight);
//alert(navigator.userAgent);
//scrollBy(10,10);
  FREQMESS=new Date();
  FREQMESSDIFF=FREQMESS-FREQMESSMERK;
  var Graph=document.getElementById("Graph");
  var Graph2=document.getElementById("Graph2");
  var Gtext=document.getElementById("Gtext");
  if (2000 > FREQMESSDIFF && FREQMESSDIFF > 300 ) {
    clearTimeout(pochtimer);
    FREQMESSDIFFMERK.push(FREQMESSDIFF);
    FREQMESSCOUNT=FREQMESSCOUNT+1;
    FREQMESSSUM=FREQMESSSUM+FREQMESSDIFF-FREQMESSDIFFMERK.shift();
    FREQ=(60000*Math.min(FREQMESSCOUNT,FREQMESSDIFFMERK.length)/FREQMESSSUM);
    node.previousSibling.previousSibling.previousSibling.previousSibling.lastChild.nodeValue=FREQ.toFixed(1);
    if (10>FREQMESSCOUNT) {FREQMESSDISP="0"+FREQMESSCOUNT} else {FREQMESSDISP=FREQMESSCOUNT}
    node.previousSibling.previousSibling.lastChild.nodeValue=FREQMESSDISP;
    var neue_Linie=Graph.cloneNode();
    neue_Linie.setAttribute("x1",XPOS); XPOS=XPOS+4;
    neue_Linie.setAttribute("x2",XPOS);
    neue_Linie.setAttribute("y1",YPOS); YPOS=FREQMESSDIFF/4-100;
    neue_Linie.setAttribute("y2",YPOS);
    Graph.parentNode.appendChild(neue_Linie);
    var neue_Linie=Graph2.cloneNode();
    neue_Linie.setAttribute("x1",XPOS-4);
    neue_Linie.setAttribute("x2",XPOS);
    neue_Linie.setAttribute("y1",60000/FREQ/4-100);
    neue_Linie.setAttribute("y2",60000/FREQ/4-100);
    Graph.parentNode.appendChild(neue_Linie);
    } else {
      FREQMESSSUM=0;
      FREQMESSCOUNT=0;
      FREQMESSDIFFMERK=Array(60).fill(0);
      node.previousSibling.previousSibling.previousSibling.previousSibling.lastChild.nodeValue="00.0";
      node.previousSibling.previousSibling.lastChild.nodeValue="00";
      YPOS=0;
      XPOS=XPOS+8;
      }
  document.getElementById("svg").scrollTo({
    top: 0,
    left: Math.max(0,XPOS-600),
    behavior: 'smooth'
    });
  FREQMESSMERK=FREQMESS;
  pochnode=node;
  pochtimer=setTimeout(function(){
    var Ntext=Gtext.cloneNode(true);
    if (FREQMESSCOUNT>20) {
      Ntext.setAttribute("x",XPOS-80);
      var t=(new Date()).toTimeString().slice(0,5);
      Ntext.firstChild.nodeValue=t+" "+FREQ.toFixed(1);
      Logtext=Logtext+"<div>"+t+" "+FREQ.toFixed(1)+" "+FREQMESSCOUNT+"</div>\n";
      var Logfile=document.getElementById("Logfile")
      Logfile.innerHTML=Logtext;
      Logfile.scrollTop = Logfile.scrollHeight;
      selectText("Logfile");
      } else {
        Ntext.setAttribute("x",XPOS-10);
        Ntext.firstChild.nodeValue="-";
        }
    Gtext.parentNode.appendChild(Ntext);
  
    pochnode.previousSibling.previousSibling.lastChild.nodeValue="--"
    },2000);
  }

function selectText(element) { //Quelle: https://gist.github.com/gubatron/6599366
    var doc = document
        , text = doc.getElementById(element)
        , range, selection
    ;
    if (doc.body.createTextRange) { //ms
        range = doc.body.createTextRange();
        range.moveToElementText(text);
        range.select();
    } else if (window.getSelection) { //all others
        selection = window.getSelection();        
        range = doc.createRange();
        range.selectNodeContents(text);
        selection.removeAllRanges();
        selection.addRange(range);
    }
  }
]]>        </script>
      </head>
    <body class="los">
      <xsl:apply-templates />

<div id="svg" style="display:flex; flex-direction:column; overflow:auto; white-space:nowrap">
      <svg width="20000px" height="250px" >
        <line stroke="gray" x1="0" y1="150" x2="20000" y2="150" />
        <line stroke="black" x1="1000" y1="0" x2="1200" y2="150" />
        <line stroke="orange" x1="0" y1="114" x2="20000" y2="114" />
        <line stroke="darkred" x1="0" y1="87" x2="20000" y2="87" />
        <line stroke="violet" x1="0" y1="66" x2="20000" y2="66" />
        <line id="Graph" stroke="gray" stroke-width="1" x1="0" y1="0" x2="0" y2="0" />
        <line id="Graph2" stroke="blue" stroke-width="2" x1="0" y1="0" x2="0" y2="0" />
        <text id="Gtext" x="0" y="20" fill="black" stroke="black">-</text>

        </svg>
  </div>
<div id="Logfile" style="display:flex; flex-direction:column; overflow:auto; height:150px; width:400px; border:solid; border-color:grey; white-space:pre; font-family:Courier,monospace; font-size:200%" ontouchstart="selectText('Logfile')">    </div>

      </body>
    </html>
  </xsl:template>

<xsl:template match="FREQMESS">
  <span class="FREQMESSRAHMEN">
  im Durchschnitt <span class="FREQMESS">00.0</span> je Minute 
  bei <span class="FREQMESS">--</span> Pochern 
  <span class="FREQMESS" ontouchstart="event.preventDefault();" ontouchend="CLICKFREQMESS()">hier poch</span>
  </span>
  </xsl:template>


</xsl:stylesheet>
