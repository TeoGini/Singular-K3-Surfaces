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


Read("ADE_K3_Latteces_Lists.gap");
Read("HigherBlock_ADE.gap");





#**************************************************
Compile_ADE_List_with_vectors:=function(All_Possible_ADE_List)
#--------------------------------------------



local a, Dato, V, V1, V2, V3, V4, Z4_1, W1, BV1, BV2, BV3, BV4, BW1, BZ4, OddBloks,High4blks, unita, unita2,M;
unita2:=0;
unita:=1;

for Dato in All_Possible_ADE_List do 
    Dato.M2:=BM_ADE(Dato);
    Dato.blks:=BlocksClean(AttachBlocks(Dato));
    Dato.TotV:=TotalVector(Dato.blks);
	### DA qui proviamo ad aggiungere il primo vettore
    if IsGoodBlock(Dato.blks,8) then
        Dato.BV1:=I_Blk_Vect(Dato.TotV);
		V:=Flat(Dato.BV1);
		if  D2nDetect(Dato)[1] then
		 	Dato.Blocks:=BlocksClean(InsertD2nNewBlock(INewBlock(Dato.blks,9),Dato,D2nDetect(Dato)[2],D2nDetect(Dato)[3])); ###<------------Devo inserire il blocco che ho tolto giusto
		else
			Dato.Blocks:=BlocksClean(INewBlock(Dato.blks,9));	
		fi; 
		# ora faccio i test
		if Couni(V,1/2)=8 then
			Dato.DiscGro[1]:=Dato.DiscGro[1]-2;
			#Dato.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
			Dato.V1:=V;
              ### DA QUI proviamo ad aggiungere il secondo vettore
            if IsGoodBlock(Dato.Blocks,4) and SecondVectorTest(Dato.Blocks) then
                BV2:=II_Blk_Vect(Dato.TotV,Dato.BV1,Dato,4);
		        V2:=Flat(BV2);
		        if D2nDetect(Dato)[1] then
			        Dato.Blocks:=RemoveD2nBlock(Dato.Blocks);
		        fi;	
		        if Sum(V2)=4 then 
			            if D2nDetect(Dato)[1] then
				            Dato.Blocks:=BlocksClean(INewBlock(Dato.Blocks,5-Sum(D2nDetect(Dato)[3])));
			            else 
				            Dato.Blocks:=BlocksClean(INewBlock(Dato.Blocks,5));
			            fi;	
				        #Dato.DiscGro[1]:=Dato.DiscGro[1]-2;
				        #Dato.ell:=Sum(ReducedPrimeCyclesAB(Dato.DiscGro));
                        Dato.BV2:=BV2;
				        Dato.V2:=V2;
                        # Qui il caso 3A_1+2A_3+2A_5 non è possibile trattarlo con l'algoritmo corrente
                        # perché non può prendere entrambi gli A5 per il primo vettore quindi forziamo 
                        # il risultato corretto
                        if Dato.SingTypeA[1] = 3 and Dato.SingTypeA[3]=2 and Dato.SingTypeA[5]=2 then
                            Dato.V1:=[1/2,0,1/2,0,1/2,0,0,0,0,0,1/2,0,1/2,1/2,0,1/2,1/2,0,0];
                            Dato.V2:=[1/2,0,1/2,0,1/2,1/2,0,1/2,0,1/2,0,0,0,0,0,0,1/2,1/2,0];
                        fi;
                        # Qui il caso 4A_1+2A_3+1A_9 non è possibile trattarlo con l'algoritmo corrente
                        if Dato.SingTypeA[1] = 4 and Dato.SingTypeA[3]=2 and Dato.SingTypeA[9]=1 then
                            Unbind(Dato.V2); 
                        fi;
                            #### DA QUI proviamo ad inserire il terzo vettore
                    if IsGoodBlock(Dato.Blocks,2) and ThirdVectorTest(Dato.blks) and not IsBlockTooBig(Dato,Dato.blks,Dato.rk,3) then #Qui ho cambiato da attachblock a b.blocks
	                        	#V3:=NewVect3(b.Blocks,b.V1,b.V2,rk);
		                BV3:=III_Blk_Vect(Dato.TotV,Dato.BV1,Dato.BV2,Dato,2);
		                V3:=Flat(BV3);
		                Dato.Blocks:=BlocksClean(INewBlock(Dato.Blocks,3)); 
                        if Count_common_12_23_123(Dato.BV1,Dato.BV2,BV3) <> [2,2,2,2]then
                            M:=Multiple_Vector_Triples(Dato, BV3);
                            #Print("-----------------------------------------------\n");
                            #StampaADE(Dato);
                            #Print(M, "\n");
                            #Print("-----------------------------------------------\n");
                            if Sum(Flat(M[2])) = 4 and Sum(Flat(M[1])) = 4 then 
                                Print(M, "\n");
                                Dato.BV1:=M[1];
                                Dato.V1:=Flat(Dato.BV1);
                                Dato.BV2:=M[2];
                                Dato.V2:=Flat(Dato.BV2);
                                BV3:=M[3];
                                V3:=Flat(BV3);
                            fi;
                        fi;
		                if Sum(V3)=4 and Count_common_12_23_123(Dato.BV1,Dato.BV2,BV3) = [2,2,2,2] then
                            #if Count_common_12_23_123(Dato.V1,Dato.V2,V3) <> [2,2,2,2] then 
                             #   Print("----", unita,"---\n");
                              #  StampaADE(Dato);
                               # Print("Vettore Totale--->", Dato.TotV,"\n");
                                #Print("Vettore Sbagliato--->", BV3, "\n");
                                #Print(Dato, "\n");
                                #Print("-------\n");
                                #unita:=unita+1;
                            #fi;
                                #b.DiscGro[1]:=b.DiscGro[1]-2;
				                #b.ell:=Sum(ReducedPrimeCyclesAB(b.DiscGro));
				                Dato.BV3:=BV3;
				                Dato.V3:=V3;
                                #### DA QUI proviamo ad inserire il quarto vettore
                            if IsGoodBlock(Dato.Blocks,1) and FourthVectorTest(Dato.blks) and not IsBlockSTooBig(Dato,Dato.blks,Dato.rk,2) then #Qui ho cambiato da attachblock a b.blocks
                                Dato.BV4:=IV_Blk_Vect(Dato.TotV,Dato.BV1,Dato.BV2,Dato.BV3,Dato,1);
		                        Dato.V4:=Flat(Dato.BV4);
		                        Dato.Blocks:=BlocksClean(INewBlock(Dato.Blocks,2)); 
                                #I casi 9A_1+2D_4, 10A_1+2D_4, 11A_1+2D_4 hanno una aggiunta di vettori particolare
                                # Osserviamo che i casi 10A_1+2D_4, 11A_1+2D_4 non ci sono mentre 
                                # il caso 9A_1+2D_4 è Nik. Inseriamo qui la scelta speciale dei vettori.
                                if Dato.SingTypeA[1] > 8 and Dato.SingTypeD[1]=2 then
                                    Dato.V1:=AddZero19([1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2,1/2,1/2,0,0,0,0,0],Dato.rk);
                                    Dato.V2:=AddZero19([1/2,1/2,0,0,0,1/2,0,1/2,1/2,0,0,0,1/2,1/2,1/2,0,0],Dato.rk);
                                    Dato.V3:=AddZero19([1/2,1/2,0,0, 0,0,0,0, 0,1/2,1/2,0, 1/2,1/2,0,1/2,1/2],Dato.rk);
                                    Dato.V4:=AddZero19([0,1/2,0,1/2, 1/2,1/2,0,0, 0,1/2,0,0, 1/2,0,1/2,1/2,0],Dato.rk);
                                fi;
		                    fi;
                        else
                            #if Dato.ell - 6 <= 22-Dato.rk then
                                #Print("----", unita,"---\n");
                                #StampaADE(Dato);
                                #Print("Vettore Totale--->", Dato.TotV,"\n");
                                #Print("Vettore Sbagliato--->", BV3, "\n");
                                #Print(Dato, "\n");
                                #Print("-------\n");
                                #unita:=unita+1; 
                                #Print("Proviamo a modificare e vedere cosa accade \n");
                                #Unbind(Dato.BV1);
                                #Unbind(Dato.BV2);
                                #Dato.BV1:=I_Blk_Vect_Modified(Dato,0);
                                #Dato.BV1:=I_Blk_Vect_Modified_WithChange(Dato,1);
                                #Dato.BV2:=II_Blk_Vect(Dato.TotV,Dato.BV1, Dato,4);
                                #Dato.BV2:=II_Blk_Vect_Modified(Dato,Dato.BV1,4,2,0);
                                #Dato.BV3:=III_Blk_Vect(Dato.TotV,Dato.BV1,Dato.BV2,Dato,1);
                                #Print("ell=", Dato.ell, "\n");
                                #Print("V1 -->", Dato.BV1, "\n");
                                #Print("V2 -->", Dato.BV2, "\n");
                                #Print("V3 -->", Dato.BV3, "\n");
                                #Print(Count_common_12_23_123(Dato.BV1,Dato.BV2,Dato.BV3), "\n");
                                #Print(Dato, "\n");
                                #if Count_common_12_23_123(Dato.BV1,Dato.BV2,Dato.BV3) <> [2,2,2,2] then
                                #    unita2:=unita2+1;
                                #fi;
                                #Print("Da Sistemare=", unita2, "\n");
                                #Print("---------fine del tentativo-----------------\n");  
                            #fi;                  
                        fi;    
			        fi;
                else    
                    #Print("----", unita,"---\n");
                    #StampaADE(Dato);
                    #Print("Vettore Totale--->", Dato.TotV,"\n");
                    #Print("Vettore Sbagliato--->", BV2, "\n");
                    #Print(Dato, "\n");
                    #Print("-------\n");
                    #unita:=unita+1;
                fi;    
            fi;
		else 
            #Print("----", unita,"---\n");
            #StampaADE(Dato);
            #Print("Vettore Totale--->", Dato.TotV,"\n");
            #Print("Vettore Sbagliato--->", Dato.BV1, "\n");
            #Print(Dato, "\n");
            #Print("-------\n");
            #unita:=unita+1;
        fi;
    fi;
    OddBloks:=AttachBlocksOdd(Dato);
    Dato.TotW:=TotalVector(OddBloks);
    # CONTINUARE DA QUI PER AGGIUNERE I VETTORI TRE DIVISIBILI
    if CountA2(Dato) > 5 then
            BW1:=I_Blk_VectZ3(Dato.TotW);
            W1:=Flat(BW1);
        if Sum(W1)=6 then
            Dato.BW1:=BW1;
            Dato.W1:=W1;
        fi;
        if not SecondZ3VectorTest(Dato) then #or not Dato.SingTypeA[2]<5 then CAMBIATO QUI
            Dato.BW2:=II_Blk_VectZ3(Dato,2);
	        Dato.W2:=Flat(Dato.BW2); 
        fi;  
    fi;
    # CONTINUARE DA QUI PER AGGIUNERE I VETTORI Quattro DIVISIBILI
    if CountA3(Dato) > 4 then
        High4blks:=BlocksClean(AttachBlocks_HighZ4(Dato));
        Dato.TotZ4:=TotalVector(High4blks);
        BZ4:=I_Blk_Vect_High(Dato.TotZ4);
        Z4_1:=Flat(BZ4);
            if Sum(Z4_1)=7 then
                if IsBound(Dato.V1) then
                    Unbind(Dato.V1);
                fi;
                Dato.BZ4_1:=BZ4;
                Dato.Z4_1:=Z4_1; 
            fi;
    fi;
od;
	
return All_Possible_ADE_List;
end;
#***************************














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
	b.BW2:=II_Blk_VectZ3(b.TotW,b.W1,b,2);
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
