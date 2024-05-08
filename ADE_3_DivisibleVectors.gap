#*********************************
SecondZ3VectorTest:=function(l)
#--------------------------------
#
# Check if there is a possibility to add a further
#  3-divisible vector.
#  Using the criterion if we used A_k with k>5 then not!
#
# WARNINGS! It return TRUE if is NOT Possible to add afurther 3-div vect.
#
# 
# EXAMPLE
# 
# Dato:=rec(
#   SingTypeA := [ 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
# PreparationFinalTouchZ3(Dato);
# true
# 
#--------------------------------
local tmp, k,L;

tmp:=false;
L:=[];
# dovrebbe essere modulo 3
for k in [8..Length(l.SingTypeA)] do
	if k mod 3 =2 then  
		if l.SingTypeA[k]>0 then
			tmp:=true;
		fi;
	fi;	
od;

if l.SingTypeE[1]>0 then
	tmp:=true;
fi;

if Length(l.SingTypeA) >4 then 
	for k in [5..Length(l.SingTypeA)] do
		if k mod 3 =2 then
		Add(L,l.SingTypeA[k]);
		fi;
	od;
fi;
	
if  Sum(L)=0 and l.SingTypeA[2]<=7  then #<<<<<<<------ CAMBIARE QUI IN 7!!!
	tmp:=true;
fi;

if l.SingTypeA[5]=1 and l.SingTypeA[2]<6 then
	tmp:=true;
fi;
if l.SingTypeA[5]=2 and l.SingTypeA[2]<4 then
	tmp:=true;
fi;

if l.SingTypeA[5]=3 and l.SingTypeA[2]<2 then
	tmp:=true;
fi;

return tmp;
end;
#*********************************

#---------------------------------------
I_Blk_VectZ3:=function(TotV)
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
            #Print(Sum(Flat(blksVectCopy)), "<---\n" );
            #Print(v,"\n" );
   			 if Sum(Flat(blksVectCopy)) <= 6 then
				Add(blksVect,v);
			else
				Add(blksVect, Zero(v));
			fi;
            #Print(blksVect,"\n" );

od;

Remove(blksVect,1);

return blksVect;
end;
#---------------------------------------


#---------------------------------------
II_Blk_VectZ3:=function(Dato,a)

local w,vp,i,j,l,old_change, ListD2n2, new, blksVectCopy, ScNew, old_keep,Copy_New,ScOld, TotW, W1;

TotW:=Dato.TotW;
W1:=Dato.BW1;
w:=[];
new:=0;
old_change:=0;
old_keep:=0;
l:=0;
#Print(W1, "\n");
#Print(TotW, "\n");

# mettiamo questo test perché il caso 1A_3+8A_2 il conto deve partire con i=2
if Sum(TotW[1])=0 then
    l:=1;
fi;
for i in [1..Length(TotW)] do 
    if TestForNewVector(TotW[i],a) then #<------- QUI IL TEST VA CAMBIATO È VUOTO
		if W1[i] = TotW[i] then
        #Print(i mod 3, "--change--", old_change, "\n");
     #   Print("QUA QUA\n");
            if (i mod 3) =1 then 
                if  old_change < a then
			        blksVectCopy:=ShallowCopy(w);
                    ScOld:=ShallowCopy(old_change);
	                Add(blksVectCopy,Reversed(TotW[i]));
                    #Print(TotV[i], "\n");
    	            if Sum(Flat(blksVectCopy)) <= 6 and ScOld+Couni(TotW[i],1/3) <= a then 
	    	            Add(w,Reversed(TotW[i]));
                        old_change:=old_change+Couni(TotW[i],1/3);
                    else 
                        Add(w, Zero(TotW[i]));   
                    fi;
                else 
                    if old_keep < a then
			            blksVectCopy:=ShallowCopy(w);
                        ScOld:=ShallowCopy(old_keep);
	                    Add(blksVectCopy,TotW[i]);
                        #Print(TotV[i], "\n");
    	                if Sum(Flat(blksVectCopy)) <= 6 and ScOld+Couni(TotW[i],1/3) <= a then 
	    	                Add(w,TotW[i]);
                            old_keep:=old_keep+Couni(TotW[i],1/3);
                        else 
                            Add(w, Zero(TotW[i]));   
                        fi;
                    else 
                        Add(w, Zero(TotW[i])); 
                    fi;
		        fi;
            fi;
            #
            if i mod 3 = 2 then    
                if  old_keep < a then
			        blksVectCopy:=ShallowCopy(w);
                    ScOld:=ShallowCopy(old_keep);
	                Add(blksVectCopy,TotW[i]);
                    #Print(TotV[i], "\n");
    	            if Sum(Sum(blksVectCopy)) <= 6 and ScOld+Couni(TotW[i],1/3) <= a then 
	    	            Add(w,TotW[i]);
                        old_keep:=old_keep+Couni(TotW[i],1/3);
                    else 
                        Add(w, Zero(TotW[i]));   
                    fi;
                else 
                    Add(w, Zero(TotW[i]));      
		        fi; 
            fi;       
            if i mod 3 = 0 then #and (old_change >= a or old_keep >= a) then 
                Add(w, Zero(TotW[i]));   
            fi;
        else
        #Print(new, " ", i, "QUI QUI\n");
            if new < a then
                blksVectCopy:=ShallowCopy(w);
	            Add(blksVectCopy,TotW[i]);
                Copy_New:=ShallowCopy(new);
                #Print(Copy_New+Couni(TotW[i],1/3)<=a, " ", i, "<--\n");
                #Print(blksVectCopy, " ", i, "<--\n");
                #Print(Sum(Flat(blksVectCopy)), " ", i, "<--\n");
    	        if Sum(Flat(blksVectCopy)) <= 6 and Copy_New+Couni(TotW[i],1/3) <= a then
	    	        Add(w,TotW[i]);
                    new:=new+1;
                else 
                    Add(w, Zero(TotW[i]));   
                fi; 
            else 
                Add(w, Zero(TotW[i])); 
            fi; 
        fi;
    else 
	    Add(w, Zero(TotW[i])); ;	
	fi;
    #Print(i, "--", i mod 3, "--", w,"--", Length(w), "\n");
od;

return w;

 end;
##########################################################

##########################################################
# Example usage:
#Read("ADE_3_DivisibleVectors.gap");
# Dato:=rec(
#   SingTypeA := [ 0, 4, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeE := [ 0, 0, 0 ],
# );
# blks:=AttachBlocksOdd(Dato);
# rk:=TheRank(Dato);
# TotV:=TotalVector(blks);
# W1:=I_Blk_VectZ3(TotV);
# W2:=II_Blk_VectZ3(TotV,W1,Dato,2);
# Print("W1=". W1,"\n");
# Print("W2=", W2 "\n");
##########################################################