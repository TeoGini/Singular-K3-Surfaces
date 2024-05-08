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


#****************************************************************************

## These are Helping functions ##

#****************************************************************************

#****************************************************************************
GetSublists := function(lst)
#****************************************************************************
#
# This function it returns all possible sublist of a given list
#
#****************************************************************************
    local n, i, j, result,sublist;
    n := Size(lst);
    result := [];
    
    for i in [0..2^n-1] do
        sublist := [];
        for j in [1..n] do
            if i mod 2^(j-1) >= 2^(j-2) then
                sublist := Concatenation(sublist, [lst[j]]);
            fi;
        od;
        result := Concatenation(result, [sublist]);
    od;
    
    return result;
end;;

# Example usage:
# myList := [1, 2, 3];
# allSublists := GetSublists(myList);
# Print(allSublists);
#***************************************

#***************************************
IntegersList := function(N)
#------------------------------------------------
#
# Given a natural number N
# It returns a list from [1..N]
#
#------------------------------------------------
    local i, result;
    result := [];
    for i in [1..N] do
        Add(result, i);
    od;
    return result;
end;
#***************************************

#***************************************
Couni:=function(L,i)
#------------------------------------------------
#
# Given an array of integers L and an integer i 
# It returns the number of integers equal to i that appear in L
#
#------------------------------------------------
local tmp,j;

tmp:=0;
for j in [1..Length(L)] do
	if L[j]=i then
		tmp:=tmp+1;
	fi;
od;
return tmp;
end;
#***************************************


#***************************************
AfterZero:=function(l)
#-----------------------------------
#
# Given an array that ends with many "0"
# it returns the same array without the zeros
#
#-----------------------------------
local i,L,j;
i:=0;
L:=[];

while l[Length(l)-i] = 0 do
	i:=i+1;
od;

for j in [1..(Length(l)-i)] do
	L[j]:=l[j];
od;

return L; 
end;
#***************************************

#***************************************
FirstGood:=function(l)

local n,v;

for v in l do 
	if Length(v) = 1 then 
		if v = [1/2] then 
			n:=Position(l,v);
			break;
		fi;
	fi;
od;

return n;
end;
#***************************************


#***************************************
AllZero:=function(L,i)
#------------------------------------------------
#
# Given an array of integers L and an integer i 
# Checks if the entries after position i are all zero
#
#------------------------------------------------
local d,j,tmp;

d:=0;
tmp:=true;

for j in [i..Length(L)-1] do
	if L[j+1] > 0 then
		d:=d+1;
	fi;
od;

if d=0 then 
	tmp:=false;
fi;

return tmp;
end;
#***************************************


#***************************************
CheckNumberDisjointLine:=function(n)
return n<17;
end;
#***************************************


#**************************************
AddZeroEnd:=function(l,n)
#------------------------------------------------
#
# This function add to the end of l as so many zero 
# so that the length of l reaches n.
#
#------------------------------------------------
local i;

if Length(l) < n then 
	for i in [1..(n-Length(l))] do
		Add(l,0);
	od;
fi;

return l;
end;
#***************************************


#**************************************
AddZeroEndVect:=function(l,n)
#------------------------------------------------
#
# This function add to the end of l as so many zero vectors [0]
# so that the length of l reaches n.
#
#------------------------------------------------
local i;

if Length(l) < n then 
	for i in [Length(l)+1..n] do
		l[i]:=[0];
	od;
fi;

return l;
end;
#***************************************


#***************************************
IsIntegralMatrix:=function(M)
#------------------------------------------------
#
# This function given a matrix M 
# return 
# TRUE if ALL the coefficients are INTEGERS
# FALSE if there is one NON INTEGER coefficient
#
#------------------------------------------------
local i,j, tmp;

tmp:=true;

for i in [1..Size(M)] do
	for j in [1..Size(M)] do
		if not IsInt(M[i][j]) then 
			return false;
		fi;
	od;
od;

return tmp;
end;
#***************************************

#***************************************
ZeVet:=function(m)
#***************************************
#------------------------------------------------
#
# It return an array of length m all made of zeros
# GAP4 has a default function called ZERO(n) that does the same thing!
#
#------------------------------------------------
local L,i;

L:=[];
for i in [1..m] do
	Add(L,0);
od;

return L;
end;
#***************************************


#***************************************
DiscGro:=function(l)
#------------------------------------------------
#
# Restituisce il reticolo in gruppi ciclici primi (non aggregati!)
#
#------------------------------------------------

local L,i,k;

L:=ZeVet(19);

for k in [1..Length(l.SingTypeA)] do
	L[k]:=L[k]+l.SingTypeA[k];
od;

for i in [1..Length(l.SingTypeD)] do
	if i mod 2 = 1 then
		L[1]:=L[1]+2*l.SingTypeD[i];
	else
		L[3]:=L[3]+1*l.SingTypeD[i];
	fi;
od;

L[2]:=L[2]+l.SingTypeE[1];
L[1]:=L[1]+l.SingTypeE[2];

return L;
end;
#***************************************

#***************************************
nInside:=function(l,n)

local tmp,i;

tmp:=false;

for i in [1..Length(l)] do
	if l[i]=n then
		tmp:=true;
	fi;
od;

return tmp;
end;
#***************************************

#***************************************
AddZero1:=function(l)

InsertElmList(l,1,0);

return l;
end;
#***************************************

#***************************************
nInsidePlus:=function(l,n)

local tmp,i,h,m;

tmp:=false;
InsertElmList(l,1,0);
m:=0;

if (Length(l) mod 2 = 0) then 
	h:=Length(l)/2;
fi;

if (Length(l) mod 2 = 1) then 
	h:=(Length(l)-1)/2;
fi;

for i in [1..h] do
	m:=m+l[2*i];
od;

if m = n then 
	tmp:=true;
fi;

return tmp;
end;
#***************************************

#***************************************
nInsidePlus3:=function(l,n)

local tmp,i,h,m;

tmp:=false;
InsertElmList(l,1,0);
m:=0;

if (Length(l) mod 3 = 0) then 
	h:=Length(l)/3;
fi;

if (Length(l) mod 3 = 1) then 
	h:=(Length(l)-1)/3;
fi;

if (Length(l) mod 3 = 2) then 
	h:=(Length(l)-2)/3;
fi;

for i in [1..h] do
	m:=m+l[3*i];
od;

if m = n then 
	tmp:=true;
fi;

return tmp;
end;
#***************************************

#***************************************
SubN1:=function(l)

local L,i;

L:=ZeVet(l);
for i in [1..l/2] do
	L[2*i+1]:=1/2;
od;
return L;
end;
#***************************************

#***************************************
Algons:=function(L)
#------------------------------------------------
#
# Retituisce la lunghezza del reticolo
#
#------------------------------------------------

local V,h,i,j,k;

V:=ZeVet(2*3*5*7*11);
for h in [1..Length(L)] do
	V[h+1]:=L[h];
od;

for i in [2..Length(L)+1] do 
    for k in [i+1..Length(L)+1] do
        if V[i]> 0 then
        	if V[k] >0 then 
        		for j in [1..L[i-1]] do
	  				if V[i]> 0 then
           				if V[k] >0 then 
	   						if GcdInt(i,k)=1 then
	   							V[i*k]:=V[i*k]+1;
	   							V[i]:=V[i]-1;
	   							V[k]:=V[k]-1;
							fi;
						fi; 
					fi;
				od;
			fi; 
		fi;
    od;
od;


return Sum(V);
end;
#***************************************


#***************************************
ReducedPrimeCyclesAB:=function(L)
#------------------------------------------------
#
# Preso un gruppo abeliano come prodotto ciclico di primi
# lo scrive come prodotto minimo di ciclici
#
#------------------------------------------------
local V,h,i,j,k;

V:=ZeVet(2*3*5*7*11);
for h in [1..Length(L)] do
	V[h+1]:=L[h];
od;

for i in [2..Length(L)+1] do 
	 for k in [i+1..Length(L)+1] do
        	if V[i]> 0 then
        		if V[k] >0 then 
         			for j in [1..L[i-1]] do
						if V[i]> 0 then
           					if V[k] >0 then 
	   							if GcdInt(i,k)=1 then
	   								V[i*k]:=V[i*k]+1;
	   								V[i]:=V[i]-1;
	  							    V[k]:=V[k]-1;
								fi;
							fi; 
						fi;
					od;
				fi; 
			fi;
        od;
od;


return V;
end;
#***************************************


#***************************************
DivisibleAi:=function(l)
#***************************************
local n,N,q,T,i;

q:=Length(l);
n:=0;
for i in [1..q] do
	if (i mod 2 =1) then	
		if l[i]>0 then
			n:=n+Int((i+1)/2)*l[i];
		fi;
	fi;
od;

return n;
end;
#***************************************

#***************************************
DivisibleDi:=function(l)
#***************************************
local n,N,q,T,i;

q:=Length(l);
n:=0;
for i in [1..q] do
	if l[i]>0 then
		n:=n+(Int((i+3)/2)+1)*l[i];
	fi;
od;

return n;
end;
#***************************************

#***************************************
DivisibleEi:=function(l)
#***************************************
local n,N,q,T,i;

n:=4*l[2];

return n;
end;
#***************************************

#***************************************
AinotA3:=function(l)
#***************************************
local n,N,q,T,i;

q:=Length(l);
n:=0;
for i in [1..q] do
	if (i mod 2 =1) then
		if l[i]>0 then
			n:=n+Int((i+1)/2)*l[i];
		fi;
	fi;
od;

return n-8;
end;
#***************************************

#***************************************
CountA1:=function(l)

return  DivisibleAi(l.SingTypeA)+DivisibleDi(l.SingTypeD)+DivisibleEi(l.SingTypeE);
end;
#***************************************


#***************************************
CountA2:=function(l)

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
#***************************************

#***************************************
CountA3:=function(l)

local m,i,j;

m:=0;

for i in [1..Length(l.SingTypeA)] do
	if i mod 4 = 3 then
		m:=m+((i+1)/4)*l.SingTypeA[i];
	fi;
od;

for j in [1..Length(l.SingTypeD)] do
	if j mod 2 =0 then
		m:=m+1*l.SingTypeD[j];
	fi;
od;

return m;
end;
#***************************************


#***************************************
CountA4:=function(l)

local m,i,j;

m:=0;

for i in [1..Length(l.SingTypeA)] do
	if i mod 5 = 4 then
		m:=m+((i+1)/5)*l.SingTypeA[i];
	fi;
od;

return m;
end;
#***************************************


#***************************************
CountA5:=function(l)

local m,i,j;

m:=0;

for i in [1..Length(l.SingTypeA)] do
	if i mod 6 = 5 then
		m:=m+((i+1)/6)*l.SingTypeA[i];
	fi;
od;

return m;
end;
#***************************************


#***************************************
AiMatrix:=function(n)
#----------------------
#
#
#
#----------------------
local list,l,i,j;


l:=[];
for i in [1..n] do
	list:=ZeVet(n);
		for j in [1..n] do
			if j=i then	
				list[j]:=-2;
	 		fi;
			if j=i-1 or j=i+1 then 
	 			list[j]:=1;	
			fi;
		od;
	l[i]:=list;
od;

return l;
end;
#***************************************

#***************************************
EiMatrix:=function(n)
#----------------------
#
#
#
#----------------------

local l,m;

m:=n+5; 

if m = 6 then 
l:=[[-2,1,0,0,   0,0],
    [1,-2,1,0,   0,0],
    [0,1,-2, 1,0,1],
    [0,0, 1,-2,1,0],
    [0,0, 0,1,-2,  0],
    [0,0, 1,0, 0, -2]
];
fi;

if m = 7 then 
l:=[[-2,1,0,0,   0,0, 0],
    [1,-2,1,0,   0,0, 0],
    [0,1,-2, 1,0,0, 1],
    [0,0, 1,-2,1,0, 0],
    [0,0, 0,1,-2,  1, 0],
    [0,0, 0,0, 1, -2, 0],
    [0,0, 1,0, 0,  0,-2]
];
fi;

if m = 8 then 
l:=[[-2,1,0,0, 0,0, 0,0],
       [1,-2,1,0,    0,0, 0,0],
       [0,1,-2, 1,0, 0 ,0,1],
       [0,0, 1,-2,1,0,0, 0, 0],
       [0,0, 0,1,-2,  1, 0, 0],
       [0,0, 0,0, 1, -2, 1, 0],
       [0,0, 0,0, 0,  1,-2, 0],
       [0,0, 1,0, 0,  0,0, -2],

];
fi;

return l;
end;
#***************************************


#***************************************
DiMatrix:=function(m)
#----------------------
# Restituisce la matrice di intersezione di un reticolo Dm
# notare che i due cornini sono in posizione 1 e 2. 
#
#----------------------

local l,n,i,j,list;
n:=m+3;

l:=[];
l[1]:=ZeVet(n);
l[2]:=ZeVet(n);
l[3]:=ZeVet(n);
    l[1][1]:=-2;
    l[1][3]:=1;
    l[2][2]:=-2;
    l[2][3]:=1;
    l[3][1]:=1;
    l[3][2]:=1;
    l[3][3]:=-2;
    l[3][4]:=1;

for i in [4..n] do
	list:=ZeVet(n);
		for j in [1..n] do
	 		if j=i then	
	 			list[j]:=-2;
	 		fi;
			if j=i-1 or j=i+1 then 
	 			list[j]:=1;	
			fi;
		od;
	l[i]:=list;
od;


return l;
end;
#***************************************

#***************************************
AddZeroh:=function(l,h)
#***************************************

local i;
for i in [Length(l)+1..Length(l)+h] do
	Add(l,0);
od;

return l;
end;
#***************************************

#***************************************
AddZero19:=function(l,x)
#***************************************

local i;
for i in [Length(l)+1..x] do
Add(l,0);
od;

return l;
end;

#***************************************
AddZeroBefore:=function(l,x)


local L,LL;

L:=Reversed(l);
AddZeroh(L,x);
LL:=Reversed(L);


return LL;
end;
#***************************************

Count_common_1_new:=function(v1,v2)
	# Given two vectors v1,v2  of the same length it returns
	# a triple of non negative integers the first integer counts the entries bigger than 0
	# in common between v1 and v2 the second the entries of v2 that are not in v1. 

	local Flat_V1, Flat_V2, count_12, i, new;

	count_12:=0;
	new:=0;

	Flat_V1:=Flat(v1);
	Flat_V2:=Flat(v2);

	if Length(Flat_V1) <> Length(Flat_V2)  then
		#Print("ERROR different length \n");
		return 0;
	fi;

	for i in [1..Length(Flat_V2)] do
		if Flat_V2[i] > 0 then 
			if Flat_V1[i] = Flat_V2[i] then
				count_12:=count_12+1;
			fi;
			if Flat_V1[i] = 0  then
				new:=new+1;
			fi;
		fi;
	od;

	return [count_12, new];
end;
########################################################################




#######################################################################
Count_common_12_23_123:=function(v1,v2,v3)
	# Given three vectors v1,v2 and v3 of the same length it returns
	# a quadruple of non negative integers the first integer counts the entries bigger than 0
	# in common between v1 and v3 the second in common v2 and v3 the third in common to all the three.
	# the last that there are only on v3 

	local Flat_V1, Flat_V2, Flat_V3, count_13, count_23, count_123, i, new;

	count_13:=0;
	count_123:=0;
	count_23:=0;
	new:=0;

	Flat_V1:=Flat(v1);
	Flat_V2:=Flat(v2);
	Flat_V3:=Flat(v3);

	if Length(Flat_V1) <> Length(Flat_V2) or Length(Flat_V1) <> Length(Flat_V3) then
		#Print("ERROR different length \n");
		return 0;
	fi;

	for i in [1..Length(Flat_V3)] do
		if Flat_V3[i] > 0 then 
			if Flat_V1[i] = Flat_V3[i] and Flat_V1[i] <> Flat_V2[i]  then
				count_13:=count_13+1;
			fi;
			if Flat_V2[i] = Flat_V3[i] and Flat_V1[i] <> Flat_V2[i]  then
				count_23:=count_23+1;
			fi;
			if Flat_V1[i] = Flat_V2[i] and Flat_V1[i] = Flat_V3[i]  then
				count_123:=count_123+1;
			fi;
			if Flat_V1[i] = 0 and Flat_V2[i] = 0  then
				new:=new+1;
			fi;
		fi;
	od;

	return [count_13,count_23, count_123, new];
end;

#***************************************
BlockMatrixADE:=function(L,rk)
#----------------------
#
#
#
#----------------------

local x,H3,H2,H1,i,j;
x:=0;
H3:=[];
H1:=[];
H2:=[];
for i in [1..Length(L)] do
	for j in [1..Size(L[i])] do 
		H1:=AddZeroBefore(L[i][j],x);
		H2:=AddZero19(H1,rk);
		Add(H3,H2);
	od;
	x:=x+Size(L[i]);
od;

return H3;
end;
#***************************************

#***************************************
D4Detect:=function(l)
#------------------------------
# 
# Given a record of singularities it detect it there is a D4
# 
#-------------------------------
local tmp;

tmp:=false;

if l.SingTypeD[1]<>0 then 
	tmp:=true;
fi;

return tmp;
end;
#***************************************



#***************************************
D2nDetect:=function(l)
#------------------------------
# 
# Given a record of singularities it detect it there is a D2n
# 
#------------------------------
local tmp,i,L,B;

tmp:=false;
L:=[];
B:=[];

for i in [1,3,5,7,9,11,13,15] do
	if IsBound( l.SingTypeD[i]) then
		if l.SingTypeD[i]<>0 then 
			tmp:=true;
			Add(L,i);
			Add(B, l.SingTypeD[i]);
		fi;
	fi;	
od;

return [tmp,L,B];
end;
#***************************************

#***************************************
DnDetect:=function(l)
# 
# Given a record of singularities it detect it there is a D4
# 
local tmp,i;

tmp:=false;

for i in [1..Length(l.SingTypeD)] do
	if l.SingTypeD[i]<>0 then 
		tmp:=true;
	fi;
od;

return tmp;
end;
#***************************************

#***************************************
IsGoodBlock:=function(B,n)
#---------------------------
#
# given a block and an integer
# it returns TRUE if there are at least n [1/2] blocks
#
#  EXAMPLE:
# Dato:=rec(
#   SingTypeA := [ 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
# blks:=AttachBlocks(Dato);
# IsGoodBlock(blks,5);
# true
# Indeed there are 6 blocks of type [1/2]
#-----------------------------

local tmp, s, bk;

tmp:=false;
s:=0;

for bk in B do
	s:=s+bk.BlockLength*bk.BlockNumber;
od;

if s>=n then 
	tmp:=true;
fi; 

return tmp;
end;
#***************************************

#***************************************
IsBlockTooBig:=function(b,blks,rk, n)
#***************************************

local tmp,bk;

tmp:=false;

if D2nDetect(b)[1] and Sum(D2nDetect(b)[3])<2 then 
for bk in blks do
		if bk.BlockLength > n and rk < 19 then 
			tmp:=true;
		fi;
	od;
else
	for bk in blks do
		if bk.BlockLength >= n and rk < 19 then 
			tmp:=true;
		fi;
	od;
fi;

return tmp;
end;
#***************************************


#***************************************
IsBlockSTooBig:=function(b,blks,rk, n)
#***************************************

local tmp,bk,ToAddA, ToAddD, nBig;

tmp:=false;

ToAddA:=ShallowCopy(b.SingTypeA);
Remove(ToAddA,1);
if Sum(ToAddA) = 0 then 
	ToAddD:=ShallowCopy(b.SingTypeD);
	Remove(ToAddD,1);
else
	ToAddD:=b.SingTypeD;
fi; 

nBig:=Sum(ToAddA)+Sum(ToAddD)+Sum(b.SingTypeE);

if nBig >1 then
 tmp:=true;
fi;

if D2nDetect(b)[1] and D2nDetect(b)[3][1]<= 2 then 
for bk in blks do
		if bk.BlockLength > n  then 
			tmp:=true;
		fi;
	od;
else
	for bk in blks do
		if bk.BlockLength >= n  then 
			tmp:=true;
		fi;
	od;
fi;


# Bisogna aggiungere il caso 19 

return tmp;
end;
#***************************************

#***************************************
BlocksClean:=function(blks)
#***************************
# given a block it returns the same block erasing the
# void info. 
# 
# Example
# Dato:=rec(
#   SingTypeA := [ 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
# blks:=AttachBlocks(Dato);
# BlocksClean(blks);
# -----------------------------------------------------
local NBlks,bk;

NBlks:=[];
for bk in blks do 
	if bk.BlockNumber > 0 then
	Add(NBlks, bk);
	fi;
od;

return NBlks;
end;

#***************************************
DetectA2:=function(BadList,NikList,DisList) 

#--------------------------------
#
# This function takes the NikList and the DisList
# doesn't have GoodList!
# checks the presences of A2s
# if they are there it puts them back into the BadList (to be further analyzed)
#
#--------------------------------


local g,h,DLCopy,NLCopy;

NLCopy:=ShallowCopy(NikList);
for g in NLCopy do
	if CountA2(g) >5 then
		Add(BadList, g);
		Remove(NikList,Position(NikList, g));
	fi;
od;

DLCopy:=ShallowCopy(DisList);
for h in DLCopy do
# StampaADE(h);
	if CountA2(h) >5 then
		Add(BadList, h);
		Remove(DisList,Position(DisList, h));
	fi;
od;

return [BadList,NikList,DisList];
end;
#***************************************


#***************************************
SecondVectorTest:=function(blks)
#***************************************

local tmp, count,g,s,i,bk;

tmp:=false;
count:=0;

for g in blks do
s:=0;
	if g.BlockLength < 5 and g.BlockLength > 0 then
		for i in [1..g.BlockNumber] do
			s:=s+g.BlockLength;
			if s <=4 then
				count:=count+g.BlockLength;
			fi;
			s:=0;
		od;
	fi;
od;


if count >=4 then
	tmp:=true;
fi;


return tmp;
end;
#***************************************

#***************************************
ThirdVectorTest:=function(l)
#***************************************

local tmp, count,g,s,i;

tmp:=false;
count:=0;

for g in l do
s:=0;
	if g.BlockLength < 3 and g.BlockLength > 0 then
		for i in [1..g.BlockNumber] do
			s:=s+g.BlockLength;
			if s <=2 then
				count:=count+1;
			fi;
				s:=0;
		od;
	fi;
od;


if count >=2 then
tmp:=true;
fi;


return tmp;
end;
#***************************************


#***********************************************
#
# Here we set up the FOURTH new basis vector 
# and reset the blocks
#
#***********************************************



#***************************
FourthVectorTest:=function(l)
#***************************

local tmp, count,g,s,i;

tmp:=false;
count:=0;

for g in l do
s:=0;
	if g.BlockLength < 2 and g.BlockLength > 0 then
		for i in [1..g.BlockNumber] do
			s:=s+g.BlockLength;
			if s <=1 then
			count:=count+1;
			fi;
		od;
	fi;
od;


if count >=1 then
	tmp:=true;
fi;


return tmp;
end;
#***************************************


#***************************************
CleanRecords:=function(D)
# 
# Given a lists of records it clean the rec
# blocks, and vectors
# 
local g;

for g in D do 
	g.Blocks:=[];
	if IsBound(g.V1) then
		g.V1:=[];
	fi;
	if IsBound(g.V2) then
		g.V2:=[];
	fi;
	if IsBound(g.V3) then
		g.V3:=[];
	fi;
	if IsBound(g.V4) then
		g.V4:=[];
	fi; 
	g.DiscGro:=DiscGro(g);
	g.ell:=Sum(ReducedPrimeCyclesAB(DiscGro(g)));	
od;

return D;
end;
#***************************************


#***************************************
Discgro_Check:=function(Good,Nik)

local Bad_DiscGro, Dato;

Bad_DiscGro:=[];

for Dato in Good do
	if Dato.DiscGro[1] < 0 then
		Add(Bad_DiscGro,Dato);
		Remove(Good,Position(Good,Dato));
	fi;
od;

for Dato in Nik do
	if Dato.DiscGro[1] < 0 then
		Add(Bad_DiscGro, Dato);
		Remove(Nik,Position(Nik,Dato));
	fi;
od;

return [Good,Nik,Bad_DiscGro];
end;
#***************************************
