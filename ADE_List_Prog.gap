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

#--------------------------------------------------------------
#
# This program returns all possible ADE singularities combinatorially 
# And it prints them out.
#
#--------------------------------------------------------------

Read("HelpFunc_ADE.gap");

#****************************************************************************
#
## The following functions calculate singularities individually  
#
#****************************************************************************


############################
SingAi:=function(rk)
############################
#
# Given a rank rk 
# It returns all possible Ai singularities till rank rk 
# (partition of rk)
#
############################

local A,Num,T,j,l,i;
T:=[];
A:=Partitions(rk);
l:=Length(A);

for i in [1..l] do
Num:=[];
	for j in [1..rk] do
	Add(Num,Couni(A[i],j));
	od;
Add(T,rec(SingTypeA:=Num, SingTypeD:=ZeVet(15), SingTypeE:=ZeVet(3)));	
od;
return T;
end;
##########################

############################
SingDi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Di singularities till rank rk 
# (partition with restriction of rk)
#
############################

local T,L, ListD,i,D,k,l,j,Num;

D:=[];
T:=[];
ListD:=[];
for i in [4..rk] do
L:=[4..i];
Add(ListD,L); 
od;

for l in ListD do
Add(D,RestrictedPartitions( rk, l ));
od;

for k in [1..Length(D)] do
for i in [1..Length(D[k])] do
Num:=[];
for j in [4..rk] do
	Add(Num,Couni(D[k][i],j));
	od;
Add(T,rec(SingTypeA:=ZeVet(19), SingTypeD:=Num, SingTypeE:=ZeVet(3)));
od;od;

return AsSet(T);
end;
############################


############################
SingEi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Ei singularities till rank rk 
# (partition with restriction of rk)
#
############################
local T,L,Num, ListE,j,k;


T:=[];
ListE:=RestrictedPartitions(rk,[6,7,8]);


for k in [1..Length(ListE)] do
Num:=[];
for j in [6..8] do
	Add(Num,Couni(ListE[k],j));
	od;
Add(T,rec(SingTypeA:=ZeVet(19), SingTypeD:=ZeVet(15), SingTypeE:=Num));
od;

return T;
end;
############################



#****************************************************************************
#
## The following functions compute singularities in pairs.  
#
#****************************************************************************

############################
SingAiDi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Di together with  Ai singularities till rank rk 
# (partition with restriction of rk)
#
############################
local Di,Ai,i,l,t,k,r,rd,T,x,y,j;

y:=rk-4;
x:=1;
T:=[];
while y>0 do
y:=y-1;


for Di in SingDi(rk-x) do 
t:=0;
rd:=Length(Di.SingTypeD);

	for k in [1..rd] do
	t:=t+((3+k)*Di.SingTypeD[k]);
	od;

Ai:=SingAi(rk-t);

	for l in Ai do
        Add(T,rec(SingTypeA:=l.SingTypeA, SingTypeD:=Di.SingTypeD, SingTypeE:=ZeVet(3)));
	od;


od;
x:=x+1;
od;
return T;
end;

############################


############################
SingAiEi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Ei together with Ai  singularities till rank rk 
# (partition with restriction of rk)
#
############################
local Ei,Ai,i,l,t,k,r,re,x,y,j,T;

y:=rk-6;
x:=1;
T:=[];
while y>0 do
y:=y-1;

for Ei in SingEi(rk-x) do 
	t:=0;
	re:=Length(Ei.SingTypeE);

	for k in [1..re] do
		t:=t+((5+k)*Ei.SingTypeE[k]);
	od;

	Ai:=SingAi(rk-t);

	for l in Ai do
        Add(T,rec(SingTypeA:=AddZero19(l.SingTypeA,19), SingTypeD:=ZeVet(15), SingTypeE:=Ei.SingTypeE));
	od;


od;
x:=x+1;
od;
return T;
end;
############################



############################
SingDiEi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Ei together with Ai  singularities till rank rk 
# (partition with restriction of rk)
#
############################
local Ei,Di,i,l,t,k,r,re,x,y,j,T;


y:=rk-6;
x:=4;
T:=[];
while y>0 do
y:=y-1;


for Ei in SingEi(rk-x) do 
t:=0;
re:=Length(Ei.SingTypeE);

	for k in [1..re] do
	t:=t+((5+k)*Ei.SingTypeE[k]);
	od;

Di:=SingDi(rk-t);


for l in Di do
        Add(T,rec(SingTypeA:=ZeVet(19), SingTypeD:=l.SingTypeD, SingTypeE:=Ei.SingTypeE));
	od;


od;
x:=x+1;
od;
return T;
end;



#****************************************************************************
#
## The following functions compute all three singularities together.  
#
#****************************************************************************





############################
SingAiDiEi:=function(rk)
############################
#
# Given a rank rk>3
# It returns all possible Ei, Di together with  Ai singularities till rank rk 
# (partition with restriction of rk)
#
############################
local y,x,Ei,te,re,k,LL,lA,lD,ll,T;

y:=rk-10;
x:=5;
T:=[];

while y>0 do
	for Ei in SingEi(rk-x) do 
	te:=0;
	re:=Length(Ei.SingTypeE);

		for k in [1..re] do
		te:=te+((5+k)*Ei.SingTypeE[k]);
		od;

		
        LL:=SingAiDi(rk-te);
        for ll in LL do
			lA:=ll.SingTypeA;
			lD:=ll.SingTypeD;
			#Print(lA,lD,Ei,"\n");
			Add(T,rec(SingTypeA:=lA, SingTypeD:=lD, SingTypeE:=Ei.SingTypeE));
		od;
  	od;
y:=y-1;
x:=x+1;
od;
return T;

end;
#***************************


#***************************
TheRank:=function(l)
#-----------------------------------------------------------
#
# Given a record of ADE sing. it returns the rank of the lattice
#
#------------------------------------------------------------
local rk,a,d,e,i;
d:=0;
e:=0;
a:=0;

for i in [1..Length(l.SingTypeA)] do
a:=a+i*l.SingTypeA[i];
od;


for i in [1..Length(l.SingTypeD)] do
d:=d+(i+3)*l.SingTypeD[i];
od;

for i in [1..Length(l.SingTypeE)] do
e:=e+(i+5)*l.SingTypeE[i];
od;

rk:=a+d+e;
return rk;
end;
#***************************



#************************************************
Z2Count:=function(l)

local n,i;
n:=0;

for i in [1..Length(l.SingTypeA)] do
if i mod 2 = 1 then 
n:=n+l.SingTypeA[i];
fi;
od;

for i in [1..Length(l.SingTypeD)] do
if i mod 2 = 1 then 
n:=n+l.SingTypeD[i]*2;
else 
n:=n+l.SingTypeD[i];
fi;
od;

n:=n+l.SingTypeE[2];
 

return n;
end;
#************************************************


#***************************
#
# ADD Functions
#
#***************************


#***************************
AddDiscr:=function(Dato)
#--------------------------
#
# To a record of ADE sing. it add the record of the 
# discriminant group of the lattice
#
#---------------------------

return rec(SingTypeA:=Dato.SingTypeA, SingTypeD:=Dato.SingTypeD, SingTypeE:=Dato.SingTypeE, DiscGro:=DiscGro(Dato));
end;
#***************************

#***************************
AddEll:=function(Dato)
#--------------------------
#
# To a record of ADE sing.+DiscGro it add the record of the 
# length of the lattice
#
#---------------------------

return rec(SingTypeA:=Dato.SingTypeA, SingTypeD:=Dato.SingTypeD, SingTypeE:=Dato.SingTypeE, DiscGro:=DiscGro(Dato), ell:=Sum(ReducedPrimeCyclesAB(DiscGro(Dato))));
end;



#***************************
AddZ2:=function(Dato)
#--------------------------
#
# To a record of ADE sing.+DiscGro it add the record of the 
# length of the lattice
#
#---------------------------

return rec(SingTypeA:=Dato.SingTypeA, SingTypeD:=Dato.SingTypeD, SingTypeE:=Dato.SingTypeE, DiscGro:=DiscGro(Dato), rk:=TheRank(Dato), DiscriminantGroup:=DiscGro(Dato), ell:=Sum(ReducedPrimeCyclesAB(DiscGro(Dato))), Z2Num:=Z2Count(Dato));
end;
#***************************


#***************************
CompileADEList:=function(rk)
#----------------------------
#
# Given the rank (rk) it returns all possible ADE conf. for this rank.
#
#-----------------------------
local A,List,List1,List2, a;

List:=[];
List1:=[];
List2:=[];
A:=SingAi(rk);
Append(A,SingDi(rk));
Append(A,SingEi(rk));
Append(A,SingAiDi(rk));
Append(A,SingAiEi(rk));
Append(A,SingDiEi(rk));
Append(A,SingAiDiEi(rk));

# we add here some useful information

for a in A do
Add(List1, AddDiscr(a));
Add(List2, AddEll(a));
Add(List,  AddZ2(a));
od;

 return List;
end;
#*************************************************


#***************************
StampaADE:=function(ll)
#----------------------------
#
# This is a function to print the record ll in a nice and readeble way. 
#
#-----------------------------
#***************************

local l,t,Ei,r,i,rd,j,re;

	l:=ll.SingTypeA; 
			r:=Length(l);
				if r >1 then 
					for i in [1..r-1] do
						if l[i] > 0 then
                				Print(l[i], "A_", i);
						if AllZero(l,i) then 
						Print("+");
						fi;fi;
					od;
				if l[r] > 0 then 
				Print(l[r], "A_", r);
				fi;
				else 
				Print(l[r], "A_", r);
		       		fi;

			
	

	 t:=ll.SingTypeD;
		rd:=Length(t);
				if Sum(t)> 0 and Sum(l)>0 then
				Print("+"); fi;
		if rd > 1 then
			for j in [1..rd-1] do
				if t[j] > 0 then 
          	      		Print(t[j], "D_", j+3);
					if AllZero(t,j) then 
					Print("+");
				fi;fi;
			od;
			if t[rd] > 0 then 
			Print(t[rd], "D_", rd+3);
			else
			#Print(";\n\n");
			fi;
		else
		Print(t[rd], "D_", rd+3);
		fi;
	
		

		Ei:=ll.SingTypeE;
		re:=Length(Ei);
				if Sum(Ei)> 0 and Sum(t)+Sum(l)>0 then
				Print("+"); fi;
				if re > 1 then
					for j in [1..re-1] do
						if Ei[j] > 0 then 
          	     					 Print(Ei[j], "E_", j+5);
							if AllZero(Ei,j) then 
							Print("+");
						fi;fi;
					od;
				if Ei[re] > 0 then 
				Print(Ei[re], "E_", re+5, ";\n\n");
				else
				Print(";\n\n");
				fi;
				else
				Print(Ei[re], "E_", re+5, ";\n\n");
				#Print("\n\n");
				fi;

return 0;
end;
#************************************************


#***************************
StampaADESage:=function(ll)
#***************************

local l,t,Ei,r,i,rd,j,re;
Print("print(''");
	l:=ll.SingTypeA; 
			r:=Length(l);
				if r >1 then 
					for i in [1..r-1] do
						if l[i] > 0 then
                				Print(l[i], "A_", i);
						if AllZero(l,i) then 
						Print("+");
						fi;fi;
					od;
				if l[r] > 0 then 
				Print(l[r], "A_", r);
				fi;
				else 
				Print(l[r], "A_", r);
		       		fi;

			
	

	 t:=ll.SingTypeD;
		rd:=Length(t);
				if Sum(t)> 0 and Sum(l)>0 then
				Print("+"); fi;
		if rd > 1 then
			for j in [1..rd-1] do
				if t[j] > 0 then 
          	      		Print(t[j], "D_", j+3);
					if AllZero(t,j) then 
					Print("+");
				fi;fi;
			od;
			if t[rd] > 0 then 
			Print(t[rd], "D_", rd+3);
			else
			#Print(";\n\n");
			fi;
		else
		Print(t[rd], "D_", rd+3);
		fi;
	
		

		Ei:=ll.SingTypeE;
		re:=Length(Ei);
				if Sum(Ei)> 0 and Sum(t)+Sum(l)>0 then
				Print("+"); fi;
				if re > 1 then
					for j in [1..re-1] do
						if Ei[j] > 0 then 
          	     					 Print(Ei[j], "E_", j+5);
							if AllZero(Ei,j) then 
							Print("+");
						fi;fi;
					od;
				if Ei[re] > 0 then 
				Print(Ei[re], "E_", re+5);
				else
				# Print(";\n\n");
				fi;
				else
				Print(Ei[re], "E_", re+5);
				#Print("\n\n");
				fi;
Print("'')\n");

return 0;
end;
#************************************************


#************************************************
BM_ADE:=function(l)
#------------------------------------------------
#
# This function returns the intersection matrix of the record l
#
# Sono da girare
#-------------------------------------------------
local M,M1,i,j,rk, ListA, ListD, ListE;

rk:=TheRank(l);

M:=[];
# Qui inseriamo le liste al contrario perché consideriamo sempre prima le singolarità di rango più grande.
ListA:=Reversed(IntegersList(Length(l.SingTypeA)));
ListD:=Reversed(IntegersList(Length(l.SingTypeD)));
ListE:=Reversed(IntegersList(Length(l.SingTypeE)));

for i in ListE do
		if l.SingTypeE[i] <> 0 then 
			for j in [1..l.SingTypeE[i]] do
			Add(M, EiMatrix(i));
			od;
		fi;
	od;

for i in ListD do
		if l.SingTypeD[i] <> 0 then 
			for j in [1..l.SingTypeD[i]] do
			Add(M, DiMatrix(i));
			od;
		fi;
	od;


	for i in ListA do
		if l.SingTypeA[i] <> 0 then 
			for j in [1..l.SingTypeA[i]] do
			Add(M, AiMatrix(i));
			od;
		fi;
	od;

M1:=BlockMatrixADE(M,rk);

return M1;
end;

##***************************
# Example usage
# Dato:=rec(
#   SingTypeA := [ 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
# BM_ADE(Dato);
##***************************

#***************************
StampaADE:=function(ll)
#***************************

local l,t,Ei,r,i,rd,j,re;

	l:=ll.SingTypeA; 
			r:=Length(l);
				if r >1 then 
					for i in [1..r-1] do
						if l[i] > 0 then
                				Print(l[i], "A_", i);
						if AllZero(l,i) then 
						Print("+");
						fi;fi;
					od;
				if l[r] > 0 then 
				Print(l[r], "A_", r);
				fi;
				else 
				Print(l[r], "A_", r);
		       		fi;

			
	

	 t:=ll.SingTypeD;
		rd:=Length(t);
				if Sum(t)> 0 and Sum(l)>0 then
				Print("+"); fi;
		if rd > 1 then
			for j in [1..rd-1] do
				if t[j] > 0 then 
          	      		Print(t[j], "D_", j+3);
					if AllZero(t,j) then 
					Print("+");
				fi;fi;
			od;
			if t[rd] > 0 then 
			Print(t[rd], "D_", rd+3);
			else
			#Print(";\n\n");
			fi;
		else
		Print(t[rd], "D_", rd+3);
		fi;
	
		

		Ei:=ll.SingTypeE;
		re:=Length(Ei);
				if Sum(Ei)> 0 and Sum(t)+Sum(l)>0 then
				Print("+"); fi;
				if re > 1 then
					for j in [1..re-1] do
						if Ei[j] > 0 then 
          	     					 Print(Ei[j], "E_", j+5);
							if AllZero(Ei,j) then 
							Print("+");
						fi;fi;
					od;
				if Ei[re] > 0 then 
				Print(Ei[re], "E_", re+5, ";\n\n");
				else
				Print(";\n\n");
				fi;
				else
				Print(Ei[re], "E_", re+5, ";\n\n");
				#Print("\n\n");
				fi;

return 0;
end;
#************************************************


#***************************
StampaADE2:=function(ll)
#***************************

local l,t,Ei,r,i,rd,j,re;

	l:=ll.SingTypeA; 
			r:=Length(l);
				if r >1 then 
					for i in [1..r-1] do
						if l[i] > 0 then
                				Print(l[i], "A_", i);
						if AllZero(l,i) then 
						Print("+");
						fi;fi;
					od;
				if l[r] > 0 then 
				Print(l[r], "A_", r);
				fi;
				else 
				Print(l[r], "A_", r);
		       		fi;

			
	

	 t:=ll.SingTypeD;
		rd:=Length(t);
				if Sum(t)> 0 and Sum(l)>0 then
				Print("+"); fi;
		if rd > 1 then
			for j in [1..rd-1] do
				if t[j] > 0 then 
          	      		Print(t[j], "D_", j+3);
					if AllZero(t,j) then 
					Print("+");
				fi;fi;
			od;
			if t[rd] > 0 then 
			Print(t[rd], "D_", rd+3);
			else
			#Print(";\n\n");
			fi;
		else
		Print(t[rd], "D_", rd+3);
		fi;
	
		

		Ei:=ll.SingTypeE;
		re:=Length(Ei);
				if Sum(Ei)> 0 and Sum(t)+Sum(l)>0 then
				Print("+"); fi;
				if re > 1 then
					for j in [1..re-1] do
						if Ei[j] > 0 then 
          	     					 Print(Ei[j], "E_", j+5);
							if AllZero(Ei,j) then 
							Print("+");
						fi;fi;
					od;
				if Ei[re] > 0 then 
				Print(Ei[re], "E_", re+5);
				else
				# Print(";\n\n");
				fi;
				else
				Print(Ei[re], "E_", re+5);
				#Print("\n\n");
				fi;


return 0;
end;


count_vectors:=function(Dato)

local i,j,k;

i:=0;
j:=0;
k:=0;

if IsBound(Dato.V1) then
	i:=1;
fi;

if IsBound(Dato.V2) then
	i:=2;
fi;

if IsBound(Dato.V3) then
	i:=3;
fi;

if IsBound(Dato.V4) then
	i:=4;
fi;

if IsBound(Dato.W1) then
	j:=1;
fi;

if IsBound(Dato.W2) then
	j:=2;
fi;


return i+j+k;
end;
