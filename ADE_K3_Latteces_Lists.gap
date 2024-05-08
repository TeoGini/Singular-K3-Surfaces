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


# The following progam contais some useful function from my privite library
Read("HelpFunc_ADE.gap");
# The following program contains the generating functions that gives all the possible ADE-Lattices
Read("ADE_List_Prog.gap");
# The following program givces the block tipe of even divisible vectors
Read("EvenBlock_ADE.gap");
# The following program givces the block tipe of odd divisible vectors
Read("OddBlock_ADE.gap");
# The following program is for adding the 2-divisible vectors
Read("ADE_2_DivisibleVectors.gap");
# The following program is for adding the 3-divisible vectors
Read("ADE_3_DivisibleVectors.gap");
# The following program gives the intersection matrix of the lattice
Read("MatrixChange.gap");



#------------------------------------------------------------------
#
# Vengono compilate le liste successive
#
#------------------------------------------------------------------



#**************************************************
CompileGoodList:=function(A)
#--------------------------------------------
#
# Given a list of records of ADE singularities
# it return two lists:
# GoodList= ADE record that corresponds to a lattice for a K3 surfae
# BadList= ADE singularities that may correspond to a lattice of a K3 surface but
# further investigation are needed.
# 
# 
# EXAMPLE
# 
# L:=[];
# L[1]:=rec(
# SingTypeA := [ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],ell:=12
# );
# L[2]:=rec(
# SingTypeA := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ], ell:=2
# );
# CompileGoodList(L);
# [ [ rec( SingTypeA := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            # , SingTypeE := [ 0, 0, 0 ], ell := 2 ) ], 
#   [ rec( SingTypeA := [ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
            #  ], SingTypeE := [ 0, 0, 0 ], ell := 12 ) ] ]
# 
# Data una lista di dati di sin Compila due liste la lista dei casi che non hanno bisogno di ulteriore 
# analisi GoodList. La second BadList 
# contiene i casi che hanno bisogno di analisi e i casi Nikulin che hanno bisogno 
# dell'ultimo test di Nikulin Thm 12.1
# Returns [Good, Bad] 
#
#
#---------------------------------------------
local a,GoodList,BadList;

GoodList:=[];
BadList:=[];

for a in A do 
    a.blks:=BlocksClean(AttachBlocks(a));
	if a.ell < (22-a.rk) then 	
	Add(GoodList,a);
	else
	Add(BadList, a);
	fi;
od;
	
return [GoodList,BadList];
end;
#***************************


#--------------------------
TotalVector:=function(blks)
#--------------------------
#
# Given a block it returns a vector of length rk
# with all possivle two divisible block subvectors
#
#--------------------------
local L, i, j, blksVect;

L:=Reversed(BlocksClean(blks));
blksVect:=[[]];
for i in [1..Length(L)] do 
		for j in [1..L[i].BlockNumber] do
			Add(blksVect,L[i].Block);
		od;
od;

Remove(blksVect,1);

return blksVect;
end;
#--------------------------


#***************************
CompileGoodListII:=function(B,GoodList)
#--------------------------------
#
# This fuction add a FIRST 2-Divisible Vector if posseble when neede
# 
# INPUT: 2 lists of ADE sings, B=BadList coming from CompileGoodList, GoodList of CompileGoodList
# OUTPUT 4 lists of ADE sings (Good, Bad (to be further analyzed), 
# Nik (stop here give it to SAGE), Dis (discarded))
# 
# The function add a 2-divisible vector V1 and modify the blocks erasing
# the onces used to construct the divisible vector.
# 
# EXAMPLE
# 
# L:=[];
# L[1]:=rec(
# SingTypeA := [ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],ell:=10, 
# DiscGro:=[ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
# );
# L[2]:=rec(
# SingTypeA := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ], ell:=2, 
#  DisGro:= [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
# );
# L1:=CompileGoodList(L);
# [ [ rec( SingTypeA := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            # , SingTypeE := [ 0, 0, 0 ], ell := 2 ) ], 
#   [ rec( SingTypeA := [ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
            #  ], SingTypeE := [ 0, 0, 0 ], ell := 10 ) ] ]
# CompileGoodListII(L1[2],L1[1]);
# [ [ rec( DisGro := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
        #   SingTypeA := [ 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
            #  ], SingTypeE := [ 0, 0, 0 ], ell := 2 ) ], 
#   [ rec( BV1 := [ [ 1/2, 0, 1/2 ], [ 1/2, 0, 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 0, 0, 0, 0, 0, 0 ] ], 
        #   Blocks := [ rec( Block := [ 1/2 ], BlockLength := 1, BlockNumber := 6, Blocktype := [ 1, 1 ] ) ], 
        #   DiscGro := [ 8, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
        #   SingTypeA := [ 10, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
        #   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], SingTypeE := [ 0, 0, 0 ], 
        #   V1 := [ 1/2, 0, 1/2, 1/2, 0, 1/2, 1/2, 1/2, 1/2, 1/2, 0, 0, 0, 0, 0, 0 ], ell := 10 ) ], [  ], [  ] ]
# 
# Notice that the ell droped by two but is still not enougth to guarantee that
# that the lattice is of K3. 
#--------------------------------

local BadList, NikList, DisList,b,n,V;

BadList:=[];
NikList:=[];
DisList:=[];

for b in B do 
    b.TotV:=TotalVector(b.blks);
	if not IsGoodBlock(b.blks,8) then
		if  b.ell=22-b.rk then
		    Add(NikList,b);	
		else
		    Add(DisList,b);	
	    fi; 
   fi;
    if IsGoodBlock(b.blks,8) then
	# Se ho blocchi suff. costruisco il vettore nuovo
		b.BV1:=I_Blk_Vect(b.TotV);
		V:=Flat(b.BV1);
		if  D2nDetect(b)[1] then
		 	b.Blocks:=BlocksClean(InsertD2nNewBlock(INewBlock(b.blks,9),b,D2nDetect(b)[2],D2nDetect(b)[3])); ###<------------Devo inserire il blocco che ho tolto giusto
		else
			b.Blocks:=BlocksClean(INewBlock(b.blks,9));	
		fi; 
		# ora faccio i test
		if Couni(V,1/2)=8 then
			if  b.ell-2<22-b.rk then
			    b.DiscGro[1]:=b.DiscGro[1]-2;
			    b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			    b.V1:=V;
			    Add(GoodList,b);
			else
			    b.DiscGro[1]:=b.DiscGro[1]-2;
			    b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			    b.V1:=V;
			    Add(BadList,b);
			fi;
		else
			if b.ell=22-b.rk then
				#b.V1:=V;
				Add(NikList,b);
			else;
				Add(DisList,b);
			fi;
		fi;
	fi;
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************




#*********************************
CompileGoodListIII:=function(B,GoodList,NikList,DisList) 

#--------------------------------
#
# This fuction works very similar to the previous one
# it adds a SECOND 2-Divisible Vector if posseble when neede
# 
# INPUT: 4 lists of ADE sings, B=BadList coming from CompileGoodListII, GoodList, NikList and DisList
# OUTPUT 4 lists of ADE sings (Good, Bad (to be further analyzed), 
# Nik (stop here give it to SAGE), Dis (discarded))
# 
# The function works only on the list B! It takes b in B and does the following:
# It adds to b  a second 2-divisible vector V2 to  and modify the blocks erasing
# the onces used to construct the divisible vector if possible.
# If it can add V2 and ell-2< 22-rk then b is included in GoodList.
# If it cannot add V2 and the ell excide the 22-rk then b is included in DisList.
# If t cannot add V2 and the ell is equal to 22-rk then b is included in NikList.
# For all the other cases b is included in BadList (to be further analyzed).
#
#--------------------------------

local  BadList,b,V2,BV2;

BadList:=[];

for b in B do 
	if not IsGoodBlock(b.Blocks,4) or not SecondVectorTest(b.Blocks) then
		if  b.ell=22-b.rk and not b in NikList then
			Add(NikList,b);	
		else
			Add(DisList,b);	
		fi; 
	fi;

	if IsGoodBlock(b.Blocks,4) and SecondVectorTest(b.Blocks) then
        BV2:=II_Blk_Vect(b.TotV,b.BV1,b,4);
		V2:=Flat(BV2);
		if D2nDetect(b)[1] then
			b.Blocks:=RemoveD2nBlock(b.Blocks);
		fi;	
		if Sum(V2)=4 then 
			if D2nDetect(b)[1] then
				b.Blocks:=BlocksClean(INewBlock(b.Blocks,5-Sum(D2nDetect(b)[3])));
			else 
				b.Blocks:=BlocksClean(INewBlock(b.Blocks,5));
			fi;	 
			if  b.ell-2<22-b.rk then
				b.DiscGro[1]:=b.DiscGro[1]-2;
				b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
                b.BV2:=BV2;
				b.V2:=V2;
				Add(GoodList,b);
			else
				b.DiscGro[1]:=b.DiscGro[1]-2;
				b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
                b.BV2:=BV2;
				b.V2:=V2;
				Add(BadList,b);
			fi;
		else	
			if  b.ell=22-b.rk and not b in NikList then
				Add(NikList,b);	
			else
				Add(DisList,b);	
			fi;
		fi;
	fi;	
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************


#*********************************
CompileGoodListIV:=function(B,GoodList,NikList,DisList) 

#--------------------------------
#
# This fuction works very similar to the previous ones
# it adds a THIRD 2-Divisible Vector if posseble when neede
# 
# INPUT: 4 lists of ADE sings, B=BadList coming from CompileGoodListII, GoodList, NikList and DisList
# OUTPUT 4 lists of ADE sings (Good, Bad (to be further analyzed), 
# Nik (stop here give it to SAGE), Dis (discarded))
# 
# The function works only on the list B! It takes b in B and does the following:
# It adds to b  a third 2-divisible vector V3 to  and modify the blocks erasing
# the onces used to construct the divisible vector if possible.
# If it can add V3 and ell-2< 22-rk then b is included in GoodList.
# If it cannot add V3 and the ell excide the 22-rk then b is included in DisList.
# If t cannot add V3 and the ell is equal to 22-rk then b is included in NikList.
# For all the other cases b is included in BadList (to be further analyzed).
#
# WARNIGS! This fuction does not preserves block vectors, meaning that a further test
# on V3 is needed, this test will be done later and it returns an itersection matrix 
#  either not integral or with determinant 0 if the vector V3 is wrong, meaning it did not
# preserved the bloks.
#--------------------------------

local  BadList,b,V3,BV3;

BadList:=[];

for b in B do 
	if not IsGoodBlock(b.Blocks,2) or not ThirdVectorTest(b.blks) or IsBlockTooBig(b,b.blks,b.rk,3) then #Qui ho cambiato da attachblock a b.blocks
		if  b.ell=22-b.rk then
			Add(NikList,b);	
		else
			Add(DisList,b);	
		fi; 
    fi;

#if b.SingTypeA[1] = 14 then 
#    Print(IsGoodBlock(b.Blocks,2), "\n");
#    Print(ThirdVectorTest(b.blks), "\n"); 
#    Print(not IsBlockTooBig(b,b.blks,b.rk,3), "\n" );
#fi;



	if IsGoodBlock(b.Blocks,2) and ThirdVectorTest(b.blks) and not IsBlockTooBig(b,b.blks,b.rk,3) then #Qui ho cambiato da attachblock a b.blocks
		#V3:=NewVect3(b.Blocks,b.V1,b.V2,rk);
		BV3:=III_Blk_Vect(b.TotV,b.BV1,b.BV2,b,2);
		V3:=Flat(BV3);
		b.Blocks:=BlocksClean(INewBlock(b.Blocks,3)); 
		if Sum(V3)=4 then
			if  b.ell-2<22-b.rk then
				b.DiscGro[1]:=b.DiscGro[1]-2;
				b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
				b.BV3:=BV3;
				b.V3:=V3;
				Add(GoodList,b);
			else
				b.DiscGro[1]:=b.DiscGro[1]-2;
				b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
				b.V3:=V3;
				b.BV3:=BV3;
				Add(BadList,b);
			fi;
		else	
			if  b.ell=22-b.rk and not b in NikList then
				Add(NikList,b);	
			else
				Add(DisList,b);	
			fi;
		fi;		
	fi;
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************




#*********************************
CompileGoodListV:=function(B,GoodList,NikList,DisList) 

#--------------------------------
#
#
# This fuction works very similar to the previous ones
# it adds a FOURTH and LAST 2-Divisible Vector if posseble when neede
# 
# INPUT: 4 lists of ADE sings, B=BadList coming from CompileGoodListII, GoodList, NikList and DisList
# OUTPUT 4 lists of ADE sings (Good, Bad (to be further analyzed), 
# Nik (stop here give it to SAGE), Dis (discarded))
# 
# The function works only on the list B! It takes b in B and does the following:
# It adds to b the FOURTH 2-divisible vector V4 to  and modify the blocks erasing
# the onces used to construct the divisible vector if possible.
# If it can add V4 and ell-2< 22-rk then b is included in GoodList.
# If it cannot add V4 and the ell excide the 22-rk then b is included in DisList.
# If t cannot add V4 and the ell is equal to 22-rk then b is included in NikList.
# For all the other cases b is included in BadList (to be further analyzed).
#
# WARNIGS! This fuction does not preserves block vectors, meaning that a further test
# on V4 is needed, this test will be done later and it returns an itersection matrix 
#  either not integral or with determinant 0 if the vector V4 is wrong, meaning it did not
# preserved the bloks.
#--------------------------------

local  BadList,b,V4,BV4;


BadList:=[];


for b in B do 
	if not IsGoodBlock(b.Blocks,1) or not FourthVectorTest(b.blks) or IsBlockSTooBig(b,b.blks,b.rk,2) then #Qui ho cambiato da attachblock a b.blocks
		if  b.ell=22-b.rk then
			Add(NikList,b);	
		else
			Add(DisList,b);	
		fi; 
	fi;


	if IsGoodBlock(b.Blocks,1) and FourthVectorTest(b.blks) and Length(b.V3)<=b.rk and not IsBlockSTooBig(b,b.blks,b.rk,2) then #Qui ho cambiato da attachblock a b.blocks
	    #Print("------\n");
		#Print(b, "\n");
		#Print("------\n");
        BV4:=IV_Blk_Vect(b.TotV,b.BV1,b.BV2,b.BV3,b,1);
		V4:=Flat(BV4);
		b.Blocks:=BlocksClean(INewBlock(b.Blocks,2)); 
		if  b.ell-2<22-b.rk then
			b.DiscGro[1]:=b.DiscGro[1]-2;
			b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			b.BV4:=BV4;
			b.V4:=V4;
			Add(GoodList,b);
		else
			b.DiscGro[1]:=b.DiscGro[1]-2;
			b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			b.V4:=V4;
			b.BV4:=BV4;
			Add(BadList,b);
		fi;
	fi;
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************
#
# 
# HERE BELOW WE TAKE INTO ACCOUNT ALSO THE 3-DIVISIBLE VECTORS
# WE ADD IF POSSIBLE THE 3 DIVISIBLE VECTORS WITH THE SAME ALGORITHM AS ABOVE
#
#
#*********************************

#*********************************
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
#*********************************


#--------------------------------
CompileGoodListZ3I:=function(B,GoodList,NikList,DisList) 
#--------------------------------
#
#
# This fuction works very similar to the previous ones
# it adds a FIRST  3-Divisible Vector if posseble when neede
# 
# INPUT: 4 lists of ADE sings, B=BadList coming from CompileGoodListII, GoodList, NikList and DisList
# OUTPUT 4 lists of ADE sings (Good, Bad (to be further analyzed), 
# Nik (stop here give it to SAGE), Dis (discarded))
# 
# The function works only on the list B! It takes b in B and does the following:
# It adds to b the FIRST 3-divisible vector W1 to  b 
# 
#  WARNINGS! it does NOT modify the blocks  used to construct 
#  the divisible vector!
# 
# If it can add W1 and ell-2< 22-rk then b is included in GoodList.
# If it cannot add W1 and the ell excide the 22-rk then b is included in DisList.
# If t cannot add W1 and the ell is equal to 22-rk then b is included in NikList.
# For all the other cases b is included in BadList (to be further analyzed).
#
# WARNIGS! This fuction does not preserves block vectors, meaning that a further test
# on W1 is needed, this test will be done later and it returns an itersection matrix 
#  either not integral or with determinant 0 if the vector V4 is wrong, meaning it did not
# preserved the bloks.
#--------------------------------

local b,OddBloks,rk,W1,BadList,TotW;


BadList:=[];
for b in B do 
    OddBloks:=AttachBlocksOdd(b);
    b.TotW:=TotalVector(OddBloks);
# ellCopy:=ShallowCopy(b.ell);

		# ora faccio i test
	if CountA2(b) > 5 then
		if  b.ell-2<22-b.rk then
            b.DiscGro[2]:=b.DiscGro[2]-2;
            b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
            b.BW1:=I_Blk_VectZ3(b.TotW);
            b.W1:=Flat(b.BW1);
			Add(GoodList,b);
		else
			b.DiscGro[2]:=b.DiscGro[2]-2;
			b.BW1:=I_Blk_VectZ3(b.TotW);
            b.W1:=Flat(b.BW1);
			b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			Add(BadList,b);
		fi;
	else
		if  b.ell = 22-b.rk then
			Add(NikList,b);
		else
			Add(DisList,b);				
		fi;
	fi;
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************



#*********************************
CompileGoodListZ3II:=function(B,GoodList,NikList,DisList) 
#--------------------------------
#
# Questa funzione prende la badlist vede se può abbassare il rango
#
#--------------------------------

local b,H,rk,W1,BadList;

BadList:=[];
for b in B do 
	if SecondZ3VectorTest(b) or b.SingTypeA[2]<5 then
		if  b.ell=22-b.rk then
			Add(NikList,b);
		else	
			Add(DisList,b);
		fi;
	else
		Add(BadList,b);
	fi;
od;

return [GoodList,BadList,NikList,DisList];
end;
#*********************************


#*********************************
CompileGoodListZ3III:=function(B,GoodList,NikList,DisList) 
#--------------------------------
#
# Qui sappiamo che gli elementi di B ammettono un ulteriore vettore 
# tre divisibile perché è stato calcolato nella funzione CompileGoodListZ3II
# quindi lo aggiungiamo e prepariamo le ultime liste con tutti i vettori divisibili
#
#--------------------------------

local b,w,rk,W1,BadList;

for b in B do 
	b.BW2:=II_Blk_VectZ3(b,2);
	b.W2:=Flat(b.BW2);
    b.DiscGro[2]:=b.DiscGro[2]-2;
	b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
	if  b.ell<22-b.rk then
		Add(GoodList,b);
	fi;
	if b.ell>22-b.rk then
		Add(DisList,b);
	fi;
	if b.ell=22-b.rk then
		Add(NikList,b);
	fi;
od;

return [GoodList,NikList,DisList];
end;
#*********************************


#*********************************
#
# 
# AT THIS POINT ONLY THE NIKULIN'S CASE HAVE TO BE ANALIZED MORE CAREFULLY
# (1) THE FIRST THING WE DO WE ADD THE INTERSECTION MATRIX 
#
#
#*********************************



############################
Add_Nik_Mat:=function(NikList)
# ---------------------------------------------------
# Questa funzione aggiunge la matrice
# di intersezione per i casi di Nikulin
# se non riesce ad aggiungere una matrice
# intera e con det<>0 allora 
# elimina il caso mettendolo in DisList
# ATTENZIONE! i casi D2n devono essere ancora studiati
# RESTITUISCE:
# NikList con matrice e DisList 
# --------------------------------------------------
local b,MST,M,L,NI,i,j,NI2,NI3,NI1,NI4, DisListMat;

L:=[];
NI:=[];
DisListMat:=[];

for b in NikList do
#StampaADE(b);
#Print(b, "\n");
	M:=TheMatrix(b);
#Print(M, "\n");
	if IsIntegralMatrix(M) and Determinant(M) <> 0 then 
		b.Matrix:=M;
	else 
		Add(NI,b);
	fi;
od;


#CON UN VETTORE
NI1:=ShallowCopy(NI);
for b in NI1 do
	# StampaADE(b);
	# Print(b, "\n");
	
	if not IsBound(b.V2) and not IsBound(b.W2) then
		MST:=MultSubTest(b);
         #Print(MST[1],"\n");
		# Verifico se ho una matrice intere e det<>0
		if not MST[1] then
		# Non ho la matrice metto il rec negli scarti
			Add(DisListMat,b);
			Remove(NI,Position(NI,b));
			Remove(NikList,Position(NikList,b));
		else
		# Altrimenti salvo la matrice in 
			b.Matrix:=MultSubMatrix(b,MST[2]);
			Remove(NI,Position(NI,b));
		fi;	
	fi;
od;

# Print("Here OK \n");

#CON DUE VETTORI ripeto lo shema precedente 
NI2:=ShallowCopy(NI);
for b in NI2 do
	# StampaADE(b);
		# Print(b, "\n");
	if not IsBound(b.V3) and IsBound(b.V2) then
		if Length(b.V2)<>TheRank(b) then
			Add(DisListMat,b);
	 		Remove(NI,Position(NI,b));
			Remove(NikList,Position(NikList,b));
		else
			MST:=MultSubTest2V(b);
			# StampaADE(b);
			# Print(MST[1],"\n\n\n");
			if not MST[1] then
				Add(DisListMat,b);
				Remove(NI,Position(NI,b));
				Remove(NikList,Position(NikList,b));
			else
				b.Matrix:=MultSubMatrix2(b,MST[2],MST[3]);
 				Remove(NI,Position(NI,b));
			fi;
		fi;	
	fi;
od;


#CON DUE VETTORI W ripeto lo shema precedente 
NI2:=ShallowCopy(NI);
for b in NI2 do
	# StampaADE(b);
		# Print(b, "\n");
	if IsBound(b.W1) and IsBound(b.W2) then
		if Length(b.W2)<>TheRank(b) then
			Add(DisListMat,b);
	 		Remove(NI,Position(NI,b));
			Remove(NikList,Position(NikList,b));
		else
			MST:=MultSubTest2V(b);
			# StampaADE(b);
			# Print(MST[1],"\n\n\n");
			if not MST[1] then
				Add(DisListMat,b);
				Remove(NI,Position(NI,b));
				Remove(NikList,Position(NikList,b));
			else
				b.Matrix:=MultSubMatrix2(b,MST[2],MST[3]);
 				Remove(NI,Position(NI,b));
			fi;
		fi;	
	fi;
od;
# Print("Here OK \n");
#CON TRE VETTORI


NI3:=ShallowCopy(NI);
#Print("---------",NI3,"---------\n");
for b in NI3 do
	if not IsBound(b.V4) and IsBound(b.V3) then
		if Length(b.V3)<>TheRank(b) or Length(b.V2)<>TheRank(b)  then
			Add(DisListMat,b);
	 		Remove(NI,Position(NI,b));
			Remove(NikList,Position(NikList,b));
		else
			MST:=MultSubTest3V(b);
			if not MST[1] then
				Add(DisListMat,b);
				Remove(NI,Position(NI,b));
				Remove(NikList,Position(NikList,b));
			else
				b.Matrix:=MultSubMatrix3(b,MST[2],MST[3],MST[4]);
				Remove(NI,Position(NI,b));
			fi;
		fi;
	fi;
od;


#CON Quattro VETTORI


NI4:=ShallowCopy(NI);
for b in NI4 do
	if not IsBound(b.W1) and IsBound(b.V4) then
		if Length(b.V3)<>TheRank(b) then
			Add(DisListMat,b);
	 		Remove(NI,Position(NI,b));
			Remove(NikList,Position(NikList,b));
		else
			MST:=MultSubTest4V(b);
			if not MST[1] then
				Add(DisListMat,b);
				Remove(NI,Position(NI,b));
				Remove(NikList,Position(NikList,b));
			else
				b.Matrix:=MultSubMatrix3(b,MST[2],MST[3],MST[4],MST[5]);
				Remove(NI,Position(NI,b));
			fi;
		fi;
	fi;
od;


return [NikList,DisListMat];
end;
#*********************************



#*********************************
#MainMatrixPrint:=function(n)
#
# Dato un numero stampa le matrici di Nikulin se la matrice è intera
# restituisce la ista dei casi non trattati punto [5]. 
#
#*********************************

#local A,GBN,SGBN2,SGBN3,SGBN4,SGBN5,D,DZ2I,DZ3I,Fin,i,L,NS,NI;
#L:=[];
#NI:=[];
#A:=CompileADEList(n);
#GBN:=CompileGoodList(A);
#SGBN2:=CompileGoodListII(GBN[2],GBN[1]);
#SGBN3:=CompileGoodListIII(SGBN2[2],SGBN2[1],SGBN2[3],SGBN2[4]);
#SGBN4:=CompileGoodListIV(SGBN3[2],SGBN3[1],SGBN3[3], SGBN3[4]);
#SGBN5:=CompileGoodListV(SGBN4[2],SGBN4[1],SGBN4[3], SGBN4[4]);
#D:=DetectA2(SGBN5[2],SGBN5[3],SGBN5[4]);
#DZ2I:=CompileGoodListZ3I(D[1],SGBN5[1],D[2],D[3]);
#DZ3I:=FinalTouchZ3(DZ2I[2],DZ2I[1],DZ2I[3],DZ2I[4]);
#Fin:=Compile_FINAL_Lists(DZ3I[2],DZ3I[1],DZ3I[3],DZ3I[4]);

#if Length(Fin[2]) > 0 then 
#for i in [1..Length(Fin[2])] do 
#Print(i, "\n");
#if IsIntegralMatrix(TheMatrix(Fin[2][i])) then 
#PrintTheMatrix(Fin[2][i]);
#Add(L,i);
#fi;
#if not IsIntegralMatrix(TheMatrix(Fin[2][i])) then
#Add(NI,i);
#fi;
#od;
#fi;

#return [L,NI];
#end;
#*********************************





#----------------------------------- 



# ------------------------------------------------------
############################
MainProgramByRank:=function(rk)
############################
# 
# This is the main routine
# INPUT an integer rk with 1<=rk<=19
# OUTPUT a list [num. of GoodCases, num of NikCases (to be given to SAGE), num. DisCase]
# 
# Running the function prints all the needed data one wants to study.
# 
# -----------------------------------------------------------------------
local AllLatticeList, GoodList_0Vects, GoodList_1Vects, GoodList_2Vects, GoodList_3Vects, GoodList_4Vects,NiK_and_Matrix,i,GoodList_4Vects_1Z3Vect,
GoodList_4Vects_2Z3Vects, GoodList_4Vects_1Z3VectII,l, Detected_D2, DC;


# rk:=17;
# j:=rk;
AllLatticeList:=CompileADEList(rk);;
#
# we discard lattices that do not fit 
#
GoodList_0Vects:=CompileGoodList(AllLatticeList);;
#
# We add 2-divisible vectors and we check if we can discard or keep the lattices
#
GoodList_1Vects:=CompileGoodListII(GoodList_0Vects[2],GoodList_0Vects[1]);;
GoodList_2Vects:=CompileGoodListIII(GoodList_1Vects[2],GoodList_1Vects[1],GoodList_1Vects[3],GoodList_1Vects[4]);;
GoodList_3Vects:=CompileGoodListIV(GoodList_2Vects[2],GoodList_2Vects[1],GoodList_2Vects[3],GoodList_2Vects[4]);;
GoodList_4Vects:=CompileGoodListV(GoodList_3Vects[2],GoodList_3Vects[1],GoodList_3Vects[3],GoodList_3Vects[4]);;
#
# We check if we discarded also some lattices that could have a 3-divisible vector, this happens only from rank 16;
#
Detected_D2:=DetectA2(GoodList_4Vects[2],GoodList_4Vects[3],GoodList_4Vects[4]);;
#
# We add 3-divisible vectors and we check if we can discard or keep the lattices
#
GoodList_4Vects_1Z3Vect:=CompileGoodListZ3I(Detected_D2[1],GoodList_4Vects[1],Detected_D2[2],Detected_D2[3]);; 
GoodList_4Vects_1Z3VectII:=CompileGoodListZ3II(GoodList_4Vects_1Z3Vect[2],GoodList_4Vects_1Z3Vect[1],GoodList_4Vects_1Z3Vect[3],GoodList_4Vects_1Z3Vect[4]);;
GoodList_4Vects_2Z3Vects:=CompileGoodListZ3III(GoodList_4Vects_1Z3VectII[2],GoodList_4Vects_1Z3VectII[1],GoodList_4Vects_1Z3VectII[3],GoodList_4Vects_1Z3VectII[4]);;
#
# We add the intersection matrix to the Nikulin cases
#
NiK_and_Matrix:=Add_Nik_Mat(GoodList_4Vects_2Z3Vects[2]);;
#

# Here we have to check if Discro < 0 and see why

DC:=Discgro_Check(GoodList_4Vects_2Z3Vects[1],NiK_and_Matrix[1]);

#GoodList:=DC[1];
#NikList:=DC[2];
#BadDisge:=DC[3];

#-------------------------------------------------------------

Print("------ RANK ", rk, " ---------\n");


Print("Number of Good Cases: ", Length(GoodList_4Vects_2Z3Vects[1]), "\n");
Print("Number of Nikulin Cases: ",Length(NiK_and_Matrix[1]), "\n");
Print("Number of Discarded Cases: ", Length(GoodList_4Vects_2Z3Vects[3]), "\n");
Print("Number  ERROR  Cases: ",Length(NiK_and_Matrix[2]), "\n");
Print("Number  BadDiscrgo  Cases: ",Length(DC[3]), "\n");


#Per stampare velocemente tutti i reticoli senza dati aggiuntivi

#for i in [1..Length(GoodList_4Vects_2Z3Vects[1])] do
#	Print("------ ", i , " Good -------\n");
#	StampaADE(GoodList_4Vects_2Z3Vects[1][i]);
	#Print(GoodList_4Vects_2Z3Vects[1][i],"\n");
#od;




Print("Rank ", rk, " Good Cases: \n"); 
for i in [1..Length(GoodList_4Vects_2Z3Vects[1])] do
	Print("------ ", i , " Good -------\n");
	StampaADE(GoodList_4Vects_2Z3Vects[1][i]);
    # HERE IS A GOOD POINT TO SEARCH FOR MISTAKES
	#if IsBound(GoodList_4Vects_2Z3Vects[1][i].V4) then
    #if Sum(GoodList_4Vects_2Z3Vects[1][i].V4) <> 4 then
    #    Print("ERROR ERROR \n");
    #fi;    
    #fi;
	Print(GoodList_4Vects_2Z3Vects[1][i],"\n");
#
	if CountA1(GoodList_4Vects_2Z3Vects[1][i]) = 16 then
		Print(" ---ABELIAN--- \n");
	fi;
#
	if CountA2(GoodList_4Vects_2Z3Vects[1][i]) >=9 then
		Print(" ---ABELIAN--- \n");
	fi;
#
	if AinotA3(GoodList_4Vects_2Z3Vects[1][i].SingTypeA)=6 and CountA3(GoodList_4Vects_2Z3Vects[1][i]) >3 then
		Print(" ---ABELIAN--- \n");
	fi;
#
	if CountA5(GoodList_4Vects_2Z3Vects[1][i])=1 and CountA2(GoodList_4Vects_2Z3Vects[1][i])-2>3 and CountA1(GoodList_4Vects_2Z3Vects[1][i])-3>4 then
		Print(" ---ABELIAN--- \n");
	fi;
#
	Print("-------------\n");
od;

Print("-------------\n\n\n\n");

Print("Rank ", rk, " Nikulin Cases: ");
if  Length(NiK_and_Matrix[1]) = 0 then
	Print("None. \n");
else 
	Print("\n");
fi;

for i in [1..Length(NiK_and_Matrix[1])] do
	Print("------ ", i , " Nikulin -------\n");
	StampaADE(NiK_and_Matrix[1][i]);
	Print(NiK_and_Matrix[1][i],"\n");
	Print("-------------\n\n");
od;

Print("Rank ", rk, " Discarded Cases: "); 
if  Length(GoodList_4Vects_2Z3Vects[3]) = 0 then
	Print("None. \n");
else 
	Print("\n");
fi;	
for i in [1..Length(GoodList_4Vects_2Z3Vects[3])] do
	Print("------ ", i, " Discarded -------\n");
	StampaADE(GoodList_4Vects_2Z3Vects[3][i]);
	Print(GoodList_4Vects_2Z3Vects[3][i],"\n\n");
	Print("-------------\n\n");
od;

Print("Rank ", rk, " ERROR Cases !!!: ");
if  Length(NiK_and_Matrix[2]) = 0 then
	Print("None. \n");
else 
	Print("\n");
fi;

for i in [1..Length(NiK_and_Matrix[2])] do
	Print("------ ", i , " ERROR -------\n");
	StampaADE(NiK_and_Matrix[2][i]);
	Print(NiK_and_Matrix[2][i],"\n");
	Print("-------------\n\n");
od;




Print("COPY FOR SEGE BELOW \n\n");

#for l in NiK_and_Matrix[1] do
#	MatrixForSagePrint(l);;
#od;


for l in NiK_and_Matrix[1] do
	ForSagePrint(l);;
od;



return [DC[3],Length(GoodList_4Vects_2Z3Vects[1]),Length(NiK_and_Matrix[1]),Length(GoodList_4Vects_2Z3Vects[3]),Length(NiK_and_Matrix[2]),NiK_and_Matrix[2]];
end;



############################
AbelianCoverPrint:=function(rk)
############################
# 
# This is the main routine
# INPUT an integer rk with 1<=rk<=19
# OUTPUT a list [num. of GoodCases, num of NikCases (to be given to SAGE), num. DisCase]
# 
# Running the function prints all the needed data one wants to study.
# 
# -----------------------------------------------------------------------
local A,i,L,j;

# rk:=17;
# j:=rk;
A:=CompileADEList(rk);;
# Length(A);


#-------------------------------------------------------------

Print("------ RANK ", rk, " ---------\n");

j:=0;
Print("Rank ", rk, " Abelian Cover Cases: \n"); 
for i in [1..Length(A)] do
	
	

#
	if CountA1(A[i]) = 16 then
		Print("------ ", i , " Abelian -------\n");
		StampaADE(A[i]);
		j:=j+1;
	fi;
#
	if CountA2(A[i]) >=9 then
		Print("------ ", i , " Abelian -------\n");
		StampaADE(A[i]);
		j:=j+1;
	fi;
#
	if AinotA3(A[i].SingTypeA)=6 and CountA3(A[i]) >3 then
		Print("------ ", i , " Abelian -------\n");
		StampaADE(A[i]);
		j:=j+1;
	fi;
#
	if CountA5(A[i])=1 and CountA2(A[i])-2>3 and CountA1(A[i])-3>4 then
		Print("------ ", i , " Abelian -------\n");
		StampaADE(A[i]);
		j:=j+1;
	fi;
#
	# Print("-------------\n");
od;

Print("-------------\n\n\n\n");


return j;
end;
#-------------------------------------------------------------

# Example usage
#Read("ADE_K3_Latteces_Lists.gap");

#OutputLogTo("OUTPUT_ADE_K3_Latteces_19");

#Good:=0;
#Nikulin:=0;
#Disc:=0;
#Errors:=0;

#for rk in [1..19] do
#	M:=MainProgramByRank(rk);

#	Good:=Good+M[1];
#	Nikulin:=Nikulin+M[2];
#	Disc:=Disc+M[3];
#	Errors:=Errors+M[4];
#od;
#Print("GoodTot=", Good, "\n");
#Print("NikulinTot=", Nikulin, "\n");
#Print("DiscTot=", Disc, "\n");
#Print("ErrorsTot=", Errors, "\n");
