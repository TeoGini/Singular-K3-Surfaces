#***************************
CountA3:=function(l)
#------------------------------
#
# This function given a Datum it returns the number of disjoint
# A_3 singularities 
#
#------------------------------

local m,i;

m:=0;

for i in [1..Length(l.SingTypeA)] do
	if i mod 4 = 3 then
		m:=m+((i+1)/4)*l.SingTypeA[i];
	fi;
od;

for i in [1..Length(l.SingTypeD)] do
    if i mod 2 = 0 then 
	m:=m+l.SingTypeD[i];
    fi;
od;

return m;
end;
#***************************


#***************************
BlockA_i_HighZ4:=function(a,b)
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



if a <> 3 then
	R:=rec(Block:=ListWithIdenticalEntries(a,0), Blocktype:=[a,1], BlockNumber:=b, BlockLength:=y);
fi;

if a = 1 then
	R:=rec(Block:=[1/2], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=1);
fi;

if a = 7  then
	R:=rec(Block:=[1/4,2/4,3/4,0,1/4,2/4,3/4], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=7);
fi;

if a = 11  then
	R:=rec(Block:=[1/4,2/4,3/4,0,1/4,2/4,3/4,0,1/4,2/4,3/4], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=11);
fi;

if a = 15  then
	R:=rec(Block:=[1/4,2/4,3/4,0,1/4,2/4,3/4,0,1/4,2/4,3/4,0,1/4,2/4,3/4], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=15);
fi;

if a = 3  then
	R:=rec(Block:=[1/4,2/4,3/4], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=3);
fi;


return R;
end; 
#***************************

#***************************
AllBlocksAi_HighZ4:=function(l)
#***************************

local i, List, count_to_4, l11, l15, l3, l7;

List:=[];

# questa pare è fatta perché in generle SingTypeA non ha 19 ingressi
l3:=0;
l7:=0;
l11:=0;
l15:=0;

if IsBound(l[3]) then
    l3:=l[3];
fi;

if IsBound(l[7]) then
    l7:=l[7];
fi;
if IsBound(l[11]) then
    l11:=l[11];
fi;

if IsBound(l[15]) then
    l15:=l[15];
fi;
###########################################################

count_to_4:=l3+l7*2+l11*3+l15*4;


for i in [1..Length(l)] do
    if i <> 3 then
        Add(List, BlockA_i_HighZ4(i, l[i]));
    fi;
    if i = 3 then
        if  count_to_4<=4 then 
            Add(List, BlockA_i_HighZ4(i, l[i]));
        else
            Add(List, BlockA_i_Even(i, 1));
            Add(List, BlockA_i_HighZ4(i,  l[i]-1));
        fi;
    fi; 
od;
return List;
end;
#***************************

#***************************
BlockD_i_HighZ4:=function(a,b)
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

if A=4  then
    R:=rec(Block:=[1/2,1/2,0,0], Blocktype:=[A,2], BlockNumber:=b, BlockLength:=2);
fi;

if A=5  then
    R:=rec(Block:=[1/4,3/4,1/2,0,1/2], Blocktype:=[A,2], BlockNumber:=b, BlockLength:=2);
fi;

if (A mod 2) =0 and A > 5  then
    v:=ListWithIdenticalEntries(A,0);
    v[1]:=1/2;
    v[2]:=1/2;
    R:=rec(Block:=v, Blocktype:=[A,2], BlockNumber:=b, BlockLength:=2);
fi;

if (A mod 2) =1 and A > 5   then
    R:=rec(Block:=AddZero19([1/4,3/4,1/2,0,1/2,0,1/2],A), Blocktype:=[A,2], BlockNumber:=b, BlockLength:=2);
fi;

return R;
end;
#***************************


#***************************
AllBlocksDi_HighZ4:=function(l)
#***************************
local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockD_i_HighZ4(i, l[i]));
od;
return List;
end;
#***************************

#***************************
BlockE_i_HighZ4:=function(a,b)
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

#if A=6 and b>0 then
#R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0], Blocktype:=[A,3], BlockNumber:=b, BlockLength:=3);
#fi;

return R;
end;
#***************************



#***************************
AllBlocksEi_HighZ4:=function(l)

local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockE_i_HighZ4(i, l[i]));
od;
return List;
end;
#***************************

#***************************
AttachBlocks_HighZ4:=function(l)
#***************************

local F,G,T;

F:=AllBlocksAi_HighZ4(l.SingTypeA);
#Print(F, "\,");
G:=AllBlocksDi_HighZ4(l.SingTypeD);
#Print(F, "\,");
T:=AllBlocksEi_HighZ4(l.SingTypeE);
Append(F,G);
Append(F,T);
return F;
end;


#---------------------------------------
I_Blk_Vect_High:=function(TotV)
#***************************
# 
# given a block and the rank of the lattice in the form of TotalVector
# it returns an even block vector of length rk with 8 entries
# of value 1/2 divided into blocks.
# 
# WARNINGS!!
# It reverse the order of the block starting from the biggest to
# the smaller.
# 
#  EXAMPLE
# Dato:=rec(
#   SingTypeA := [ 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
#  blks:=AttachBlocks_HighZ4(Dato);
# rk:=TheRank(Dato);
# TotV:=TotalVector(blks);
#  v:=I_Blk_Vect_High(TotV);
# [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ] ]
# 
#***************************
local blksVect,v,blksVectCopy, count_one, count_two;

count_one:=0;
count_two:=0;
blksVect:=[[]];

for v in TotV do 
        #Print(count_one, "\n");
        #Print(count_two, "\n");
	    if Sum(v)*2 mod 3 = 0 then
    	    blksVectCopy:=ShallowCopy(blksVect);
		    Add(blksVectCopy,v);
   		    if Sum(Sum(blksVectCopy)) <= 7 and count_two < 5 then
			    Add(blksVect,v);
                count_two:=count_two+1;
		    else
			    Add(blksVect, Zero(v));
		    fi;
        else 
            blksVectCopy:=ShallowCopy(blksVect);
	        Add(blksVectCopy,v);
            #Print(count_one, "\n");
   		    if Sum(Sum(blksVectCopy)) <= 7 and count_one < 2 then
			    Add(blksVect,v);
                count_one:=count_one+Sum(v)/2;
                if Sum(v) = 5/2 then
                    count_two:=count_two+2;
                fi;
                if Sum(v) =2 then 
                    count_two:=count_two+1;
                fi;
		    else
			    Add(blksVect, Zero(v));
		    fi;
        fi;       
od;

Remove(blksVect,1);

return blksVect;
end;




#############################################################
#
# DA qui i vettori 5-divisibili
#
############################################################
#***************************
BlockA_i_HighZ5:=function(a,b)
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



if a <> 4 then
	R:=rec(Block:=ListWithIdenticalEntries(a,0), Blocktype:=[a,1], BlockNumber:=b, BlockLength:=y);
fi;


if a = 4  then
	R:=rec(Block:=[1/5,2/5,3/5,4/5], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=4);
fi;

if a = 9  then
	R:=rec(Block:=[1/5,2/5,3/5,4/5,0,1/5,2/5,3/5,4/5], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=9);
fi;

return R;
end; 
#***************************

#***************************
AllBlocksAi_HighZ5:=function(l)
#***************************

local i, List, count_to_4;

List:=[];

for i in [1..Length(l)] do
    Add(List, BlockA_i_HighZ5(i, l[i]));
od;
return List;
end;


#***************************

#***************************
BlockD_i_HighZ5:=function(a,b)
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
AllBlocksDi_HighZ5:=function(l)
#***************************
local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockD_i_HighZ5(i, l[i]));
od;
return List;
end;
#***************************

#***************************
BlockE_i_HighZ5:=function(a,b)
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

#if A=6 and b>0 then
#R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0], Blocktype:=[A,3], BlockNumber:=b, BlockLength:=3);
#fi;

return R;
end;
#***************************



#***************************
AllBlocksEi_HighZ5:=function(l)

local i, List;

List:=[];
for i in [1..Length(l)] do
	Add(List, BlockE_i_HighZ5(i, l[i]));
od;
return List;
end;
#***************************

#***************************
AttachBlocks_HighZ5:=function(l)
    #***************************

    local F,G,T;

    F:=AllBlocksAi_HighZ5(l.SingTypeA);
    #Print(F, "\,");
    G:=AllBlocksDi_HighZ5(l.SingTypeD);
    #Print(F, "\,");
    T:=AllBlocksEi_HighZ5(l.SingTypeE);
    Append(F,G);
    Append(F,T);
    return F;
end;
#---------------------------------------

#---------------------------------------
I_Blk_Vect_High5:=function(TotV)
    #***************************
    # 
    # given a block and the rank of the lattice in the form of TotalVector
    # it returns an even block vector of length rk with 8 entries
    # of value 1/2 divided into blocks.
    # 
    # WARNINGS!!
    # It reverse the order of the block starting from the biggest to
    # the smaller.
    # 
    #  EXAMPLE
    # Dato:=rec(
    #   SingTypeA := [ 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    #   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    #   SingTypeE := [ 0, 0, 0 ],
    # );
    #  blks:=AttachBlocks(Dato);
    # rk:=TheRank(Dato);
    # TotV:=TotalVector(blks);
    #  v:=I_Blk_Vect(TotV);
    # [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ] ]
    # 
    #***************************
    local blksVect,v,blksVectCopy;


    blksVect:=[[]];
    for v in TotV do 
                blksVectCopy:=ShallowCopy(blksVect);
                Add(blksVectCopy,v);
                #Print(Sum(Sum(blksVectCopy)), " ", v, "\n");
                if Sum(Sum(blksVectCopy)) <= 8 then
                    Add(blksVect,v);
                else
                    Add(blksVect, Zero(v));
                fi;
    od;

    Remove(blksVect,1);

    return blksVect;
end;
#---------------------------------------

#############################################################
#############################################################
#
# DA qui i vettori 7-divisibili
#
############################################################
#***************************
BlockA_i_HighZ7:=function(a,b)
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



    if a <> 6 then
        R:=rec(Block:=ListWithIdenticalEntries(a,0), Blocktype:=[a,1], BlockNumber:=b, BlockLength:=y);
    fi;


    if a = 6  then
        R:=rec(Block:=[1/7,2/7,3/7,4/7,5/7,6/7], Blocktype:=[a,1], BlockNumber:=b, BlockLength:=6);
    fi;


    return R;
end; 
#***************************

#***************************
AllBlocksAi_HighZ7:=function(l)
    #***************************

    local i, List, count_to_4;

    List:=[];

    for i in [1..Length(l)] do
        Add(List, BlockA_i_HighZ7(i, l[i]));
    od;
    return List;
end;
#***************************

#***************************
BlockD_i_HighZ7:=function(a,b)
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
AllBlocksDi_HighZ7:=function(l)
    #***************************
    local i, List;

    List:=[];
    for i in [1..Length(l)] do
        Add(List, BlockD_i_HighZ7(i, l[i]));
    od;
    return List;
end;
#***************************

#***************************
BlockE_i_HighZ7:=function(a,b)
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

    #if A=6 and b>0 then
    #R:=rec(Block:=[1/3,2/3,0,1/3,2/3,0], Blocktype:=[A,3], BlockNumber:=b, BlockLength:=3);
    #fi;

    return R;
end;
#***************************

#***************************
AllBlocksEi_HighZ7:=function(l)

    local i, List;

    List:=[];
    for i in [1..Length(l)] do
        Add(List, BlockE_i_HighZ7(i, l[i]));
    od;
    return List;
end;
#***************************

#***************************
AttachBlocks_HighZ7:=function(l)
    #***************************

    local F,G,T;

    F:=AllBlocksAi_HighZ7(l.SingTypeA);
    #Print(F, "\,");
    G:=AllBlocksDi_HighZ7(l.SingTypeD);
    #Print(F, "\,");
    T:=AllBlocksEi_HighZ7(l.SingTypeE);
    Append(F,G);
    Append(F,T);
    return F;
end;
#---------------------------------------

#---------------------------------------
I_Blk_Vect_High7:=function(TotV)
    #***************************
    # 
    # given a block and the rank of the lattice in the form of TotalVector
    # it returns an even block vector of length rk with 8 entries
    # of value 1/2 divided into blocks.
    # 
    # WARNINGS!!
    # It reverse the order of the block starting from the biggest to
    # the smaller.
    # 
    #  EXAMPLE
    # Dato:=rec(
    #   SingTypeA := [ 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    #   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    #   SingTypeE := [ 0, 0, 0 ],
    # );
    #  blks:=AttachBlocks(Dato);
    # rk:=TheRank(Dato);
    # TotV:=TotalVector(blks);
    #  v:=I_Blk_Vect(TotV);
    # [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 0, 0 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ], [ 1/2 ] ]
    # 
    #***************************
    local blksVect,v,blksVectCopy;


    blksVect:=[[]];
    for v in TotV do 
                blksVectCopy:=ShallowCopy(blksVect);
                Add(blksVectCopy,v);
                #Print(Sum(Sum(blksVectCopy)), " ", v, "\n");
                if Sum(Sum(blksVectCopy)) <= 9 then
                    Add(blksVect,v);
                else
                    Add(blksVect, Zero(v));
                fi;
    od;

    Remove(blksVect,1);

    return blksVect;
end;
#---------------------------------------