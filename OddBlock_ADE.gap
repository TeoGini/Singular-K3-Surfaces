#*************************************************************************
#	Copyright (C) 2023 by Alice Garbagnati, Matteo Penegini and Arvid Perego.
#
#	This file is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <https://www.gnu.org/licenses/>.
#****************************************************************************

#***************************
CountA2:=function(l)
#------------------------------
#
# This function given a Datum it returns the number of disjoint
# A_2 singularities 
#
#------------------------------

local m,i;

m:=0;

for i in [1..Length(l.SingTypeA)] do
	if i mod 3 = 2 then
		m:=m+((i+1)/3)*l.SingTypeA[i];
	fi;
od;

if Length(l.SingTypeE) > 0 then 
	m:=m+2*l.SingTypeE[1];
fi;

return m;
end;
#***************************

#***************************
BlockA_i_Odd:=function(a,b)
#------------------------------
#
#Given a:=position of SingAi and b:=value of SingAi[a]
#it returns a record with
# blockAi for the new basis vector
# the type of the block 
# how many blocks we have of this type
# how many 1/2 it gives
#
#------------------------------
local i,v,bl,y, R;


y:=0;
v:=[];
bl:=[];

if (a+1 mod 3 <> 0) then
	R:=rec(Block:=ListWithIdenticalEntries(a,0), Blocktype:=[a,1], BlockNumber:=b, BlockLength:=y);
fi;


if a = 2 then
	R:=rec(Block:=[1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=2);
fi;

if a = 5 then
	R:=rec(Block:=[1/3,2/3,0,1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=5);
fi;

if a = 8 then
	R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0,1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=8);
fi;

if a = 11 then
	R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=11);
fi;

if a = 14 then
	R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=14);
fi;

if a = 17 then
	R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3,0,1/3,2/3], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=17);
fi;


return R;
end; 
#***************************


#***************************
AllBlocksAiOdd:=function(l)
#***************************

local i, List;

List:=[];

for i in [1..Length(l)] do
	Add(List, BlockA_i_Odd(i, l[i]));
od;
return List;
end;
#***************************



#***************************
BlockD_i_Odd:=function(a,b)
#------------------------------
#
#Given a:=position of SingDi and b:=value of SingDi[a]
#it returns a record with
# blockDi for the new basis vector
# the type of the block 
# how many blocks we have of this type
# how many 1/2 it gives
#
#------------------------------
local i,v,R,y,A,T;

y:=0;
A:=a+3;
R:=rec(Block:=ListWithIdenticalEntries(A,0), Blocktype:=[A,2], BlockNumber:=b, BlockLength:=y);

return R;
end;
#***************************




#***************************
AllBlocksDiOdd:=function(l)
#***************************
local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockD_i_Odd(i, l[i]));
od;
return List;
end;
#***************************



#***************************
BlockE_i_Odd:=function(a,b)
#------------------------------
#
#Given a:=position of SingEi and b:=value of SingEi[a]
#it returns a record with
# blockDi for the new basis vector
# the type of the block 
# how many blocks we have of this type
# how many 1/2 it gives
#
#------------------------------
local i,v,R,y,A;

y:=0;
A:=a+5;
R:=rec(Block:=ListWithIdenticalEntries(A,0), Blocktype:=[A,3], BlockNumber:=b, BlockLength:=y);

if A=6 and b>0 then
R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0], Blocktype:=[A,3], BlockNumber:=b, BlockLength:=3);
fi;

return R;
end;
#***************************



#***************************
AllBlocksEiOdd:=function(l)

local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockE_i_Odd(i, l[i]));
od;
return List;
end;
#***************************



#***************************
AttachBlocksOdd:=function(l)
#***************************

local F,G,T;

F:=AllBlocksAiOdd(l.SingTypeA);
#Print(F, "\,");
G:=AllBlocksDiOdd(l.SingTypeD);
#Print(F, "\,");
T:=AllBlocksEiOdd(l.SingTypeE);
Append(F,G);
Append(F,T);
return F;
end;
#***************************ven






# qui sotto Vecchia Versione dei vettori tre divisibili

#------------------------------------------------
#***************************
#INewVectZ3:=function(blks,rk)
#***************************
# qui L sono blosks!!!
#local v,g,j,k,i,w,nSub,L;

#L:=Reversed(blks);
#k:=0;
#v:=[];
#for g in L do
#	nSub:=0;
#	if g.BlockLength>0 then
#		for i in [1..g.BlockNumber] do;
#   		if Couni(v,2/3) < 7 then
#				w:=ShallowCopy( v );
#				Append(w, g.Block);
#				Print(w, "\n");
#				if Couni(w,2/3) < 7 then
#				Append(v, g.Block);
#				fi;
#			fi;
#		od;
#	fi;
#od;

#if Length(v) < rk then 
#	for i in [1..(rk-Length(v))] do
#		Add(v,0);
#	od;
#fi;

#return v;
#end;


#***************************
#IINewVectZ3:=function(W1)
#***************************

#local W2, count1,count2,i;

#count1:=0;
#count2:=0;
#W2:=[];

#for i in [1..Length(W1)] do

#if W1[i]=1/3 and count1=0 then
#W2[i]:=1/3;
#count1:=1;
#fi;

#if W1[i]=1/3 and count1=1 then
#W2[i]:=0;
#count1:=2;
#fi;

#if W1[i]=1/3 and count1=2 then
#W2[i]:=2/3;
#count1:=3;
#fi;


#if W1[i]=2/3 and count2=0 then
#W2[i]:=2/3;
#count2:=1;
#fi;

#if W1[i]=1/3 and count1=1 then
#W2[i]:=0;
#count2:=2;
#fi;

#if W1[i]=2/3 and count2=2 then
#W2[i]:=1/3;
#count2:=3;
#fi;


#od;


#return W2;
#end;








