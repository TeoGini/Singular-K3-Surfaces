"""

ALCUNI COMANDI DA NON DIMENTICARE


## Per caricare un file

load('/Users/penegini/gap4r8/ADE_X_SAGE_v1.sage')

load('/Users/penegini/Dropbox/singular K3/ProgGAP4SingK3/Risultati_2.0/SAGE_PROVA_T18_b.sage')

## Per creare un file log 
## Se carichi da GAP4 ricordarsi di cancellare gap> all'inizio del file

import sys

log_file_path = '/Users/penegini/Dropbox/singular K3/ProgGAP4SingK3/Risultati_2.0/SAGEout16P.txt'

log_file = open(log_file_path, 'w')
sys.stdout = log_file

load('/Users/penegini/Dropbox/singular K3/ProgGAP4SingK3/Risultati_2.0/SAGE_PROVA3.sage')

log_file.close()

"""


def associated_dynkin_lattice(matrix):
    n = matrix.ncols()
    # Check if the matrix is symmetric
    if not matrix.is_symmetric():
        raise ValueError("The matrix must be symmetric.")
    # Construct the adjacency matrix
    adj_matrix = [[1 if matrix[i,j] != 0 and i != j else 0 for j in range(n)] for i in range(n)]
    G = Graph({i: [j for j in range(n) if adj_matrix[i][j] == 1] for i in range(n)})
    roots = G.connected_components_subgraphs()
    roots_weights = []
    for root in roots:
        weights = []
        for vertex in root.vertices():
            weight = sum(adj_matrix[vertex])
            weights.append(weight)
        roots_weights.append(weights)
    return roots_weights

# Compute the associated Dynkin lattice
# Esempio
#
# matrix=Matrix(QQ,19,19, [-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,1,0,0,0,
# 0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
# 1,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,
# 0,0,0,0,1,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,
# 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,
# 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,
# 0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
# dynkin_lattice = associated_dynkin_lattice(matrix)
# print(dynkin_lattice)



def get_dynkin_label(vector):
    n = len(vector)
    if vector == [0]:
        label = "A" + str(n)
    if vector == [1, 1]:
        label = "A" + str(n)
    if vector == [1, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)
    if vector ==[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "A" + str(n)

    if vector == [1,3,1,1] or vector ==[1,3,1,1][::-1]:
        label = "D" + str(n)
    if vector == [1,2,3,1,1] or vector ==[1,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector == [1,2,2,3,1,1] or vector ==[1,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,3,1,1] or vector ==[1,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1] or vector ==[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,1,1][::-1]:
        label = "D" + str(n)
    if vector ==[1, 1, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]:
        label = "D" + str(n)        
    if vector == [1, 1, 2, 3, 2, 1] or vector ==[1, 1, 2, 3, 2, 1][::-1]: #1, 2, 3, 2, 2, 1, 1
        label = "E" + str(n)
    if vector == [1, 1, 2, 3, 2, 2, 1] or vector ==[1, 1, 2, 3, 2, 2, 1][::-1] or vector == [1, 2, 3, 2, 2, 1, 1]: 
        label = "E" + str(n)
    if vector == [1, 1, 2, 3, 2, 2, 2, 1] or vector ==[1, 1, 2, 3, 2, 2, 2, 1][::-1] or vector ==[1, 2, 3, 2, 2, 2, 1, 1]:
        label = "E" + str(n)

    return label


def count_vector_occurrences(vector_list):
    occurrences = {}
    for vector in vector_list:
        vector_tuple = tuple(vector)  # Convert list to tuple to make it hashable
        occurrences[vector_tuple] = occurrences.get(vector_tuple, 0) + 1
    return list(occurrences.values())

# Example usage
#vector_list = [[1], [1, 2], [1, 2]]
#occurrences = count_vector_occurrences(vector_list)
#print(occurrences)


def count_occurrences(input_list):
    counts = {}
    for vector in input_list:
        counts[tuple(vector)] = counts.get(tuple(vector), 0) + 1
    return counts

def print_dynkin_label(vector):

    occurrences = count_occurrences(vector)
    for vector, count in occurrences.items():
        print(f" {count}{get_dynkin_label(list(vector))}","+", end="")
    
    return 0



    # Example Usage
"""    
 matrix=Matrix(QQ,19,19, [-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,1,0,0,0,
 0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
 1,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,
 0,0,0,0,1,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,
 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,
 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,
 0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
 dynkin_lattice = associated_dynkin_lattice(matrix)
 print(dynkin_lattice)
 print_dynkin_label(dynkin_lattice)
"""
"""
M=CartanType(['A',5]).cartan_matrix()
dynkin_lattice = associated_dynkin_lattice(M)
print(dynkin_lattice)
print_dynkin_label(dynkin_lattice)
"""

"""
# ESEMPIO CHE FUNZIONA CON ANCHE W2!

A=Matrix(QQ,19,19, [-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
dynkin_lattice = associated_dynkin_lattice(A)
print(dynkin_lattice)
print_dynkin_label(dynkin_lattice)
# 0
B=IntegralLattice(A) 
print(B.genus()) 
print(B.discriminant_group()) 
len(B.discriminant_group().gens())
BB = B 
v= vector([0,0,0,0,0,1/3,2/3,1/3,2/3,1/3,2/3,1/3,2/3,1/3,2/3,1/3,2/3,0,0])
M5 = B.overlattice([v])
M5.discriminant_group()
print(M5.genus()) 
len(M5.discriminant_group().gens())
len(M5.discriminant_group().gens())<= 22-B.rank()
"""

def categorize_lattices(matrices):
    smaller_than_rank = []
    equal_to_rank = []
    bigger_than_rank = []
    
    for A in matrices:
        lattice = IntegralLattice(A[1]) 
        rank = lattice.rank()
        discriminant_group = lattice.discriminant_group()
        generator_count = len(discriminant_group.gens())
        
        if generator_count < (22 - rank):
            smaller_than_rank.append(A)
        elif generator_count == (22 - rank):
            equal_to_rank.append(A)
        else:
            bigger_than_rank.append(A)
    
    return smaller_than_rank, equal_to_rank, bigger_than_rank

def zero_vector_new_matrix(matrix):
    return  [matrix,matrix]    

def one_vector_new_matrix(matrix, vector):

    B=IntegralLattice(matrix) 
    M1 = B.overlattice([vector])
    return  [matrix,M1.gram_matrix()]

def two_vector_new_matrix(matrix, vect1, vect2 ):

    B=IntegralLattice(matrix) 
    M1 = B.overlattice([vect1])
    M2 = M1.overlattice([vect2])
    return  [matrix,M2.gram_matrix()]

def three_vector_new_matrix(matrix, vect1, vect2, vect3):

    B=IntegralLattice(matrix) 
    M1 = B.overlattice([vect1])
    M2 = M1.overlattice([vect2])
    M3 = M2.overlattice([vect3])
    return  [matrix,M3.gram_matrix()]

def four_vector_new_matrix(matrix, vect1, vect2, vect3, vect4):

    B=IntegralLattice(matrix) 
    M1 = B.overlattice([vect1])
    M2 = M1.overlattice([vect2])
    M3 = M2.overlattice([vect3])
    M4 = M3.overlattice([vect4])
    return  [matrix,M4.gram_matrix()]

def matrix_lattice_info(matrix, new_matrix):

    dynkin_lattice = associated_dynkin_lattice(matrix)  
    print(dynkin_lattice)
    print_dynkin_label(dynkin_lattice)
# 0
    B=IntegralLattice(new_matrix) 
    print(B.genus()) 
    print(B.discriminant_group()) 
    print(len(B.discriminant_group().gens()))
    
   
    return  [len(B.discriminant_group().gens())<= 22-B.rank()]

"""
QUI ABBIAMO UN ESEMPIO DI DIVISIONE IN GOOD-NIK-DISC TUTTO SAGE 
list_of_pair_of_matrices = []

A=Matrix(QQ,16,16, [-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
vect1 = vector([1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,0,0,0,0,0,0,0,0])
vect2= vector([1/2,1/2,1/2,1/2,0,0,0,0,1/2,1/2,1/2,1/2,0,0,0,0])
vect3= vector([1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2,0,0])
vect4= vector([1/2,0,1/2,0,1/2,0,1/2,0,1/2,0,1/2,0,1/2,0,1/2,0])
T=four_vector_new_matrix(A, vect1, vect2, vect3,vect4) 
list_of_pair_of_matrices.append(T)

A=Matrix(QQ,16,16, [-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
vect1 = vector([0,0,1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,0,0,0,0,0,0])
vect2= vector([0,0,1/2,1/2,1/2,1/2,0,0,0,0,1/2,1/2,1/2,1/2,0,0])
vect3= vector([0,0,1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2])
T=three_vector_new_matrix(A, vect1,vect2, vect3) 
list_of_pair_of_matrices.append(T)

L=categorize_lattices(list_of_pair_of_matrices)
for l in L[2]:
	matrix_lattice_info(l[0],l[1])
"""
