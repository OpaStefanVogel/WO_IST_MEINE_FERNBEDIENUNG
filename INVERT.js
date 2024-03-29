var Matrix={
  MA:[],
  DD:[],
  DDMERK:[],
  alterNenner:1,
  neuerNenner:1,
  imax:0,
  jmax:0,
  imaxmerk:0,
  jmaxmerk:0,
  Code:"",
  CodeX:"",
//eps:0.000000000001,
  eps:0.000000000001,
  Ableitungsmatrix:"",
  Basis_der_Loesungsmenge:[],
  Bereiche_der_Einsetzkanten:[],
  }

with (Matrix) {
Matrix.DELTA=function(i,j,d) {
  Code=Code+"\nDELTA("+i+","+j+","+d+"):\n";
  var YY=[]; for (var k=0;k<imax;k++) YY[k]=MA[k][i];
  var ZZ=[]; for (var l=0;l<jmax;l++) ZZ[l]=MA[j][l];
  Code=Code+"YY="+YY+"\n";
  Code=Code+"ZZ="+ZZ+"\n";
  neuerNenner=MA[j][i]*d+alterNenner;
  for (var k=0;k<imax;k++) for (var l=0;l<jmax;l++) MA[k][l]=(MA[k][l]*neuerNenner-d*YY[k]*ZZ[l])/alterNenner;
  alterNenner=neuerNenner;
  Code=Code+"A=\n"+MA.join("\n")+"\nNenner="+alterNenner+"\n";
  }

Matrix.DOPPELDELTA=function(g,h,k,l,d01,d10) {
//δ*D^-1+TBS = [[bhg-δ,bhk-δ*d01],[blg-δ*d10,blk-δ]]; 
//p = det (...)
//XX=(...)^-1 = [[blk-δ,-bhk+δ*d01],[-blg+δ*d10,bhg-δ]];
//x00=
//XX=[[xx00,xx01],[xx10,xx11]]
//p=xx00*xx11-xx01*xx10;
//YY=[[b1g,b1k],[b2g,b2k],...];
//YYXX=YY*XX;
//ZZ=[[bh1,bh2,...],[bl1,bl2,...]];
//Bneu/p=(pB+YYXX*ZZ)/δ/p
  Code=Code+"\nDOPPELDELTA("+g+","+h+","+k+","+l+","+d01+","+d10+"):\n";
  var xx00=MA[l][k]-alterNenner;
  var xx01=-MA[h][k]+alterNenner*d01;
  var xx10=-MA[l][g]+alterNenner*d10;
  var xx11=MA[h][g]-alterNenner;
  var XX=[[xx00,xx01],[xx10,xx11]];
  var YY=[]; for (var i=0;i<imax;i++) YY[i]=[MA[i][g],MA[i][k]];
  var ZZ=[[],[]]; for (var j=0;j<jmax;j++) {ZZ[0][j]=MA[h][j];ZZ[1][j]=MA[l][j];}
  Code=Code+"XX=[["+XX.join("],[")+"]]\n";
  Code=Code+"YY=[\n["+YY.join("],\n[")+"]]\n";
  Code=Code+"ZZ=[\n["+ZZ.join("],\n[")+"]]\n";
  var YYXX=[]; for (var i=0;i<imax;i++)
    YYXX[i]=[YY[i][0]*xx00+YY[i][1]*xx10,YY[i][0]*xx01+YY[i][1]*xx11];
  Code=Code+"YYXX=[\n["+YYXX.join("],\n[")+"]]\n";
  var YYXXZZ=[]; for (var i=0;i<imax;i++) {
    YYXXZZ[i]=[]; 
    for (var j=0;j<jmax;j++) YYXXZZ[i][j]=YYXX[i][0]*ZZ[0][j]+YYXX[i][1]*ZZ[1][j]
    }
  Code=Code+"YYXXZZ=[\n["+YYXXZZ.join("],\n[")+"]]\n";
  neuerNenner=xx00*xx11-xx01*xx10;
  for (var i=0;i<imax;i++) for (var j=0;j<jmax;j++) MA[i][j]=(MA[i][j]*neuerNenner-YYXXZZ[i][j])/alterNenner;
  alterNenner=neuerNenner;
  Code=Code+"A=\n"+MA.join("\n")+"\nNenner="+alterNenner+"\n";
  }

Matrix.DDSUCH=function() {
  var num=0;
  do {num=num+1;
    tfl=true;
    Code=Code+"DDSUCH für DD=["+DD.join("],[")+"]:\n";
    for (var ij=0;ij<DD.length;ij++) if (tfl) {
      var i=DD[ij][0];
      var j=DD[ij][1];
      Code=Code+"["+i+","+j+"]:";
      var flag1=(Math.abs(MA[j][i]-alterNenner)<Math.abs(eps*alterNenner));
      Code=Code+flag1+"\n";
      if (flag1==false) {
        Code=Code+"entferne ["+DD[ij]+"]";
        DELTA(i,j,-1);
        DD.splice(ij,1);
        tfl=false;
        }
      for (var kl=0;kl<ij;kl++) if (tfl) {
        var k=DD[kl][0];
        var l=DD[kl][1];
        Code=Code+"["+i+","+j+"] - ["+k+","+l+"]: ";
        var flag2=(Math.abs(MA[j][k])<Math.abs(eps*alterNenner));
        var flag3=(Math.abs(MA[l][i])<Math.abs(eps*alterNenner));
        Code=Code+flag2+" "+flag3+"\n";
        if (flag2==false&&flag3==false) if (tfl) {//alert("zuerst dran bei #1910-8");
          Code=Code+"entferne ["+i+","+j+"] und ["+k+","+l+"] gleichzeitig\n";
          DOPPELDELTA(i,j,k,l,0,0);
          DD.splice(ij,1);
          DD.splice(kl,1);
          Code=Code+"jetzt nur noch DD=["+DD.join("],[")+"]:\n";
          tfl=false;
          }
        if (flag2==false&&flag3==true) if (tfl) {
          Code=Code+"ersetze ["+i+","+j+"] und ["+k+","+l+"] durch ["+k+","+j+"]\n";
          DOPPELDELTA(i,j,k,l,0,1);
          DD[kl]=[k,j];DD.splice(ij,1);
          Code=Code+"jetzt nur noch DD=["+DD.join("],[")+"]:\n";
          tfl=false;
          }
        if (flag3==false&&flag2==true) if (tfl) {
          Code=Code+"ersetze ["+i+","+j+"] und ["+k+","+l+"] durch ["+i+","+l+"]\n";
          DOPPELDELTA(i,j,k,l,1,0);
          DD[kl]=[i,l];DD.splice(ij,1);
          Code=Code+"jetzt nur noch DD=["+DD.join("],[")+"]:\n";
          tfl=false;
          }
        
        }
      }
    
    } while (tfl==false&&num<2000);
  }

Matrix.INVERT_pur=function(gA) {
  //MA=[ [ 1, 1, 1, 1 ], [ 2, 4, 8, 16 ], [ 3, 9, 27, 81 ], [ 4, 16, 64, 256]];
  //MA=[[1,2],[3,1]];
  //MA=[[0,1],[0,0]];
  //MA=[[0,0],[1,0]];
  //MA=[[0,9,0],[0,9,0],[0,9,0],[0,9,0],[0,9,0],[1,2,-1],[2,6,-2],[-3,1,3]];
  MA=gA;
  Ableitungsmatrix="Ableitungsmatrix=[\n["+MA.join("],\n[")+"]\n];\n";
  alterNenner=1;
  //Ableitungsmatrix=Ableitungsmatrix+"\nNenner="+alterNenner+";\n";
  Code=Ableitungsmatrix+"\n\nlos mit INVERT(A): ";
  var RET=MA;
  imax=MA.length;
  jmax=MA[0].length;
  Code=Code+"imax="+imax+", jmax="+jmax+"\n";
  imaxmerk=imax;
  jmaxmerk=jmax;
  if (jmax<imax) {
    for (var i=0;i<imax;i++) for (var j=jmax;j<imax;j++) MA[i][j]=0;
    jmax=imax;
    }
  if (imax<jmax) {
    for (var i=imax;i<jmax;i++) {
      MA[i]=[];
      for (var j=0;j<jmax;j++) MA[i][j]=0;
      }
    imax=jmax;
    }
  DD=[];
  var YY=[];
  var ZZ=[];
  for (var i=0;i<imax;i++) if (i<jmax) {
    Code=Code+"\ni="+i+" "+(MA[i][i]/alterNenner)+":";
    if (Math.abs(MA[i][i])<Math.abs(eps*alterNenner)) {
      MA[i][i]=MA[i][i]+alterNenner;
      DD.push([i,i]);
      Code=Code+" ergänze Stütze ["+i+","+i+"]";
      }
    Code=Code+"\n";
    for (var j=0;j<imax;j++) YY[j]=MA[j][i]; YY[i]=YY[i]+alterNenner;
    for (var j=0;j<jmax;j++) ZZ[j]=MA[i][j]; ZZ[i]=ZZ[i]-alterNenner;
    Code=Code+"YY="+YY+"\n";
    Code=Code+"ZZ="+ZZ+"\n";
    neuerNenner=MA[i][i];
    for (var j=0;j<imax;j++) for (var k=0;k<jmax;k++) MA[j][k]=(MA[j][k]*neuerNenner-YY[j]*ZZ[k])/alterNenner;
    alterNenner=neuerNenner;
    //Überschreitung Zahlenbereich vermeiden
    for (var j=0;j<imax;j++) for (var k=0;k<jmax;k++) MA[j][k]=MA[j][k]/neuerNenner;
    alterNenner=1;
    Code=Code+"A=\n"+MA.join("\n")+"\nNenner="+alterNenner+"\n";
    DDSUCH();
    }
  }

Matrix.MMUL=function(A,B) {//Matrixmultiplikation
  var RET=[];
  for (var i=0;i<A.length;i++) {
    RET[i]=[];
    for (var j=0;j<B[0].length;j++) {
      var sum=0;
      for (var k=0;k<A[0].length;k++) sum=sum+A[i][k]*B[k][j];
      RET[i][j]=sum;
      }
    }
  return RET;
  },

Matrix.MADD=function(lambda,A,mue,B) {//Matrixaddition
  var RET=[];
  for (var i=0;i<A.length;i++) {
    RET[i]=[];
    for (var j=0;j<A[0].length;j++) RET[i][j]=lambda*A[i][j]+mue*B[i][j];
    }
  return RET;
  }

Matrix.MSCAL=function(lambda,A) {//Matrixaddition
  var RET=[];
  for (var i=0;i<A.length;i++) {
    RET[i]=[];
    for (var j=0;j<A[0].length;j++) RET[i][j]=lambda*A[i][j];
    }
  return RET;
  }

}
//alert(MMUL([[1,2],[2,3]],[[1,2],[2,3]]));
