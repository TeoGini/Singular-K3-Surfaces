Read("HelpFunc_ADE.gap");
Read("ADE_List_Prog.gap");


#--------------------------------------------------
GoodSub:=function(M1,M2,v,rk,k)
#--------------------------------------------------
#
# Data la matrice di cambio di base M1, la matrice di intersezione M2
# il vettore da inserire nella nuova base v
# il rango 
# e la posizione attuale k
# restituisce la posizione giusta dove sostituire il vettore v.
#
#
#----------------------------------------------------
local w,M,M11,M22;

M11:=ShallowCopy(M1);
M22:=ShallowCopy(M2);

#Print(M2, "\n");
#Print(Determinant(M2), "\n\n");
if k>rk then
	Print(k, "PROBLEM \n");
	k:= (k mod rk);
fi;

w:=M11[k];
M11[k]:=ZeVet(rk);

M:=(M11)*M22*TransposedMat(M11);
Print(Determinant(M), "\n");
while k<rk and (Determinant(M) = 0 ) do
# k<rk and (Determinant(M) = 0 or not IsIntegralMatrix(M)) do
	k:=k+1;
	M11[k-1]:=w;
	w:=M11[k];
	M11[k]:=v;
	M:=(M11)*M22*TransposedMat(M11);
#Print(M11, "\n");
#Print(Determinant(M), "\n");
od;

return k;
end;
#--------------------------------------------------




#########################
TheMatrix:=function(b)
#########################
local M1,M2,M,k;


M2:=BM_ADE(b);
b.M2:=M2;
M1:=IdentityMat(b.rk,1);
k:=1;


if IsBound(b.V1) then 
	M1[k]:=b.V1;
	k:=k+1;
fi;

M:=(M1)*M2*TransposedMat(M1);

if IsBound(b.V2)  then 
	k:=GoodSub(M1,M,b.V2,b.rk,k);
	M1[k]:=b.V2;
	k:=k+1;
fi;

M:=(M1)*M2*TransposedMat(M1);

if IsBound(b.V3)  then 
	k:=GoodSub(M1,M,b.V3,b.rk,k);
	M1[k]:=b.V3;
	k:=k+1;
fi;

M:=(M1)*M2*TransposedMat(M1);

if IsBound(b.V4)  then 
	k:=GoodSub(M1,M,b.V4,b.rk,k);
	M1[k]:=b.V4;
	k:=k+1;
fi;

M:=(M1)*M2*TransposedMat(M1);

#Print(k,"\n");

if IsBound(b.W1)  then 
	k:=GoodSub(M1,M,b.W1,b.rk,k);
	M1[k]:=b.W1;
	k:=k+1;
	b.M1:=M1;
	b.M2:=M2;
fi;

M:=(M1)*M2*TransposedMat(M1);

if IsBound(b.W2)  then 
	k:=GoodSub(M1,M,b.W2,b.rk,k);
	M1[k]:=b.W2;
	k:=k+1;
fi;

#Print(k,"\n");

M:=(M1)*M2*TransposedMat(M1);
#b.M3:=M1;
#b.M4:=M;

return M;
end;
#########################

#########################
MatrixForSagePrint:=function(l)
#########################	
local rk,M,i,j;

if IsBound(l.Matrix) then
	M:=l.Matrix;
	rk:=TheRank(l);

	Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

	for i in [1..rk] do
		for j in [1..rk] do
			if i = rk and j = rk then
				Print(M[i][j]);
			else
				Print(M[i][j],",");
			fi;
		od;
	od;
	Print("])");
	Print("\n");
else
	Print("# PROBLEM \n");
fi;
Print("# ",StampaADESage(l),"\n");
Print("B=IntegralLattice(A) \n");
Print("print(B.genus()) \n");
Print("print(B.discriminant_group()) \n\n");

if IsBound(l.Z4) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.Z4))-1] do
		Print(Flat(l.Z4)[i], ",");
	od;
	Print(Flat(l.Z4)[Length(Flat(l.Z4))], "])\n");
	Print("M1 = B.overlattice([v])\n");
	Print("M1.discriminant_group()\n");
	Print("print(M1.genus()) \n");
fi;
#Print("print(Genus(A)) \n\n");


return 0;
end;
########################


#########################
ForSagePrint_v0:=function(l)
#########################	
local rk,M,i,j;

if IsBound(l.M2) then
	M:=l.M2;
	rk:=TheRank(l);

	Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

	for i in [1..rk] do
		for j in [1..rk] do
			if i = rk and j = rk then
				Print(M[i][j]);
			else
				Print(M[i][j],",");
			fi;
		od;
	od;
	Print("])");
	Print("\n");
else
	Print("# PROBLEM \n");
fi;

Print("dynkin_lattice = associated_dynkin_lattice(A) \n");
#Print("print(dynkin_lattice)\n");
Print("print_dynkin_label(dynkin_lattice)\n");

#Print("# ",StampaADESage(l),"\n");
Print("B=IntegralLattice(A) \n");
Print("print(B.genus()) \n");
Print("print(B.discriminant_group()) \n\n");
Print("len(B.discriminant_group().gens()) \n");
Print("len(B.discriminant_group().gens())<= 22-B.rank() \n");

if IsBound(l.V1) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.V1))-1] do
		Print(Flat(l.V1)[i], ",");
	od;
	Print(Flat(l.V1)[Length(Flat(l.V1))], "])\n");
	Print("M1 = B.overlattice([v])\n");
	Print("M1.discriminant_group()\n");
	Print("print(M1.genus()) \n");
	Print("len(M1.discriminant_group().gens()) \n");
	Print("len(M1.discriminant_group().gens())<= 22-B.rank() \n");
fi;

if IsBound(l.V2) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.V2))-1] do
		Print(Flat(l.V1)[i], ",");
	od;
	Print(Flat(l.V2)[Length(Flat(l.V2))], "])\n");
	Print("M2 = M1.overlattice([v])\n");
	Print("M2.discriminant_group()\n");
	Print("print(M2.genus()) \n");
	Print("len(M2.discriminant_group().gens()) \n");
	Print("len(M2.discriminant_group().gens())<= 22-B.rank() \n");
fi;

if IsBound(l.V3) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.V3))-1] do
		Print(Flat(l.V3)[i], ",");
	od;
	Print(Flat(l.V3)[Length(Flat(l.V3))], "])\n");
	Print("M3 = M2.overlattice([v])\n");
	Print("M3.discriminant_group()\n");
	Print("print(M3.genus()) \n");
	Print("len(M3.discriminant_group().gens()) \n");
	Print("len(M3.discriminant_group().gens())<= 22-B.rank() \n");
fi;

if IsBound(l.V4) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.V4))-1] do
		Print(Flat(l.V4)[i], ",");
	od;
	Print(Flat(l.V4)[Length(Flat(l.V4))], "])\n");
	Print("M4 = M3.overlattice([v])\n");
	Print("M4.discriminant_group()\n");
	Print("print(M4.genus()) \n");
	Print("len(M4.discriminant_group().gens()) \n");
	Print("len(M4.discriminant_group().gens())<= 22-B.rank() \n");
fi;
#----------------------------------------------------------------#
Print("BB = B \n");

if IsBound(l.V1) then
	Print("BB = M1 \n");
fi;

if IsBound(l.V2) then
	Print("BB = M2 \n");
fi;

if IsBound(l.V3) then
	Print("BB = M3 \n");
fi;

if IsBound(l.V4) then
	Print("BB = M4 \n");
fi;

if IsBound(l.W1) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.W1))-1] do
		Print(Flat(l.W1)[i], ",");
	od;
	Print(Flat(l.W1)[Length(Flat(l.W1))], "])\n");
	Print("M5 = BB.overlattice([v])\n");
	Print("M5.discriminant_group()\n");
	Print("print(M5.genus()) \n");
	Print("len(M5.discriminant_group().gens()) \n");
	Print("len(M5.discriminant_group().gens())<= 22-B.rank() \n");
fi;

if IsBound(l.W2) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.W2))-1] do
		Print(Flat(l.W2)[i], ",");
	od;
	Print(Flat(l.W2)[Length(Flat(l.W2))], "])\n");
	Print("M6 = M5.overlattice([v])\n");
	Print("M6.discriminant_group()\n");
	Print("print(M6.genus()) \n");
	Print("len(M6.discriminant_group().gens()) \n");
	Print("len(M6.discriminant_group().gens())<= 22-B.rank() \n");
fi;



if IsBound(l.Z4) then 
	Print("v= vector([");
	for i in [1..Length(Flat(l.Z4))-1] do
		Print(Flat(l.Z4)[i], ",");
	od;
	Print(Flat(l.Z4)[Length(Flat(l.Z4))], "])\n");
	Print("M7 = B.overlattice([v])\n");
	Print("M7.discriminant_group()\n");
	Print("print(M7.genus()) \n");
	Print("len(M7.discriminant_group().gens()) \n");
	Print("len(M7.discriminant_group().gens())<= 22-B.rank() \n");
fi;


Print("\n\n \n\n");


return 0;
end;
########################



#########################
ForSagePrint:=function(l)
#########################	
local rk,M,i,j,numb_vectors,k;

if IsBound(l.M2) then
	M:=l.M2;
	rk:=TheRank(l);

	Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

	for i in [1..rk] do
		for j in [1..rk] do
			if i = rk and j = rk then
				Print(M[i][j]);
			else
				Print(M[i][j],",");
			fi;
		od;
	od;
	Print("])");
	Print("\n");
else
	Print("# PROBLEM \n");
fi;


#Print("dynkin_lattice = associated_dynkin_lattice(A) \n");
#Print("print(dynkin_lattice)\n");
#Print("print_dynkin_label(dynkin_lattice)\n");

#Print("# ",StampaADESage(l),"\n");
#Print("B=IntegralLattice(A) \n");
#Print("print(B.genus()) \n");
#Print("print(B.discriminant_group()) \n\n");
#Print("len(B.discriminant_group().gens()) \n");
#Print("len(B.discriminant_group().gens())<= 22-B.rank() \n");
k:=0;
if IsBound(l.V1) then
	k:=k+1;
	Print("vect",k," = vector([");
	for i in [1..Length(Flat(l.V1))-1] do
		Print(Flat(l.V1)[i], ",");
	od;
	Print(Flat(l.V1)[Length(Flat(l.V1))], "])\n");
fi;

if IsBound(l.V2) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.V2))-1] do
		Print(Flat(l.V2)[i], ",");
	od;
	Print(Flat(l.V2)[Length(Flat(l.V2))], "])\n");
fi;

if IsBound(l.V3) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.V3))-1] do
		Print(Flat(l.V3)[i], ",");
	od;
	Print(Flat(l.V3)[Length(Flat(l.V3))], "])\n");
fi;

if IsBound(l.V4) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.V4))-1] do
		Print(Flat(l.V4)[i], ",");
	od;
	Print(Flat(l.V4)[Length(Flat(l.V4))], "])\n");
fi;

if IsBound(l.W1) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.W1))-1] do
		Print(Flat(l.W1)[i], ",");
	od;
	Print(Flat(l.W1)[Length(Flat(l.W1))], "])\n");
fi;

if IsBound(l.W2) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.W2))-1] do
		Print(Flat(l.W2)[i], ",");
	od;
	Print(Flat(l.W2)[Length(Flat(l.W2))], "])\n");
fi;

if IsBound(l.Z4_1) then 
	k:=k+1;
	Print("vect",k,"= vector([");
	for i in [1..Length(Flat(l.Z4_1))-1] do
		Print(Flat(l.Z4_1)[i], ",");
	od;
	Print(Flat(l.Z4_1)[Length(Flat(l.Z4_1))], "])\n");
fi;

#----------------------------------------------------------------#
numb_vectors:=k;

if numb_vectors = 0 then 
	Print("T=zero_vector_new_matrix(A) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;	

if numb_vectors=1  then
	Print("T=one_vector_new_matrix(A, vect1) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;

if numb_vectors=2 then
	Print("T=two_vector_new_matrix(A, vect1,vect2) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;

if numb_vectors=3 then
	Print("T=three_vector_new_matrix(A, vect1,vect2, vect3) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;

if numb_vectors=4 then
	Print("T=four_vector_new_matrix(A, vect1, vect2, vect3,vect4) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;

if numb_vectors=5 then
	Print("T=five_vector_new_matrix(A, vect1, vect2, vect3,vect4) \n");
	#Print("matrix_lattice_info(T[0],T[1]) \n");
	Print("list_of_pair_of_matrices.append(T)\n");
fi;


#Print("# ",StampaADESage(l),"\n");
Print("\n\n \n\n");


return 0;
end;







#########################
PrintTheMatrix:=function(l)
#########################
local rk,M,i,j;

M:=TheMatrix(l);
rk:=TheRank(l);

Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

for i in [1..rk] do
	for j in [1..rk] do
		if i = rk and j = rk then
		Print(M[i][j]);
		else
		Print(M[i][j],",");
		fi;
od;od;
Print("])");
Print("\n\n");
Print("Genus(A) \n\n");


return 0;
end;
#########################

############################------------------------
MultSubMatrix:=function(l,x)
############################------------------------

local rk,M1,M2,M;

rk:=TheRank(l);
M2:=BM_ADE(l);
M1:=IdentityMat(rk,1);


if IsBound(l.V1) then 
	M1[x]:=l.V1;
fi;

M:=(M1)*M2*TransposedMat(M1);

return M;
end;
############################

#########################
PrintTheMatrix2:=function(l,y)
#########################
local rk,M,i,j;

M:=MultSubMatrix(l,y);
rk:=TheRank(l);

Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

for i in [1..rk] do
	for j in [1..rk] do
		if i = rk and j = rk then
		Print(M[i][j]);
		else
		Print(M[i][j],",");
		fi;
od;od;
Print("])");
Print("\n\n");
Print("Genus(A) \n\n");


return 0;
end;
#########################



############################------------------------
MultSubMatrix2:=function(l,x,y)
############################------------------------

local rk,M1,M2,M;

M2:=BM_ADE(l);
M1:=IdentityMat(l.rk,1);

if IsBound(l.V1) and IsBound(l.V2) then
	M1[x]:=l.V1;
	M1[y]:=l.V2;
	# M:=(M1)*M2*TransposedMat(M1);
	# M:=(M1^-1)*M2*TransposedMat(M1^-1);
	M:=(M1)*M2*TransposedMat(M1);
fi;

if IsBound(l.W1) and IsBound(l.W2) then
	M1[x]:=l.W1;
	M1[y]:=l.W2;
	# M:=(M1)*M2*TransposedMat(M1);	
	# M:=(M1^-1)*M2*TransposedMat(M1^-1);
	M:=(M1)*M2*TransposedMat(M1);
fi;

return M;
end;
############################


############################------------------------
MultSubMatrix3:=function(l,x,y,z)
############################------------------------

local rk,M1,M2,M;

rk:=TheRank(l);
M2:=BM_ADE(l);



M1:=IdentityMat(rk,1);



M1[x]:=l.V1;
M1[y]:=l.V2;
M1[z]:=l.V3;

 M:=(M1)*M2*TransposedMat(M1);
#M:=(M1^-1)*M2*TransposedMat(M1^-1);

return M;
end;
############################


############################------------------------
MultSubMatrix4:=function(l,x,y,z,w)
############################------------------------

local rk,M1,M2,M;

rk:=TheRank(l);
M2:=BM_ADE(l);



M1:=IdentityMat(rk,1);



M1[x]:=l.V1;
M1[y]:=l.V2;
M1[z]:=l.V3;
M1[w]:=l.V3;

#M:=(M1^-1)*M2*TransposedMat(M1^-1);
 M:=(M1)*M2*TransposedMat(M1);

return M;
end;
############################



#########################
PrintTheMatrix3:=function(l,x,y)
#########################
local rk,M,i,j;

M:=MultSubMatrix2(l,x,y);
rk:=TheRank(l);

Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

for i in [1..rk] do
	for j in [1..rk] do
		if i = rk and j = rk then
		Print(M[i][j]);
		else
		Print(M[i][j],",");
		fi;
od;od;
Print("])");
Print("\n\n");
Print("Genus(A) \n\n");


return 0;
end;
#########################


#########################
PrintTheMatrix4:=function(l,x,y,z)
#########################
local rk,M,i,j;

M:=MultSubMatrix3(l,x,y,z);
rk:=TheRank(l);

Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

for i in [1..rk] do
	for j in [1..rk] do
		if i = rk and j = rk then
		Print(M[i][j]);
		else
		Print(M[i][j],",");
		fi;
od;od;
Print("])");
Print("\n\n");
Print("Genus(A) \n\n");


return 0;
end;
#########################


#########################
PrintTheMatrix5:=function(l,x,y,z,w)
#########################
local rk,M,i,j;

M:=MultSubMatrix4(l,x,y,z,w);
rk:=TheRank(l);

Print("A=Matrix(QQ,", rk, ",",rk, ", ["); 

for i in [1..rk] do
	for j in [1..rk] do
		if i = rk and j = rk then
		Print(M[i][j]);
		else
		Print(M[i][j],",");
		fi;
od;od;
Print("])");
Print("\n\n");
Print("Genus(A) \n\n");


return 0;
end;
#########################



## TEST BUONO SE ABBIAMO UN SOLO VETTORE DA CAMBIARE


############################------------------------
MultSubMatrix:=function(l,x)
############################------------------------

local rk,M1,M2,M;

rk:=TheRank(l);
M2:=BM_ADE(l);
M1:=IdentityMat(rk,1);


if IsBound(l.V1) and not IsBound(l.W1)	then 
	M1[x]:=l.V1;
else
	M1[x]:=l.W1;	
fi;

if Determinant(M1)=0 then
	#Print(l.V1,"-", x, "\n");
	StampaADE(l);
	#Print("\n\n");
fi;
M:=(M1)*M2*TransposedMat(M1);

return M;
end;
############################

############################
MultSubTest:=function(l)
# 
# calcola tutte le matrici di intersezione
# sostituendo il nuovo vettore al vettore e_x
# quando la matrice è intera e con det<>0 restituisce
# vero e la posizione x del vettore e_x da sostituire
# 
local tmp,rk,x,y,M;

y:=0;
rk:=TheRank(l);
tmp:=false;
for x in [1..rk] do 
	if IsBound(l.V1) then
		if l.V1[x] <> 0 then 
			M:=MultSubMatrix(l,x);
		# Print(Determinant(M), " -- ", IsIntegralMatrix(M), "\n");
		# Print(M,"\n\n");
			if Determinant(M) <> 0  and  IsIntegralMatrix(M) then 
				tmp:=true;
				y:=x;
				return [tmp,y];
			fi;
		fi;
	fi;	
	if IsBound(l.W1) then
		if l.W1[x] <> 0 then 
			M:=MultSubMatrix(l,x);
		# Print(Determinant(M), " -- ", IsIntegralMatrix(M), "\n");
		# Print(M,"\n\n");
			if Determinant(M) <> 0  and  IsIntegralMatrix(M) then 
				tmp:=true;
				y:=x;
				return [tmp,y];
			fi;
		fi;
	fi;	
od;

return [tmp,y];
end;
############################


############################
MultSubTest2V:=function(l)

local tmp,rk,x,y,j,k,M2,M1,M;

y:=0;
x:=0;
rk:=TheRank(l);
tmp:=false;

if IsBound(l.V1) and IsBound(l.V2) then
for j in [1..rk] do 
	for k in [1..rk] do
		if k<>j then 
			M2:=BM_ADE(l);
			M1:=IdentityMat(rk,1);
			M1[k]:=l.V1;
			M1[j]:=l.V2;
			# Print(Length(l.V1),"\n");
			# Print(Length(l.V2),"\n");
			# Print(l.V1,"\n");
			# Print(l.V2,"\n");
			# Print(l,"\n");
			# StampaADE(l);
			if Determinant(M1)<>0 then 
				# StampaADE(l);
				# Print(l.V1, "\n");
				# Print(l.V2, "\n\n");
			
			M:=(M1^-1)*M2*TransposedMat(M1^-1);
				if  Determinant(M)<>0 and IsIntegralMatrix(M) and j<>k then
					x:=k;
					y:=j;
					tmp:=true;
					# Print(M,"\n");
					return [tmp,x,y];
				fi;
			fi;
		fi;	
	od;
od;
fi; 


if IsBound(l.W1) and IsBound(l.W2) then
for j in [1..rk] do 
	for k in [1..rk] do
		M2:=BM_ADE(l);
		M1:=IdentityMat(rk,1);
		M1[k]:=l.W1;
		M1[j]:=l.W2;
		if Determinant(M1)<>0 then
			M:=(M1^-1)*M2*TransposedMat(M1^-1);
			# Print(M,"\n",Determinant(M), "\n\n\n");
			if  Determinant(M)<>0 and IsIntegralMatrix(M) and j<>k then
				x:=k;
				y:=j;
				tmp:=true;
				return [tmp,x,y];
			fi;
		fi;	
	od;
od;
fi; 



return [tmp,x,y];
end;
############################

############################
MultSubTest3V:=function(l)

local tmp,rk,x,y,z,i,j,k,M2,M1,M;

y:=0;
x:=0;
z:=0;
rk:=TheRank(l);
tmp:=false;
# Print(Length(l.V1),"\n");
# Print(Length(l.V2),"\n");
# Print(Length(l.V3),"\n");

for j in [1..rk] do 
	for k in [1..rk] do
		for i in [1..rk] do
			M2:=BM_ADE(l);
			M1:=IdentityMat(rk,1);
			M1[k]:=l.V1;
			M1[j]:=l.V2;
			M1[i]:=l.V3;
			if Determinant(M1)<>0 then 
				M:=(M1)*M2*TransposedMat(M1);
				if  Determinant(M)<>0 and #IsIntegralMatrix(M) 
				 j<>k and j<>i and k<>i then
					x:=k;
					y:=j;
					z:=i;
					tmp:=true;
					# Print(M,k,i,j,"\n",Determinant(M), "\n\n\n");
					return [tmp,x,y,z];
				fi;		
			fi;
		od;
	od;
od;

return [tmp,x,y,z];
end;
############################

############################
MultSubTest4V:=function(l)

local tmp,rk,x,y,z,w,h,i,j,k,M2,M1,M;

y:=0;
x:=0;
z:=0;
w:=0;
rk:=TheRank(l);
tmp:=false;

for j in [1..rk] do 
	for k in [1..rk] do
		for i in [1..rk] do
			for h in [1..rk] do
			M2:=BM_ADE(l);					
			M1:=IdentityMat(rk,1);
			M1[j]:=l.V1;
			M1[k]:=l.V2;
			M1[i]:=l.V3;
			M1[h]:=l.V3;
			M:=(M1)*M2*TransposedMat(M1);
			# Print(IsIntegralMatrix(M)," - ", Determinant(M),"\n");
				if  Determinant(M)<>0 and IsIntegralMatrix(M) and j<>k and j<>i and j<>h and k<>i and k<>h and i<>h  then
				# Print(j," ", k, " ", i, " ", h, "\n");
					x:=k;
					y:=j;
					z:=i;
					w:=h;
					tmp:=true;
					# return [tmp,x,y,z,w];
				fi;
			od;
		od;
	od;
od;

return [tmp,x,y,z,w];
end;
############################






