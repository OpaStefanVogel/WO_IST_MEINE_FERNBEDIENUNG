<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="FERNBEDIENUNG">
<html>
<head>
  <title>KODI Remote</title>
<style type="text/css"> 
body {  font-size:100%; border:solid; margin-right:120px; 
  padding:0px;
  }
button { font-size:300%; 
  background-color:LightPink; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  flex-grow: 1;
  flex-basis: auto;
  }
.button { font-size:300%; 
  background-color:HotPink; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  flex-grow: 1;
  flex-basis: auto;
  }
.buttonGUI { font-size:300%; 
  background-color:LightGreen; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
#  flex-grow: 1;
#  flex-basis: auto;
  }
.buttonTV { font-size:300%; 
  background-color:aquamarine; 
  border : solid ;
  border-radius: 20px ; 
  margin : 3px ;
#  flex-grow: 1;
#  flex-basis: auto;
  }
.butstop { font-size:300%; 
  background-color:orange; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.butsys { font-size:300%; 
  background-color:gold; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.butmess { font-size:300%; 
  background-color:LimeGreen; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.butamp { font-size:300%; 
  background-color:dodgerblue; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.buttonTemp { font-size:300%; 
  background-color:lavender; 
  border : double ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.buttonSTEREOMOD { font-size:300%; 
  background-color:LightBlue; 
  border : solid ;
  border-radius: 30px ; 
  margin : 3px ;
  }
.message { white-space:pre-wrap; font-family:Courier,monospace; font-size:90%; width:800px; border: 1px black solid; }
textarea { white-space:wrap; font-family:Courier,monospace; font-size:90%}
svg { font-size:150%; border:solid; border-color:cyan; font-family:Courier,monospace; }

  .kursiv { font-style:italic; background-color:aqua; }
  .tab { background-color:#FFFF66; font-family:Courier,monospace; color:rgb(0,0,256); padding:6px; margin:0px;
         font-size:120%; text-align:right; padding:6px; margin:8px; }
  .joy { font-family:Courier,monospace; width:80px; height:80px; }
  .rosa { background-color:#FFDDDD; }
  .gelbbox { background-color:#FFFF66; padding:6px; margin:0px; }
  .gelb { background-color:#FFFF66; padding:6px; margin:8px; } 

.butbut { 
  font-size:800%; 
  background-color:pink;   
  border : solid ;
  margin: 5px ;
  border-radius: 40px ; 
  }
.butconnect { 
  font-size:250%; 
  background-color:grey;   
  border : solid ;
  margin: 5px ;
  border-radius: 40px ; 
  }

.smalltext { font-size: 50%; }
.inputws { font-family:Courier,monospace; }
#STATUS { float : right ; color : red ; }
#hier0, .hier0x, .flexibel {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  }

. zentriert { 
  display: flex;
  align-items: center;
  }

@media all and (max-width: 100px) {

#hier0 {
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  flex-grow: 1;
  flex-basis: auto;
  } }

</style> 
<!--
  body { font-family:Arial; font-size:100%; }
  canvas { border: 1px solid black; }
  L { background-color:#FFFF66; } 
-->
<script type="application/ecmascript">
<![CDATA[
var websocket=JSON.parse ( ' { "readyState" : 3 } ' ) ;
var VORHERIGE_TASTE=0;
var TASTE=0;
var hier0=3;
var da0=3;
function init() {
//  output = document.getElementById("output");
// alert(document.getElementById("inputws").getAttribute("value"));
  websocket = new WebSocket(document.getElementById("inputws").value); 
//  alert(document.getElementById("inputws").value);
  websocket.onopen = function() {
    document.getElementById("connectbox").setAttribute("style","display:none");
    writeToPage("CONNECTED");
    doSend4b();doSend03();
    doSend0('Input.Action','type');
    doSend0('GUI.Window','type')
    }; 
  websocket.onclose = function() {
    writeToPage("DISCONNECTED")
    document.getElementById("connectbox").setAttribute("style","display:block");
    }; 
  websocket.onmessage = function() {
    var v;
    w=event.data;
    writeToScreen(w);
    Behelfsantwort(w);
    }; 
  websocket.onerror = function() { writeToScreen(event.data) };
  initTemp();
  }
function ws_close() {
//  alert("Websocket wird jetzt geschlossen");
  websocket.close();
  writeToScreen("CLOSING....................");
  //event.preventDefault();
  wsTemp_close();
  }
function doSend(message) {
  if (event.target!=websocket) {
    TASTE=event.target;
    TASTE.setAttribute("style","background-color:DeepPink");
    writeToLogArea(message);
    //setTimeout(Behelfsantwort,500);
    event.preventDefault();
    if (websocket.readyState==3) {alert('erst oben am Seitenanfang mit (connect) die Seite mit Kodi verbinden')};
    }
  websocket.send(message);
  } 
function writeToScreen(message) { 
//  document.getElementById('output').firstChild.nodeValue=message;
  d=(new Date());
  document.getElementById('logarea').value=
  "IN  "+(new Date()).toLocaleTimeString()+" "+message+"\n"+
  document.getElementById('logarea').value;
  } 
function writeToPage(message) { 
  document.getElementById('STATUS').firstChild.nodeValue=message;
  writeToScreen(message);
  } 
function writeToLogArea(message) {
  d=(new Date());
//alert((new Date()).toLocaleTimeString()); 
  document.getElementById('logarea').value=
  "OUT "+(new Date()).toLocaleTimeString()+" "+message+"\n"+
  document.getElementById('logarea').value;
  } 

function Behelfsantwort(w){
  if (VORHERIGE_TASTE!=0) {VORHERIGE_TASTE.removeAttribute("style")}
  if (TASTE!=0) {VORHERIGE_TASTE=TASTE;
    VORHERIGE_TASTE.setAttribute("style","background-color:DarkGrey");
    }
  var mw=JSON.parse(w);
  var mw2=JSON.parse(w.replace('{"Input.','{"InputX'));
  var mw3=JSON.parse(w.replace('{"GUI.','{"GUIX'));
  if (mw.id=="VideoGetItem") {alert("Es läuft "+w)}; 
  if (mw.id=="GetFavourites") {Favoritentasten(mw.result.favourites)}; 
  if (mw.id=="Input.Action") {Inputtasten(mw2.result.types.InputXAction.enums,"hier1","Input","")}; 
  if (mw.id=="GUI.Window") {Inputtasten(mw3.result.types.GUIXWindow.enums,"hier2","GUI","buttonGUI")}; 
  if (mw.id=="getChannels") {Channels(mw.result.channels,"hier0","doSend05","buttonTV")}; 
  if (mw.id=="getChannelGroups") {ChannelGroups(mw.result.channelgroups)}; 
  };

function OhneKlammern(str) {
  var neu="";
  var flag=1;
  for ( var i=1; i<str.length-1;i++) {
    var char=str.charAt(i);
    if (char=="[") {flag=0};
    if (flag==1) {neu=neu+char};
    if (char=="]") {flag=1};
    }
  return neu;
  }

function Favoritentasten(mfw) {
  for ( var i=0; i<mfw.length;i++) {
//    alert(JSON.stringify(mfw[i].title));
//    alert(OhneKlammern(JSON.stringify(mfw[i].title)));
    var cl2 = document.createElement("button");
    var cl3 = document.createTextNode(OhneKlammern(JSON.stringify(mfw[i].title)));
    cl2.appendChild(cl3);
    cl2.setAttribute("onclick","doSend4aaaa('"+mfw[i].path+"')");
//    alert(cl3+cl2.firstChild);
    document.getElementById('FavoritenHierHer').appendChild(cl2);
    }
  }

function Inputtasten(mfw,wohin,wasmach,buttonclass) {
//alert(JSON.stringify(mfw));
  for ( var i=0; i<mfw.length;i++) {
//    alert(JSON.stringify(mfw[i].title));
//    alert(OhneKlammern(JSON.stringify(mfw[i].title)));
    var cl2 = document.createElement("button");
    var cl3 = document.createTextNode(OhneKlammern(JSON.stringify(mfw[i])));
    cl2.appendChild(cl3);
    cl2.setAttribute("class",buttonclass);
    cl2.setAttribute("onclick",wasmach+"('"+mfw[i]+"')");
//    alert(cl3+cl2.firstChild);
    document.getElementById(wohin).appendChild(cl2);
    }
  }

function Channels(mfw,wohin,wasmach,buttonclass) {
//alert(JSON.stringify(mfw));
//alert("wohin="+wohin+da0);
  for ( var i=0; i<mfw.length;i++) {
    var label=OhneKlammern(JSON.stringify(mfw[i].label));
//    if (label.slice(-2)!="HD") {
      var cl2 = document.createElement("button");
      var cl3 = document.createTextNode(label);
      cl2.appendChild(cl3);
      cl2.setAttribute("class",buttonclass);
      cl2.setAttribute("onclick",wasmach+"('"+mfw[i].channelid+"')");
//    alert(cl3+cl2.firstChild);
      document.getElementById(wohin+da0).appendChild(cl2);
//      }
    }
  da0=da0+1;
//  alert(da0);
  }
var ind=0;
var indmfw=0;
function TO(){
  //alert(ind);
  //alert(indmfw[ind].channelgroupid);
  //04(5);
  doSend04(indmfw[ind].channelgroupid);
  //alert(ind+"fertig");
  ind=ind+1};

function ChannelGroups(mfw) {
//alert(JSON.stringify(mfw));
  hier0=3;da0=3;indmfw=mfw;ind=1;
  for ( var i=1; i<mfw.length;i++) {
    var cl2 = document.createElement("div");
    var cl3 = document.createTextNode(mfw[i].label);
    cl2.appendChild(cl3);
    cl2.setAttribute("id","hier0"+hier0);
    cl2.setAttribute("class","hier0x");
    document.getElementById("hier0").appendChild(cl2);
    setTimeout(TO,i*300);
    //doSend04(mfw[i].channelgroupid);
    hier0=hier0+1;
    }
  hier0=3;
  }


function doSend0(id,type) { doSend('{ "jsonrpc": "2.0", "method": "JSONRPC.Introspect", "params": { "filter": { "id": "'+id+'", "type": "'+type+'" } }, "id": "'+id+'" }'); };

function doSend03() { doSend('{ "jsonrpc": "2.0", "method": "PVR.getChannelGroups", "params": { "channeltype": "tv" }, "id": "getChannelGroups"}'); };

function doSend04(chgrid) { websocket.send('{ "jsonrpc": "2.0", "method": "PVR.getChannels", "params": { "channelgroupid": '+chgrid+' }, "id": "getChannels" }'); };

function doSend05(chid) { doSend('{"jsonrpc":"2.0","id":1,"method":"Player.Open","params":{"item":{"channelid":'+chid+'}}}'); };


function doSend1(i,m) { doSend('{"id":'+i+',"jsonrpc":"2.0","method":"'+m+'"}'); };

function doSend2() { doSend('{"id":2,"jsonrpc":"2.0","method":"Input.Back"}'); };

function doSend3() { doSend('{"id":3,"jsonrpc":"2.0","method": "Player.Open", "params":{"item": {"file": "plugin://plugin.video.live.streams/?url=http://zdf_hds_de-f.akamaihd.net/i/de14_v1@147090/master.m3u8&mode=12" } } }');
//alert("ZDF");
 };

function doSend4() { doSend('{"id":4  ,"jsonrpc":"2.0","method": "Player.Open", "params":{"item": {"file": "plugin://plugin.video.live.streams/?url=http://daserste_live-lh.akamaihd.net/i/daserste_de@91204/master.m3u8&mode=12" } } }');
  };
function doSend4aaaa(mfhw) { doSend('{"id":4,"jsonrpc":"2.0","method": "Player.Open", "params":{"item": {"file": "'+mfhw+'" } } }');
  };
function doSend4aaaab(mfhw) { doSend('{"jsonrpc":"2.0","method":"Addons.ExecuteAddon","params":{"addonid":"'+mfhw+'"},"id":1}');
  };
function doSend4aaaac(mfhw) { doSend('{"jsonrpc":"2.0","method":"GUI.ActivateWindow","params":{"window":"video","parameters":["plugin://plugin.video.zdf_de_lite/?mode=listVideos&url=http%3a%2f%2fwww.zdf.de%2fZDFmediathek%2fkanaluebersicht%2faktuellste%2f1829656"]},"id":1}');
  };

function doSend4b() { doSend('{ "jsonrpc": "2.0", "method": "Favourites.GetFavourites", "params": { "properties": ["window","path","thumbnail","windowparameter"] }, "id": "GetFavourites" }');
 };

function doSend5() { doSend('{"id":5,"jsonrpc":"2.0","method":"System.Shutdown"}'); };

function doSend6() { doSend('{"id":6,"jsonrpc":"2.0","method":"System.Reboot"}'); };

function doSend7() { doSend('{"id":7,"jsonrpc":"2.0","method":"Player.PlayPause","params":{"playerid":1}}'); };

function doSend8() { doSend('{"id":8,"jsonrpc":"2.0","method":"Player.Stop","params":{"playerid":1}}'); };

function Input(action) {doSend('{"id":9,"jsonrpc":"2.0","method":"Input.ExecuteAction","params":{"action":"'+action+'"}}');};

function doSend10(message) {doSend('{"id":10,"jsonrpc":"2.0","method":"GUI.ShowNotification","params":{"title":"Hallo liebe Frau Boes","message":"'+message+'","image":"info","displaytime":20000}}');};

function doSend11(message) {doSend('{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "season", "episode", "duration", "showtitle", "tvshowid", "thumbnail", "file", "fanart", "streamdetails"], "playerid": 1 }, "id": "VideoGetItem"}');};

function GUI(action) {doSend('{"id":9,"jsonrpc":"2.0","method":"GUI.ActivateWindow","params":{"window":"'+action+'"}}');};

function doSend13() { 
//popup(["234"]);
open("file://localhost/mnt/external_sd/StefanX10mini/BackUpToDropBoxSyn/SVG_selbst_ausgedacht/TOLINO.xml#Sun");
open("file://localhost/mnt/external_sd/StefanX10mini/BackUpToDropBoxSyn/SVG_selbst_ausgedacht/TOLINO.xml#Sun");
doSend('{"id":13,"jsonrpc":"2.0", "method": "Favourites.GetFavourites", "params": { "properties": ["window","path","thumbnail","windowparameter"] }}'); 
};



function STEREOMO(action) {doSend('{"id":9,"jsonrpc":"2.0","method":"GUI.SetStereoscopicMode","params":{"mode":"'+action+'"}}');};



/*

*/
var websocketTemp=0;
function initTemp() {
  if (websocketTemp) {websocketTemp.close()}
  websocketTemp = new WebSocket(document.getElementById("inputwsTemp").value,"fiktiv"); 
  websocketTemp.onmessage = function() { writeToScreenTemp(event.data); }; 
  }

function wsTemp_close() {
  websocketTemp.close();
  writeToScreenTemp("--.-- °C");
  }

function writeToScreenTemp(message) {
  document.getElementById('outputTemp').firstChild.nodeValue=message;
  }



//neu in H02
function doSendSTREAM(href) {
  doSend('{ "id": "STREAM", "jsonrpc": "2.0", "method": "Player.Open", "params": { "item": { "file": "plugin://plugin.video.live.streams/?url='+href+'" } } }')
  }

function doSendPLAYER(method) {
  doSend('{"id":"PLAYER","jsonrpc":"2.0","method":"Player.'+method+'","params":{"playerid":1}}'); 
  };

function doSendSYSTEM(method) {
  doSend('{"id":"SYSTEM","jsonrpc":"2.0","method":"System.'+method+'"}');
  };

function doSendMESSAGE(title,message,displaytime) {
doSend('{"id":10,"jsonrpc":"2.0","method":"GUI.ShowNotification","params":{"title":"'+title+'","message":"'+message+'","image":"info","displaytime":'+displaytime+'}}');
  };



]]>
</script>

  </head>
<body onload="init()" onclose="ws_close()">
    <xsl:apply-templates />

</body>
</html>

  </xsl:template>

<xsl:template match="hr"><xsl:copy-of select="." /></xsl:template>


<xsl:template match="WEBSOCKET_KODI">
<div id="connectbox" style="display:none">
<small>Diese Seite verwendet Websocket <input id="inputws" class="inputws" value="ws:192.168.1.118:9090/jsonrpc" size="29"/>, also eine Adresse <u>im lokalen Netz!</u> Falls nötig ändern.<span id="STATUS">DISCONNECTED</span></small>
<div>Dann
<button id="erst" type="button" class="butconnect" onclick="init()">connect</button> und los gehts mit den Tasten, wenn fertig wieder
<button id="erst" type="button" class="butconnect" onclick="ws_close()" ontouchstart="ws_close()">disconnect</button>.
</div>
</div>
  </xsl:template>

<xsl:template match="WEBSOCKET_RASPI">
<div>
<small>und <input id="inputwsTemp" class="inputws" value="ws:192.168.1.109:8080/temp" size="29"/> für den Temperatursensor (CPU im Raspberry B).</small>
</div>
  </xsl:template>

<xsl:template match="NEUE_ZEILE">
  <div>
    <xsl:attribute name="id">
      <xsl:value-of select="@id" />
      </xsl:attribute>
    <xsl:attribute name="class">
      <xsl:value-of select="@class" />
      </xsl:attribute>
    <i><xsl:value-of select="@text" /></i>
    <xsl:apply-templates />
    </div>
  </xsl:template>

<xsl:template match="STREAM">
  <button class="butbut">
    <xsl:attribute name="onclick">
      doSendSTREAM('<xsl:value-of select="@href" />');
      </xsl:attribute>
    <xsl:value-of select="@text" />
    </button>
  </xsl:template>

<xsl:template match="PAUSE_WEITER">
  <button id="Pauswei" type="button" class="butbut"
    onclick="doSendPLAYER('PlayPause')">
    <span class="smalltext">
      <div><u>Pause</u></div>
      <div>weiter</div>
      </span>
    </button>
  </xsl:template>

<xsl:template match="PLAYER">
  <button class="butstop">
    <xsl:attribute name="onclick">
      doSendPLAYER('<xsl:value-of select="@method" />');
      </xsl:attribute>
    <xsl:value-of select="@text" />
    </button>
  </xsl:template>

<xsl:template match="SYSTEM">
  <button class="butsys">
    <xsl:attribute name="onclick">
      doSendSYSTEM('<xsl:value-of select="@method" />');
      </xsl:attribute>
    <xsl:value-of select="@text" />
    </button>
  </xsl:template>

<xsl:template match="MESSAGE">
  <button class="butmess">
    <xsl:attribute name="onclick">
      doSendMESSAGE('<xsl:value-of select="@title" />','<xsl:value-of select="@message" />',<xsl:value-of select="@displaytime" />);
      </xsl:attribute>
    <xsl:value-of select="@text" />
    </button>
  </xsl:template>

<xsl:template match="TEMPERATUR">
  <button id="outputTemp" type="button" 
    class="buttonTemp" onclick="StartStop()" title="°C" >
    --.- °C
    </button>
  </xsl:template>

<xsl:template match="WAS_LÄUFT">
  <button class="butbut" onclick="doSend11()">Was läuft?</button>
  </xsl:template>

<xsl:template match="WETTER">
  <button class="buttonGUI" onclick="GUI('weather');alert('zurück mit Taste [home] und dann [fullscreen] wenn ein Kanal läuft')">Wetter</button>
  </xsl:template>

<xsl:template match="FILME">
  <button class="buttonGUI" onclick="doSend4aaaac();alert('mit Pfeiltasten was auswählen, dann mit [select] starten\n\noder zurück mit Taste [home] und dann [fullscreen] wenn ein Kanal läuft')">Filme</button>
  </xsl:template>

<xsl:template match="TV_GUIDE">
  <button class="buttonGUI" onclick="GUI('tvguide');alert('Falls die TV-Vorschau leer bleibt, das laufende Programm stoppen und gleich wieder anschalten. In der kurzen Zwischenzeit lädt die TV-Vorschau. Das tritt nämlich immer dann auf, wenn der RPI gleich beim Einschalten mit dem zuletzt gesehenen Programm fortsetzt.\n\nzurück mit Taste [home] und dann [fullscreen]')">TVguide</button>
  </xsl:template>

<xsl:template match="UPDATE">
  <button class="buttonGUI" onclick="doSend4aaaab('script.openelec.devupdate');alert('Geduld - bis das startet, vergehen etliche (20) Sekunden.\n\nzurück mit Taste [back]')">update</button>
  </xsl:template>

<xsl:template match="TV_CHANNELS">
  <button class="buttonGUI" onclick="GUI('tvchannels')">tvchannels</button>
  </xsl:template>

<xsl:template match="ACTION">
  <button class="button">
    <xsl:attribute name="onclick">
      Input('<xsl:value-of select="@action" />');
      </xsl:attribute>
    <xsl:value-of select="." />
    </button>
  </xsl:template>

<xsl:template match="GUI">
  <button class="buttonGUI">
    <xsl:attribute name="onclick">
      GUI('<xsl:value-of select="@window" />');
      </xsl:attribute>
    <xsl:value-of select="@window" />
    </button>
  </xsl:template>

<xsl:template match="TON">
  <button class="butamp">
    <xsl:attribute name="onclick">
      Input('<xsl:value-of select="@action" />');
      </xsl:attribute>
    <xsl:value-of select="." />
    </button>
  </xsl:template>

<xsl:template match="LOGAREA">
  <div><textarea id="logarea" readonly="readonly">
    <xsl:attribute name="cols"><xsl:value-of select="@cols" /></xsl:attribute>
    <xsl:attribute name="rows"><xsl:value-of select="@rows" /></xsl:attribute>
    </textarea></div>
  </xsl:template>

</xsl:stylesheet>