#-------------------------------------------------
TotalVector:=function(blks)

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
#-------------------------------------------------

#-------------------------------------------------
TestForNewVector:=function(v,b)

    local tmp, ListD2n;

    ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2,],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    tmp:=false;
    # if Length(v) <= a then
	if v in ListD2n then
		if  Couni(v,1/2)-1 <= b then
			tmp:=true;
		fi;
	else 
		if Couni(v,1/2)<= b then
			tmp:=true;
		fi;
	fi;	

    return tmp;
end;
#---------------------------------------------------

#---------------------------------------------------
I_Blk_Vect:=function(TotV)
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
    local blksVect,v,blksVectCopy,i, j, ListD2n, ListD2n2, D2n_count,vp,D2n_inside;

    ListD2n:=[
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];

    ListD2n2:=[
    [ 1/2, 1/2, 0, 0, 0, 0 ],
    [ 1/2, 1/2, 0, 0, 0, 0, 0, 0 ],
    [ 1/2, 1/2, 0, 0, 0, 0, 0, 0, 0, 0 ], 
    [ 1/2, 1/2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
    [ 1/2, 1/2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [ 1/2, 1/2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]];

    D2n_inside:=false;

    for v in TotV do
        if v in ListD2n then
            D2n_inside:=true;
        fi;
    od;

    blksVect:=[[]];
    for v in TotV do 
		blksVectCopy:=ShallowCopy(blksVect);
		Add(blksVectCopy,v);
   			if Sum(Sum(blksVectCopy)) <= 4 then
				Add(blksVect,v);
			else
				Add(blksVect, Zero(v));
			fi;
    od;

    Remove(blksVect,1);


    # Forse conviene cominciare dal secondo vettore blocco ecco la funzione che 
    # che salta il 1 blocco

    if Sum(Flat(blksVect)) <> 4 then
        blksVect:=[[]];
        Add(blksVect,Zero(TotV[1]));
        for j in [2..Length(TotV)] do
            blksVectCopy:=ShallowCopy(blksVect);
		    Add(blksVectCopy,TotV[j]);
   			if Sum(Sum(blksVectCopy)) <= 4 then
				Add(blksVect,TotV[j]);
			else
				Add(blksVect, Zero(TotV[j]));
			fi;
        od;
    Remove(blksVect,1);
    fi;


    # Forse conviene cominciare dal terzo vettore blocco ecco la funzione che 
    # che salta il 2 blocco ma tiene il 1 blocco


    if IsBound(TotV[2]) then 
        if Sum(Flat(blksVect)) <> 4 then
            blksVect:=[[]];
            Add(blksVect,TotV[1]);
            Add(blksVect,Zero(TotV[2]));
            for j in [3..Length(TotV)] do
                blksVectCopy:=ShallowCopy(blksVect);
		        Add(blksVectCopy,TotV[j]);
   			    if Sum(Sum(blksVectCopy)) <= 4 then
			        Add(blksVect,TotV[j]);
		        else
			        Add(blksVect, Zero(TotV[j]));
		        fi;
            od;
        Remove(blksVect,1);
        fi;
    fi;

    # Qui dobbiamo sistemare i D2n che possono a volte volere solo i cornini
    D2n_count:=0;

    if Sum(Flat(blksVect)) <> 4 and D2n_inside then
        blksVect:=[[]];
        for i in [1..Length(TotV)] do
            if TotV[i] in ListD2n and D2n_count < 1 then
                blksVectCopy:=ShallowCopy(blksVect);
                vp:=ListD2n2[Position(ListD2n, TotV[i])];
                Add(blksVectCopy,vp);
                if Sum(Sum(blksVectCopy)) <= 4 then 
	    	        Add(blksVect,vp);
                    D2n_count:=D2n_count+1;
                else 
                    Add(blksVect, Zero(TotV[i]));   
                fi;
            else
                blksVectCopy:=ShallowCopy(blksVect);
		        Add(blksVectCopy,TotV[i]);
   			    if Sum(Sum(blksVectCopy)) <= 4 then
			        Add(blksVect,TotV[i]);
		        else
			        Add(blksVect, Zero(TotV[i]));
		        fi;    
            fi;
        od;
        Remove(blksVect,1);
    fi;

    D2n_count:=0;

    if Sum(Flat(blksVect)) <> 4 and D2n_inside then
        blksVect:=[[]];
        for i in [1..Length(TotV)] do
            if TotV[i] in ListD2n and D2n_count = 1 then
                blksVectCopy:=ShallowCopy(blksVect);
                vp:=ListD2n2[Position(ListD2n, TotV[i])];
                Add(blksVectCopy,vp);
                if Sum(Sum(blksVectCopy)) <= 4 then 
	    	        Add(blksVect,vp);
                    D2n_count:=D2n_count+1;
                else 
                    Add(blksVect, Zero(TotV[i]));   
                fi;
            else
                if TotV[i] in ListD2n then
                    D2n_count:=D2n_count+1;
                fi;
                blksVectCopy:=ShallowCopy(blksVect);
		        Add(blksVectCopy,TotV[i]);
   			    if Sum(Sum(blksVectCopy)) <= 4 then
			        Add(blksVect,TotV[i]);
		        else
			        Add(blksVect, Zero(TotV[i]));
		        fi;    
            fi;
        od;
        Remove(blksVect,1);
    fi;

    return blksVect;
end;
#--------------------------------------------------

#--------------------------------------------------
I_Blk_Vect_Modified:=function(Dato,Position_Vector_Zero)
    local blksVect,v,blksVectCopy,i;

    blksVect:=[[]];
    for i  in [1..Length(Dato.TotV)] do 
        if i = Position_Vector_Zero then 
            Add(blksVect, Zero(Dato.TotV[i]));
        else    
		    blksVectCopy:=ShallowCopy(blksVect);
		    Add(blksVectCopy,Dato.TotV[i]);
		    if Sum(Sum(blksVectCopy)) <= 4 then
			    Add(blksVect,Dato.TotV[i]);
		    else
			    Add(blksVect, Zero(Dato.TotV[i]));
		    fi;
        fi;        
    od;

    Remove(blksVect,1);

    return blksVect;
end;
#--------------------------------------------------
I_Blk_Vect_Modified_WithChange:=function(Dato,Position_Vector_Zero, Change_Dn2_01)
    local blksVect,v,blksVectCopy,i,ListD2n,ListD2n2,D2n_inside, D2n_count, vp;

     ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    #
    ListD2n2:=[
    [ 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];

    D2n_inside:=D2nDetect(Dato);;
    blksVect:=[[]];
    #Se mettiamo 0 non cambia il vettore D2n se mettiamo 1 ne cambia 1
    D2n_count:=Change_Dn2_01-1;

    for i  in [1..Length(Dato.TotV)] do 
        if i = Position_Vector_Zero then 
            Add(blksVect, Zero(Dato.TotV[i]));
        else   
            if Dato.TotV[i] in ListD2n and D2n_count = 0 then
                blksVectCopy:=ShallowCopy(blksVect);
                vp:=ListD2n2[Position(ListD2n, Dato.TotV[i])];
                Add(blksVectCopy,vp);
                if Sum(Sum(blksVectCopy)) <= 4 then 
	    	        Add(blksVect,vp);
                    D2n_count:=D2n_count+1;
                else 
                    Add(blksVect, Zero(Dato.TotV[i]));   
                fi;
            else
                if Dato.TotV[i] in ListD2n then
                    D2n_count:=D2n_count+1;
                fi;
                blksVectCopy:=ShallowCopy(blksVect);
		        Add(blksVectCopy,Dato.TotV[i]);
   			    if Sum(Sum(blksVectCopy)) <= 4 then
			        Add(blksVect,Dato.TotV[i]);
		        else
			        Add(blksVect, Zero(Dato.TotV[i]));
		        fi;    
            fi;
        fi;    
    od;
    Remove(blksVect,1);

    return blksVect;
end;
#--------------------------------------------------

#--------------------------------------------------
ComM_Check:=function(v1,v2)

    local V,W,i, tmp;

    V:=Flat(v1);
    W:=Flat(v2);
    tmp:=0;

    for i in [1..Length(V)] do
        if V[i] = W[i] and V[i] > 0 then
            tmp:=tmp+1;
        fi;
    od;

    return tmp;
end;
#-------------------------------------------------

#-------------------------------------------------
II_Blk_Vect:=function(TotV,v1,Dato,a)

    local w,vp,i,j,ListD2n, ListD2n2, new,blksVectCopy, ScNew, old,Copy_New,ScOld,D2n;

    D2n:=D2nDetect(Dato);
    ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    #
    ListD2n2:=[
    [ 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    w:=[];
    new:=0;
    old:=0;
    for i in [1..Length(TotV)] do 
        if TestForNewVector(TotV[i],a) then 
		    if v1[i] = TotV[i] then
                if  old < a then
                    if TotV[i] in ListD2n then
                        blksVectCopy:=ShallowCopy(w);
                        ScOld:=ShallowCopy(old);
                        vp:=ListD2n2[Position(ListD2n, TotV[i])];
                        Add(blksVectCopy,vp);
                        #new:=new+1;
                        #old:=old+Couni(TotV[i],1/2)-1;
                        #old:=old+Position(ListD2n, TotV[i]);
                        if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2)-1 <= a then 
	    	                Add(w,vp);
                            old:=old+Couni(TotV[i],1/2)-1;
                            new:=new+1;
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi;
                    else
			            blksVectCopy:=ShallowCopy(w);
                        ScOld:=ShallowCopy(old);
	                    Add(blksVectCopy,TotV[i]);
                        #Print(TotV[i], "\n");
    	                if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2) <= a then 
	    	                Add(w,TotV[i]);
                            old:=old+Couni(TotV[i],1/2);
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi;
		            fi;
                else
                    Add(w, Zero(TotV[i]));    
                fi;
            else
                if new < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
                    Copy_New:=ShallowCopy(new);
    	            if Sum(Sum(blksVectCopy)) <= 4 and Copy_New+Couni(TotV[i],1/2) <= a then
	    	            Add(w,TotV[i]);
                        new:=new+1;
                    else 
                        Add(w, Zero(TotV[i]));   
                    fi; 
                else 
                    Add(w, Zero(TotV[i])); 
                fi; 
            fi;
        else 
	        Add(w, Zero(TotV[i])); ;	
	    fi;
    od;

    # Da qui i soliti problemi con i D2n
    #Print("-->", Sum(Flat(w)), "--", w, "\n");

    if D2n[1] and Sum(Flat(w)) <> 4 then
        w:=[];
        new:=0;
        old:=0;
        for i in [1..Length(TotV)] do 
            # Print(i,"<-->", w, "\n");
            if TestForNewVector(TotV[i],a) then 
                if  TotV[i] in ListD2n then 
                    Add(w, Zero(TotV[i]));
                else
                    if v1[i] = TotV[i]  then
                        if  old < a then
			                blksVectCopy:=ShallowCopy(w);
                            ScOld:=ShallowCopy(old);
	                        Add(blksVectCopy,TotV[i]);
                            #Print(TotV[i], "\n");
    	                    if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2) <= a then 
	    	                    Add(w,TotV[i]);
                                old:=old+Couni(TotV[i],1/2);
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(TotV[i]));    
                        fi;
                    else
                        if new < a then
                            blksVectCopy:=ShallowCopy(w);
	                        Add(blksVectCopy,TotV[i]);
                            Copy_New:=ShallowCopy(new);
    	                    if Sum(Sum(blksVectCopy)) <= 4 and Copy_New+Couni(TotV[i],1/2) <= a then
	    	                    Add(w,TotV[i]);
                                new:=new+1;
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi; 
                        else 
                            Add(w, Zero(TotV[i])); 
                        fi; 
                    fi;
                fi;    
            else 
	             Add(w, Zero(TotV[i])); ;	
	        fi;
        od; 
    fi;  

    #Qui provo a mettere i D2n uguali al vettore v1.

    if ComM_Check(v1,w) <> 4 then
        w:=[];
        new:=0;
        old:=0;
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
		        if v1[i] = TotV[i] then
                    if  old < a then
                        if TotV[i] in ListD2n then
                            blksVectCopy:=ShallowCopy(w);
                            ScOld:=ShallowCopy(old);
                            vp:=TotV[i];
                            Add(blksVectCopy,vp);
                            #new:=new+1;
                            #old:=old+Couni(TotV[i],1/2)-1;
                            #old:=old+Position(ListD2n, TotV[i]);
                            if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2) <= a then 
	    	                    Add(w,vp);
                                old:=old+Couni(TotV[i],1/2);
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
			                blksVectCopy:=ShallowCopy(w);
                            ScOld:=ShallowCopy(old);
	                        Add(blksVectCopy,TotV[i]);
                            #Print(TotV[i], "\n");
    	                    if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2) <= a then 
	    	                    Add(w,TotV[i]);
                                old:=old+Couni(TotV[i],1/2);
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
		                fi;
                    else
                        Add(w, Zero(TotV[i]));    
                    fi;
                else
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_New:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_New+Couni(TotV[i],1/2) <= a then
	    	                Add(w,TotV[i]);
                            new:=new+1;
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi; 
                    else 
                        Add(w, Zero(TotV[i])); 
                    fi; 
                fi;
            else 
	            Add(w, Zero(TotV[i])); ;	
	        fi;
        od;
    fi;

    # qui provo a togliere il primo vettore del vettore totale

    if Sum(Flat(w)) <> 4 then
        w:=[];
        new:=0;
        old:=0;
        Add(w,Zero(TotV[1]));
        for i in [2..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
		        if v1[i] = TotV[i] then
                    if  old < a then
                        if TotV[i] in ListD2n then
                            blksVectCopy:=ShallowCopy(w);
                            ScOld:=ShallowCopy(old);
                            vp:=ListD2n2[Position(ListD2n, TotV[i])];
                            Add(blksVectCopy,vp);
                            #new:=new+1;
                            #old:=old+Couni(TotV[i],1/2)-1;
                        #old:=old+Position(ListD2n, TotV[i]);
                            if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2)-1 <= a then 
	    	                    Add(w,vp);
                                old:=old+Couni(TotV[i],1/2)-1;
                                new:=new+1;
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
			                blksVectCopy:=ShallowCopy(w);
                            ScOld:=ShallowCopy(old);
	                        Add(blksVectCopy,TotV[i]);
                            #Print(TotV[i], "\n");
    	                    if Sum(Sum(blksVectCopy)) <= 4 and ScOld+Couni(TotV[i],1/2) <= a then 
	    	                    Add(w,TotV[i]);
                                old:=old+Couni(TotV[i],1/2);
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
		                fi;
                    else
                        Add(w, Zero(TotV[i]));    
                    fi;
                else
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_New:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_New+Couni(TotV[i],1/2) <= a then
	    	                Add(w,TotV[i]);
                            new:=new+1;
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi; 
                    else 
                        Add(w, Zero(TotV[i])); 
                    fi; 
                fi;
            else 
	            Add(w, Zero(TotV[i])); ;	
	        fi;
        od;
    fi;

    return w;

end;
#-------------------------------------------------

#-------------------------------------------------
II_Blk_Vect_Modified:=function(Dato,V, a,Position_Vector_Zero,Change_Dn2_01,more_changes)
    # Position_Vector_Zero è il blocco in TotV che vogliamo mettere a zero

    local w,vp,i,j,ListD2n, ListD2n2, new,blksVectCopy,D2n, Copy_CV_12N,count_Dn2,Count_Vector_12N,D2n_count;

    D2n:=D2nDetect(Dato);
    ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    #
    ListD2n2:=[
    [ 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    w:=[];

    Count_Vector_12N:=[0,0];
    D2n_count:=Change_Dn2_01-1;
    for i in [1..Length(Dato.TotV)] do
        if i = Position_Vector_Zero then
            # qui metto a zero il blocco desiderato 
            Add(w, Zero(Dato.TotV[i]));
        else 
            # qui devo proseguire con tutti gli altri vettori
            if TestForNewVector(Dato.TotV[i],a) then
                if D2n[1] then
                    if Dato.TotV[i] in ListD2n then
                        if D2n_count = 0 then
                            # Considero i blocchi D2n e li prendo cambiati
                            if Count_Vector_12N[1] <= 4 and Count_Vector_12N[2] <= 4 then
                                blksVectCopy:=ShallowCopy(w);
                                Copy_CV_12N:=ShallowCopy(Count_Vector_12N);
                                vp:=ListD2n2[Position(ListD2n, Dato.TotV[i])];
                                Add(blksVectCopy,vp);
                                Copy_CV_12N:=Copy_CV_12N+Count_common_1_new(V[i],vp);
                                if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_12N[1]<= 4 and Copy_CV_12N[2]<= 4  then 
                                    # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                            Add(w,vp);
                                    Count_Vector_12N:=Count_Vector_12N+Count_common_1_new(V[i],vp);
                                    D2n_count:=D2n_count+1-more_changes;
                                else 
                                    Add(w, Zero(Dato.TotV[i]));   
                                fi;
                            else
                                Add(w, Zero(Dato.TotV[i]));
                            fi;
                        else 
                            if Count_Vector_12N[1] <= 4 and Count_Vector_12N[2] <= 4 then                        
                                blksVectCopy:=ShallowCopy(w);
                                Copy_CV_12N:=ShallowCopy(Count_Vector_12N);
                                vp:=Dato.TotV[i];
                                Add(blksVectCopy,vp);
                                #Print("Prima--", Copy_CV_12N, "\n");
                                Copy_CV_12N:=Copy_CV_12N+Count_common_1_new(V[i],vp);
                                #Print("Poi--", Copy_CV_12N, "\n");
                                if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_12N[1]<= 4 and Copy_CV_12N[2]<= 4  then 
                                    # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                            Add(w,vp);
                                    Count_Vector_12N:=Count_Vector_12N+Count_common_1_new(V[i],vp);
                                    D2n_count:=D2n_count+1;
                                else 
                                    Add(w, Zero(Dato.TotV[i]));  
                                fi; 
                            else
                                Add(w, Zero(Dato.TotV[i])); 
                            fi;  
                        fi;     
                    fi;
                fi;
                #Print("No D2n--", i, "-->>", w, "\n");
                if not Dato.TotV[i] in ListD2n then
                    if Count_Vector_12N[1] <= 4 and Count_Vector_12N[2] <= 4 then
                        blksVectCopy:=ShallowCopy(w);
                        Copy_CV_12N:=ShallowCopy(Count_Vector_12N);
                        vp:=Dato.TotV[i];
                        Add(blksVectCopy,vp);
                        #Print(Dato.BV1[i], "--", Dato.BV2[i], "---", vp, "\n");
                        #Print("Prima--", Copy_CV_12N, "\n");
                        Copy_CV_12N:=Copy_CV_12N+Count_common_1_new(V[i],vp);
                        #Print("Poi--", Copy_CV_12N,"---", Sum(Flat(blksVectCopy)), "---", blksVectCopy, "\n");
                        if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_12N[1]<= 4 and Copy_CV_12N[2]<= 4 then 
                            # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                    Add(w,vp);
                            #Print("No D2n--", i, "-->>", vp, "\n");
                            Count_Vector_12N:=Count_Vector_12N+Count_common_1_new(V[i],vp);
                        else 
                            Add(w, Zero(Dato.TotV[i]));   
                        fi;
                    else
                        Add(w, Zero(Dato.TotV[i]));
                    fi;
                fi;   
            else
                Add(w, Zero(Dato.TotV[i]));
            fi;
        fi;
    od;
   
    return w;
end;
#-------------------------------------------------

#-------------------------------------------------
III_Blk_Vect:=function(TotV, v1,v2,Dato,a)
    ##########################################################
    #
    ##########################################################

    local Count_Vector_123N,Copy_CV_123N,D2n, old123, old13, old23, vp,new, w, i, blksVectCopy,Copy_old13,Copy_old23,Copy_old123, Copy_new,ListD2n,ListD2n2, count_Dn2;

    D2n:=D2nDetect(Dato);

    ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ]];

    ListD2n2:=[
    [ 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2 ]];
    w:=[];
    old123:=0;
    old13:=0;
    old23:=0;
    new:=0;

    if not D2n[1] then
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
                if v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if old13 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+Couni(TotV[i],1/2);
                        else 
                            Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;   
                if v2[i] = TotV[i] and not v1[i] = TotV[i] then
                    if old23 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old23:=ShallowCopy(old23);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old23+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old23:=old23+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;  
                if  v1[i] = TotV[i] and v2[i] = TotV[i] then
                    if old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old123+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old123:=old123+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi; 
                if not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_new:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_new+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            new:=new+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;
            else  
                Add(w, Zero(TotV[i])); 
            fi;
        od;
    fi;

    #Print(w, "\n");
    # Now we consider the case when a D2n appears. 
    # The problem here is that sometimes one form of the 2 divisible D2n vector is good
    # some other time the other form is better. Therefore, we prove firs one kind and then 
    # in the end we try the second kind. 
    # QUESTO qui sotto è pensato per quando v2 non era dinamico 

    if D2n[1] then
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
                if TotV[i] in ListD2n then 
                    if old13 < a and old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+1<=a and Copy_old123+Position(ListD2n, TotV[i])<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+1;
                            old123:=old123+Position(ListD2n, TotV[i]);
                        else 
                            Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi;
                fi;
                if v1[i] = TotV[i] and not v2[i] = TotV[i] and not TotV[i] in ListD2n then
                    if old13 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;   
                if v2[i] = TotV[i] and not v1[i] = TotV[i] then #non c'e' v2 di tipo D2n in TotV!
                    if old23 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old23:=ShallowCopy(old23);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old23+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old23:=old23+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;  
                if  v1[i] = TotV[i] and v2[i] = TotV[i] then
                    if old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old123+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old123:=old123+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi; 
                if not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_new:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_new+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            new:=new+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;
            else  
                Add(w, Zero(TotV[i])); 
            fi;
        od;
    fi;  

    #Print(w, "\n");

    count_Dn2:=0;
    # Qui mettiamo i D2n uno diverso dall'altro 
    if D2n[1] and Sum(Flat(w)) <> 4 then
        w:=[];
        old123:=0;
        old13:=0;
        old23:=0;
        new:=0;
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
                if TotV[i] in ListD2n then
                    if count_Dn2 = 1 then
                        if old23 < a and old123 < a then
                            blksVectCopy:=ShallowCopy(w);
                            Copy_old23:=ShallowCopy(old23);
                            vp:=ListD2n2[Position(ListD2n, TotV[i])];
                            Add(blksVectCopy,vp);
                            if Sum(Flat(blksVectCopy)) <= 4 and Copy_old23+1<=a and Copy_old123+Position(ListD2n, TotV[i])<=a then 
                                # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
	    	                    Add(w,vp);
                                old23:=old23+1;
                                old123:=old123+Position(ListD2n, TotV[i]);
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(TotV[i]));   
                        fi;
                    else
                        if old13 < a and old123 < a then
                            blksVectCopy:=ShallowCopy(w);
                            Copy_old13:=ShallowCopy(old13);
                            Add(blksVectCopy,TotV[i]);
                            if Sum(Flat(blksVectCopy)) <= 4 and Copy_old13+1<=a and Copy_old123+Position(ListD2n, TotV[i])<=a then 
                                # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
	    	                    Add(w,TotV[i]);
                                old13:=old13+1;
                                old123:=old123+Position(ListD2n, TotV[i]);
                                count_Dn2:=count_Dn2+1;
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(TotV[i]));   
                        fi;
                    fi;
                fi;
                if v1[i] = TotV[i] and not v2[i] = TotV[i] and not TotV[i] in ListD2n then
                    if old13 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;   
                if v2[i] = TotV[i] and not v1[i] = TotV[i] then #non c'e' v2 di tipo D2n in TotV!
                    if old23 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old23:=ShallowCopy(old23);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old23+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old23:=old23+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;  
                if  v1[i] = TotV[i] and v2[i] = TotV[i] then
                    if old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old123+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old123:=old123+Couni(TotV[i],1/2);
                        else 
                            Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi; 
                if not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_new:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_new+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            new:=new+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;
            else  
                Add(w, Zero(TotV[i])); 
                #Qui sotto se non è un D2n
            fi;
        od;      
    fi;
    
    #Print(w, "\n");
    # Qui sotto proviamo a cambiarne due di D2 il primo e il terzo 
    count_Dn2:=0;

    if D2n[1] and Sum(Flat(w)) <> 4 then
        w:=[];
        old123:=0;
        old13:=0;
        old23:=0;
        new:=0;
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
                if TotV[i] in ListD2n then
                    if count_Dn2 = 0 or count_Dn2 = 2 then
                        if old23 < a and old123 < a and old23< a then
                            blksVectCopy:=ShallowCopy(w);
                            Copy_old23:=ShallowCopy(old23);
                            vp:=ListD2n2[Position(ListD2n, TotV[i])];
                            Add(blksVectCopy,vp);
                            if Sum(Flat(blksVectCopy)) <= 4 and Copy_old23+1<=a and Copy_old123+Position(ListD2n, TotV[i])<=a then 
                                # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
	    	                    Add(w,vp);
                                if vp = v1[i]  and not vp = v2[i] and Sum(v2[i])<>0 then
                                    old13:=old13+1;
                                    old123:=old123+Position(ListD2n, TotV[i]);
                                fi;
                                if vp = v1[i]  and not vp = v2[i] and Sum(v2[i])=0 then
                                    old13:=old13+1;
                                fi;
                                #if not vp = v1[i]  and not vp = v2[i] and Sum(v2[i])=0 then
                                #    non cambia nulla
                                #fi;
                                if not vp = v1[i]  and  vp = v2[i] then
                                    old23:=old23+1;
                                    old123:=old123+Position(ListD2n, TotV[i]);
                                fi;
                                count_Dn2:=count_Dn2+1;
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(TotV[i]));   
                        fi;
                    else
                        if old13 < a and old123 < a then
                            blksVectCopy:=ShallowCopy(w);
                            Copy_old13:=ShallowCopy(old13);
                            Add(blksVectCopy,TotV[i]);
                            if Sum(Flat(blksVectCopy)) <= 4 and Copy_old13+1<=a and Copy_old123+Position(ListD2n, TotV[i])<=a then 
                                # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
	    	                    Add(w,TotV[i]);
                                old13:=old13+1;
                                old123:=old123+Position(ListD2n, TotV[i]);
                                count_Dn2:=count_Dn2+1;
                            else 
                                Add(w, Zero(TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(TotV[i]));   
                        fi;
                    fi;
                fi;
                if v1[i] = TotV[i] and not v2[i] = TotV[i] and not TotV[i] in ListD2n then
                    if old13 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;   
                if v2[i] = TotV[i] and not v1[i] = TotV[i] then #non c'e' v2 di tipo D2n in TotV!
                    if old23 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old23:=ShallowCopy(old23);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old23+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old23:=old23+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;  
                if  v1[i] = TotV[i] and v2[i] = TotV[i] then
                    if old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old123+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old123:=old123+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi; 
                if not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_new:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_new+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            new:=new+Couni(TotV[i],1/2);
                        else 
                            Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;
            else  
                Add(w, Zero(TotV[i])); 
                #Qui sotto se non è un D2n
            fi;
        od;      
    fi;
    
    #Print(w, "\n");
    # Qui mettiamo i D2n tutti zero
    if D2n[1] and Sum(Flat(w)) <> 4 then
        w:=[];
        old123:=0;
        old13:=0;
        old23:=0;
        new:=0;
        for i in [1..Length(TotV)] do 
            if TestForNewVector(TotV[i],a) then 
                if TotV[i] in ListD2n then 
                    Add(w, Zero(TotV[i]));
                fi;
                if v1[i] = TotV[i] and not v2[i] = TotV[i] and not TotV[i] in ListD2n then
                    if old13 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old13:=ShallowCopy(old13);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old13+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old13:=old13+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;   
                if v2[i] = TotV[i] and not v1[i] = TotV[i] then #non c'e' v2 di tipo D2n in TotV!
                    if old23 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old23:=ShallowCopy(old23);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old23+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old23:=old23+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;  
                if  v1[i] = TotV[i] and v2[i] = TotV[i] then
                    if old123 < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_old123:=ShallowCopy(old123);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_old123+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            old123:=old123+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi; 
                if not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                    if new < a then
                        blksVectCopy:=ShallowCopy(w);
	                    Add(blksVectCopy,TotV[i]);
                        Copy_new:=ShallowCopy(new);
    	                if Sum(Sum(blksVectCopy)) <= 4 and Copy_new+Couni(TotV[i],1/2)<=a then
	    	                Add(w,TotV[i]);
                            new:=new+Couni(TotV[i],1/2);
                        else 
                        Add(w, Zero(TotV[i]));
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi; 
                fi;
            else  
                Add(w, Zero(TotV[i])); 
            fi;
        od;
    fi; 

    #qui ripensiamo tutto con v2 dinamico con il caso del  D2n CAMBIATO SEMPRE
    if D2n[1] and Count_common_12_23_123(Dato.BV1,Dato.BV2,w) <> [2,2,2,2] then
        w:=[];
        Count_Vector_123N:=[0,0,0,0];
        for i in [1..Length(TotV)] do
            if TestForNewVector(TotV[i],a) then 
                if TotV[i] in ListD2n then
                    if Count_Vector_123N[1] <= 2 and Count_Vector_123N[2] <= 2 and Count_Vector_123N[3] <= 2 and Count_Vector_123N[4] <= 2 then
                        blksVectCopy:=ShallowCopy(w);
                        Copy_CV_123N:=ShallowCopy(Count_Vector_123N);
                        vp:=ListD2n2[Position(ListD2n, TotV[i])];
                        Add(blksVectCopy,vp);
                        Copy_CV_123N:=Copy_CV_123N+Count_common_12_23_123(Dato.BV1[i],Dato.BV2[2],vp);
                        if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_123N[1]<= 2 and Copy_CV_123N[2]<= 2 and Copy_CV_123N[3] <= 2 and Copy_CV_123N[4] <= 2  then 
                            # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                    Add(w,vp);
                            Count_Vector_123N:=Count_Vector_123N+Count_common_12_23_123(Dato.BV1[i],Dato.BV2[i],vp);
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi;
                fi;
                if not TotV[i] in ListD2n then
                    if Count_Vector_123N[1] <= 2 and Count_Vector_123N[2] <= 2 and Count_Vector_123N[3] <= 2 and Count_Vector_123N[4] <= 2 then
                        blksVectCopy:=ShallowCopy(w);
                        Copy_CV_123N:=ShallowCopy(Count_Vector_123N);
                        vp:=TotV[i];
                        Add(blksVectCopy,vp);
                        #Print(Dato.BV1[i], "--", Dato.BV2[i], "---", vp, "\n");
                        #Print("---->>", Count_common_12_23_123(Dato.BV1[i],Dato.BV2[i],vp), "\n");
                        Copy_CV_123N:=Copy_CV_123N+Count_common_12_23_123(Dato.BV1[i],Dato.BV2[i],vp);
                        #Print("--->",Copy_CV_123N,"\n");
                        if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_123N[1]<= 2 and Copy_CV_123N[2]<= 2 and Copy_CV_123N[3] <= 2 and Copy_CV_123N[4] <= 2 then 
                            # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                    Add(w,vp);
                            Count_Vector_123N:=Count_Vector_123N+Count_common_12_23_123(Dato.BV1[i],Dato.BV2[i],vp);
                        else 
                            Add(w, Zero(TotV[i]));   
                        fi;
                    else
                        Add(w, Zero(TotV[i]));
                    fi;
                fi;   
            else
                Add(w, Zero(TotV[i])); 
            fi;
        od;
    fi;

    #Print(w, "\n");
    return w;
end;
#-------------------------------------------------

III_Blk_Vect_Modified:=function(TotV, v1,v2,Dato,a,Position_Vector_Zero,Change_Dn2_0,more_changes,all_changes,mod_constant)
    ##########################################################
    #
    ##########################################################

    local Count_Vector_123N,Copy_CV_123N,D2n, old123, old13, old23, vp,new, w, i, blksVectCopy,Copy_old13,Copy_old23,Copy_old123, Copy_new,ListD2n,ListD2n2, D2n_count;

    D2n:=D2nDetect(Dato);

     ListD2n:=[
    [ 1/2, 1/2, 0, 0], 
    [ 1/2, 0, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2],
    [ 1/2, 0, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    #
    ListD2n2:=[
    [ 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2 ], 
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],  
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ],
    [ 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2, 0, 1/2 ]];
    w:=[];

    w:=[];
    Count_Vector_123N:=[0,0,0,0];
    D2n_count:=Change_Dn2_0-1;
    for i in [1..Length(Dato.TotV)] do
        if i = Position_Vector_Zero then
            # qui metto a zero il blocco desiderato 
            Add(w, Zero(Dato.TotV[i]));
        else  
            if TestForNewVector(Dato.TotV[i],a) then 
                if Dato.TotV[i] in ListD2n then
                    if D2n_count mod mod_constant = 0 then
                        if Count_Vector_123N[1] <= 2 and Count_Vector_123N[2] <= 2 and Count_Vector_123N[3] <= 2 and Count_Vector_123N[4] <= 2 then
                            blksVectCopy:=ShallowCopy(w);
                            Copy_CV_123N:=ShallowCopy(Count_Vector_123N);
                            vp:=ListD2n2[Position(ListD2n, Dato.TotV[i])];
                            Add(blksVectCopy,vp);
                            Copy_CV_123N:=Copy_CV_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                            if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_123N[1]<= 2 and Copy_CV_123N[2]<= 2 and Copy_CV_123N[3] <= 2 and Copy_CV_123N[4] <= 2  then 
                                # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                        Add(w,vp);
                                Count_Vector_123N:=Count_Vector_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                                if all_changes = 1 then 
                                    D2n_count:=D2n_count+1-all_changes;
                                else
                                    D2n_count:=D2n_count+1-more_changes;
                                    more_changes:=more_changes - 1;
                                    #Print(more_changes, "\n");
                                fi;
                            else 
                                Add(w, Zero(Dato.TotV[i]));   
                            fi;
                        else
                            Add(w, Zero(Dato.TotV[i]));
                        fi;
                    else
                        blksVectCopy:=ShallowCopy(w);
                        Copy_CV_123N:=ShallowCopy(Count_Vector_123N);
                        vp:=Dato.TotV[i];
                        Add(blksVectCopy,vp);
                        #Print("Prima--->",Copy_CV_123N,"\n");
                        Copy_CV_123N:=Copy_CV_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                        #Print("Poi--->",Copy_CV_123N,"\n");
                         if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_123N[1]<= 2 and Copy_CV_123N[2]<= 2 and Copy_CV_123N[3] <= 2 and Copy_CV_123N[4] <= 2  then 
                            # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                    Add(w,vp);
                            Count_Vector_123N:=Count_Vector_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                            D2n_count:=D2n_count+1;
                        else 
                            Add(w, Zero(Dato.TotV[i]));  
                        fi;    
                    fi;
                fi;
                if not Dato.TotV[i] in ListD2n then
                    if Count_Vector_123N[1] <= 2 and Count_Vector_123N[2] <= 2 and Count_Vector_123N[3] <= 2 and Count_Vector_123N[4] <= 2 then
                        blksVectCopy:=ShallowCopy(w);
                        Copy_CV_123N:=ShallowCopy(Count_Vector_123N);
                        vp:=Dato.TotV[i];
                        Add(blksVectCopy,vp);
                        #Print(Dato.BV1[i], "--", Dato.BV2[i], "---", vp, "\n");
                        #Print("Prima--->",Copy_CV_123N,"\n");
                        #Print("Aggiungo---->>", Count_common_12_23_123(v1[i],v2[i],vp), "\n");
                        Copy_CV_123N:=Copy_CV_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                        #Print("Poi--->",Copy_CV_123N,"\n");
                        if Sum(Flat(blksVectCopy)) <= 4 and Copy_CV_123N[1]<= 2 and Copy_CV_123N[2]<= 2 and Copy_CV_123N[3] <= 2 and Copy_CV_123N[4] <= 2 then 
                            # Metto peosition perché è uguale al numero degli 1/2 in comune a tutti e tre
    	                    Add(w,vp);
                            Count_Vector_123N:=Count_Vector_123N+Count_common_12_23_123(v1[i],v2[i],vp);
                        else 
                            Add(w, Zero(Dato.TotV[i]));   
                        fi;
                    else
                        Add(w, Zero(Dato.TotV[i]));
                    fi;
                fi;   
            else
                Add(w, Zero(Dato.TotV[i])); 
            fi;
        fi;
    od;

    return w;
end;
#-------------------------------------------------

#-------------------------------------------------
Multiple_Vector_Triples:=function(Dato, BV3)
#-------------------------------------------------

    local  Triple_List, vect1, vect2,vect3, i, j, k,l,h,m,p, triple;

    Triple_List:=[[]];
    Append(Triple_List, [Dato.BV1, Dato.BV2, BV3]);
    triple:=[Dato.BV1,Dato.BV2,BV3];

    for i in [0..4] do#[0..Length(BV3)] do
        for j in [0..4] do#[0..Length(BV3)] do 
            for h in [0..3] do
                for k in [0..1] do
                    for l in [0..1] do
                        for m in [0..1] do
                            for p in [1..2] do
                                vect1:=I_Blk_Vect_Modified_WithChange(Dato,i,k);
                                vect2:=II_Blk_Vect_Modified(Dato,vect1,4, j,l,0);
                                vect3:=III_Blk_Vect_Modified(Dato.TotV,vect1,vect2,Dato,2,h,m,1,0,p);
                                #Print(i,"-",j, "-",k, "-",l, "--->", Count_common_12_23_123(vect1,vect2,vect3), "\n");
                                #Print(vect1,"\n");
                                #Print(vect2,"\n");
                                #Print(vect3,"\n");
                                #Print("-----\n");
                                if Count_common_12_23_123(vect1,vect2,vect3) =[2,2,2,2] and Sum(Flat(vect2))=4 then
                                    Add(Triple_List, [vect1,vect2,vect3]);
                                    #Print("Urra \n");
                                    return [vect1,vect2,vect3];
                                fi;
                            od;
                        od;
                    od;
                od;
            od;
        od;    
    od;

    return triple;
end;

#-------------------------------------------------
IV_Blk_Vect:=function(TotV, v1,v2,v3,Dato,a)
##########################################################
#
##########################################################

local D2n, old124, old134, old234, old1234, old14, old24, old34, new, w, i, x,j,blksVectCopy,Copy_old13,Copy_old23,Copy_old123, Copy_new,ListD2n;

D2n:=D2nDetect(Dato);

ListD2n:=[
[ 1/2, 1/2, 0, 0], 
];


w:=[];
old1234:=0;
old134:=0;
old234:=0;
old124:=0;
old14:=0;
old24:=0;
old34:=0;
new:=0;

for i in [1..Length(TotV)] do 
    if TestForNewVector(TotV[i],a) then 
        if TotV[i] in ListD2n then 
            if old134 < a and old1234 < a then
                blksVectCopy:=ShallowCopy(w);
	            Add(blksVectCopy,TotV[i]);
    	        if Sum(Sum(blksVectCopy)) <= 4  then
	    	        Add(w,TotV[i]);
                    old134:=old134+1;
                    old1234:=old1234+Position(ListD2n, TotV[i]);
                else 
                    Add(w, Zero(TotV[i]));
                fi;
            else
                Add(w, Zero(TotV[i]));
            fi;
        fi;

        if not TotV[i] in ListD2n then 
            if v1[i] = TotV[i] and not v2[i] = TotV[i] and not v3[i] = TotV[i] then
                if old14 < a then
                    blksVectCopy:=ShallowCopy(w);
                    Add(blksVectCopy,TotV[i]);
	                if Sum(Sum(blksVectCopy)) <= 4  then
    	                Add(w,TotV[i]);
                        old14:=old14+Couni(TotV[i],1/2);
                    else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi;  

            if v2[i] = TotV[i] and not v1[i] = TotV[i] and not v3[i] = TotV[i] then
                if old24 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4 then
	    	            Add(w,TotV[i]);
                        old24:=old24+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi;  

                if v3[i] = TotV[i] and not v1[i] = TotV[i] and not v2[i] = TotV[i] then
                if old34 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4 then
	    	            Add(w,TotV[i]);
                        old34:=old34+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi;  

            if  v1[i] = TotV[i] and v2[i] = TotV[i] and not v3[i] = TotV[i] then
                if old124 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4  then
	    	            Add(w,TotV[i]);
                        old124:=old124+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi; 

             if  v1[i] = TotV[i] and v3[i] = TotV[i] and not v2[i] = TotV[i] then
                if old134 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4  then
	    	            Add(w,TotV[i]);
                        old134:=old134+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi; 

            if  v2[i] = TotV[i] and v3[i] = TotV[i] and  v1[i] = TotV[i] then
                if old1234 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4  then
	    	            Add(w,TotV[i]);
                        old1234:=old1234+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi;

            if  v2[i] = TotV[i] and v3[i] = TotV[i] and not v1[i] = TotV[i] then
                if old234 < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4  then
	    	            Add(w,TotV[i]);
                        old234:=old234+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                else
                    Add(w, Zero(TotV[i]));
                fi; 
            fi;

            if not v1[i] = TotV[i] and not v2[i] = TotV[i] and not v3[i] = TotV[i] then
                #if new < a then
                    blksVectCopy:=ShallowCopy(w);
	                Add(blksVectCopy,TotV[i]);
    	            if Sum(Sum(blksVectCopy)) <= 4  then
	    	            Add(w,TotV[i]);
                        new:=new+Couni(TotV[i],1/2);
                     else 
                    Add(w, Zero(TotV[i]));
                    fi;
                #else
                #    Add(w, Zero(TotV[i]));
                #fi; 
            fi;
        fi;
    else  
        Add(w, Zero(TotV[i])); 
    fi;    
od;

##
##
## Secondo caso quando compare un D4
##
##


#if Sum(Flat(w)) <> 4 then
#    x:=Couni(TotV,[1/2]) - Couni(w,[1/2]); 
#    for j in [1..x] do
#        blksVectCopy:=ShallowCopy(w);
#	    blksVectCopy[Length(TotV)-j]:=[1/2];
#    	if Sum(Sum(blksVectCopy)) <= 4  then
#            w[Length(TotV)-j]:=[1/2];
#        fi;
#    od;
#fi;

return w;
end;
#








#---------------------------------------------------
# Example usage:
#Dato:=rec(
#   SingTypeA := [ 12, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
#   SingTypeD := [ 1,0,0,0,0 ],
#   SingTypeE := [ 0, 0, 0 ]
# );
#blks:=BlocksClean(AttachBlocks(Dato));
#rk:=TheRank(Dato);
#TotV:=TotalVector(blks);
#v1:=I_Blk_Vect(TotV);
#v2:=II_Blk_Vect(TotV,v1,Dato, 4);
#v3:=III_Blk_Vect(TotV,v1,v2,Dato,2);
#v4:=IV_Blk_Vect(TotV,v1,v2,v3,Dato,1);

#Print("\n ------------ \n");
#Print("TotV=",TotV, "\n");
#Print("\n ------------ \n");
#Print("v1=",v1, "\n");
#Print("v2=", v2, "\n");
#Print("v3=", v3, "\n");
#Print("v4=", v4, "\n");

 #---------------------------------------------------