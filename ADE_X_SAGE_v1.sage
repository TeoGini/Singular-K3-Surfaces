"""

ALCUNI COMANDI DA NON DIMENTICARE


## Per caricare un file

load('/Users/penegini/gap4r8/ADE_X_SAGE_v1.sage')

load('/Users/penegini/gap4r8/SAGE_PROVA_T16.sage')
L16=categorize_lattices(list_of_pair_of_matrices)

load('/Users/penegini/gap4r8/SAGE_PROVA_T15.sage')
L15=categorize_lattices(list_of_pair_of_matrices)

load('/Users/penegini/gap4r8/SAGE_PROVA_T17.sage')
L17=categorize_lattices(list_of_pair_of_matrices)

## Per creare un file log 
## Se carichi da GAP4 ricordarsi di cancellare gap> all'inizio del file

import sys

log_file_path = '/Users/penegini/Dropbox/singular K3/ProgGAP4SingK3/Risultati_2.0/SAGEout16P.txt'

log_file = open(log_file_path, 'w')
sys.stdout = log_file

load('/Users/penegini/Dropbox/singular K3/ProgGAP4SingK3/Risultati_2.0/SAGE_PROVA3.sage')

log_file.close()

"""
from sage.quadratic_forms.genera.genus import GenusSymbol_global_ring, LocalGenusSymbol
from sage.rings.padics.padic_generic import ResidueLiftingMap
from sage.quadratic_forms.genera.genus import LocalGenusSymbol
from sage.quadratic_forms.genera.genus import canonical_2_adic_compartments

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

    #l=[matrix, new_matrix]
    #print(first_p_adic_test(l))
    #print(quadratic_split_case_with_symbol(l))
    
    return  [len(B.discriminant_group().gens())<= 22-B.rank()]

def Integer_Ring_Invariants(matrix): 
    lattice=IntegralLattice(matrix)
    Integer_List=[]
    for gen in lattice.discriminant_group().gens():
        Integer_List.append(gen.order())
    
    return Integer_List

def p_adic_Integer_Ring_Invariants(matrix,p): 
    lattice=IntegralLattice(matrix)
    Integer_List=[]
    for gen in lattice.discriminant_group().primary_part(p).gens():
        Integer_List.append(gen.order())
    
    return Integer_List    

def product_of_entries(arr):
    product = 1
    for num in arr:
        product *= num
    return product

# Example usage
#array = [1, 2, 3, 4, 5]
#print(product_of_entries(array))

def cols_and_rows_to_be_modified_for_p(pair_matrices,p):
    matrix=pair_matrices[1]
    Integer_List=Integer_Ring_Invariants(matrix)
    new_list=[]
    for intero in Integer_List:
        new_list.append(intero/p)

    return new_list

def multiply_m_row_by_a(M, m, a):
    """
    Multiply the last m rows of the matrix M by the integer a.
    
    Parameters:
    M : Matrix
        An n x n matrix.
    m : int
        The m-row  to multiply.
    a : int
        The integer to multiply the rows by.
        
    Returns:
    Matrix
        The resulting matrix with the last m rows multiplied by a.
    """
    # Get the number of rows in the matrix M
    n = M.nrows()
    
    # Create a new matrix to store the result
    result = M
    result[m, :] = a * result[m, :]
    
    return result

def multiply_m_colmn_by_a(M, m, a):
    """
    Multiply the last m rows of the matrix M by the integer a.
    
    Parameters:
    M : Matrix
        An n x n matrix.
    m : int
        The m-row  to multiply.
    a : int
        The integer to multiply the rows by.
        
    Returns:
    Matrix
        The resulting matrix with the last m rows multiplied by a.
    """
    # Get the number of rows in the matrix M
    n = M.ncols()
    
    # Create a new matrix to store the result
    result = M
    result[:, m] = a * result[:, m]
    
    return result    


def multiply_last_m_rows(M, m, a):
    """
    Multiply the last m rows of the matrix M by the integer a.
    
    Parameters:
    M : Matrix
        An n x n matrix.
    m : int
        The number of rows from the bottom to multiply.
    a : int
        The integer to multiply the rows by.
        
    Returns:
    Matrix
        The resulting matrix with the last m rows multiplied by a.
    """
    # Get the number of rows in the matrix M
    n = M.nrows()
    
    # Create a new matrix to store the result
    result = M
    
    # Iterate over the last m rows and multiply by a
    for i in range(n - m, n):
        result[i, :] = a * result[i, :]
    
    return result

"""
Example usage
M = Matrix(QQ, [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
m = 2
a = 3
new_matrix = multiply_last_m_rows(M, m, a)
print(new_matrix)    
"""

def multiply_last_m_columns(M, m, a):
    """
    Multiply the last m columns of the matrix M by the integer a.
    
    Parameters:
    M : Matrix
        An n x n matrix.
    m : int
        The number of columns from the bottom to multiply.
    a : int
        The integer to multiply the colums by.
        
    Returns:
    Matrix
        The resulting matrix with the last m rows multiplied by a.
    """
    # Get the number of rows in the matrix M
    n = M.ncols()
    
    # Create a new matrix to store the result
    result = M
    
    # Iterate over the last m rows and multiply by a
    for i in range(n - m, n):
        result[:, i] = a * result[:, i]
    
    return result

def matrix_to_be_tested_p(pair_matrices,p):
    matrix=pair_matrices[1]
    B=IntegralLattice(matrix)
    M=B.discriminant_group().gram_matrix_quadratic()
    result_1=M
    List_of_multipliers=cols_and_rows_to_be_modified_for_p(pair_matrices,p)
    for i in range(0,len(List_of_multipliers)):
        multiply_m_colmn_by_a(result_1, i, List_of_multipliers[i])
        multiply_m_row_by_a(result_1, i, List_of_multipliers[i])
    
    return result_1



# faccio il test p-adico sulla coppia di matrici così ho tutti i dati

def p_adic_test(pair_matrices,p):
    matrix=pair_matrices[1]
    lat_info=IntegralLattice(matrix)
    if p > 2:
        B = False
        Qp.<a>=Qq(p)
        num=(-1)^lat_info.rank()*matrix_to_be_tested_p(pair_matrices,p).determinant()
        #num=B.discriminant_group().primary_part(p).normal_form().gram_matrix_bilinear().determinant()
        den=product_of_entries(Integer_Ring_Invariants(matrix))
        #den=product_of_entries(p_adic_Integer_Ring_Invariants(matrix,p))
        A= Qp(num/den).is_square()

    if p == 2:
        Q2.<a>=Qq(2)
        num=matrix_to_be_tested_p(pair_matrices,p).determinant()
        #num=B.discriminant_group().primary_part(2).normal_form().gram_matrix_quadratic().determinant()
        #num=B.discriminant_group().primary_part(2).normal_form().gram_matrix_bilinear().determinant()
        den=product_of_entries(Integer_Ring_Invariants(matrix))
        #den=product_of_entries(p_adic_Integer_Ring_Invariants(matrix,p))
        #print(den)
        A= Q2(num/den).is_square()
        B= Q2(-num/den).is_square()

    return A or B

def Is_problematic_in_p(pair_matrices,p):
    matrix=pair_matrices[1]
    B=IntegralLattice(matrix)
    
    return len(B.discriminant_group().primary_part(p).gens()) == 22-B.rank()
        
def primes_dividing_array(L):
    # Create a set to hold unique prime factors
    prime_factors_set = set()
    
    # Iterate over each integer in the array
    for i in range(0,len(L)):
        # Get the prime factors of the number
        factors = prime_factors(L[i])
        # Add the prime factors to the set
        prime_factors_set.update(factors)
   
    # Convert the set to a sorted list and return
    return sorted(list(prime_factors_set))

def list_primes_to_check(pair_matrices):
    # returns the prime that has to be checked in the Nikulin test
    problematic_primes=[]
    matrix=pair_matrices[1]
    list_of_all_primes = primes_dividing_array(Integer_Ring_Invariants(matrix))
    for p in list_of_all_primes:
        if Is_problematic_in_p(pair_matrices,p):
            problematic_primes.append(p)

    return problematic_primes 

def first_p_adic_test(pair_matrices):
    Boolean_list = []
    for p in list_primes_to_check(pair_matrices):
        Boolean_list.append(p_adic_test(pair_matrices,p))

    return Boolean_list

def quadratic_split_case15(pair_matrices):

    matrix=pair_matrices[1]
    GS = Genus(matrix)
    LS2=GS.local_symbol(2)
    #qui mi restituisce n vettori da cui posso leggere i singoli dati del simbolo
    Canonical_2_symbol=LS2.canonical_symbol()
    # Il quinto ingresso del vettore mi da la traccia modulo 8
    y=Canonical_2_symbol[1][4]
    # il secondo ingresso del vettore mi da il rango della matrice
    x=Canonical_2_symbol[1][1]
    #Test 12 giugno
    if y != mod(-x,8):
        return True
    for a in range(1,7):
        for b in range(1,7):
            if mod(a+b,8)==x and mod(b-a,8) ==y: 
                return True

    return False


def quadratic_split_case_with_symbol(pair_matrices):

    matrix=pair_matrices[1]
    GS = Genus(matrix)
    LS2=GS.local_symbol(2)
    if matrix.nrows() == 16:
        return len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))>0
    
    if  matrix.nrows() == 17:
        return canonical_2_adic_compartments(LS2.symbol_tuple_list())[0]!=[2]
    
    return 0



def Nikulin_Test_Final(pair_matrices): 

    matrix=pair_matrices[1]
    print("SQUARE TEST:")
    print(first_p_adic_test(pair_matrices))
    if not first_p_adic_test(pair_matrices)[0] and list_primes_to_check(pair_matrices)[0]==2:
        print("2-adic TEST:")
        print(quadratic_split_case_with_symbol(pair_matrices))
        if not quadratic_split_case_with_symbol(pair_matrices):
            print("--DO BE DISCARTED--\n")
            

    if not first_p_adic_test(pair_matrices)[0] and list_primes_to_check(pair_matrices)[0]==3:
        print("--DO BE DISCARTED--\n")
        

    if len(list_primes_to_check(pair_matrices)) > 1:
        if not first_p_adic_test(pair_matrices)[1] and list_primes_to_check(pair_matrices)[1]==3:
            print("--DO BE DISCARTED--\n")
        

    return 0

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

"""
Comandi da usare dopo

Ricordiamo cosa dobbiamo fare

1) Andare a vedere se i generi p-adici con p <> 2 sono problematici. 
Se SI si procede nel seguente modo
    a) Si prende la matrice di Gramm e la si moltiplica adeguatamente per il calcolo in Q_p otteniamo una matrice M
    b) Si prende il determinante di M
    c) Si calcola in Q_p se m/p^x è un quadrato 
    d) se SI si passa al 2-adico con un VERO
    e) se NO si passa al 2-adico con un FALSO
Se NO si passa ai 2-adici     

2) Andare a vedere se il genere 2-adico è problematico
Se NO si guarda la risposta di 1) se VERO -> TENERE; se FALSO -> SCARTARE;
Se SI si procede come segue
    a)  Si prende la matrice di Gramm e la si moltiplica adeguatamente per il calcolo in Q_2 otteniamo una matrice M
    b) Si prende il determinante di M
    c) Si calcola in Q_2 se m/2^x è un quadrato 
    d) se SI -> TENERE (perché se la condizione di spezzamento è vero si tiene se è falsa si tiene perché questa è vera)
    e) se NO si passa all'ultimo test si deve vedere se la forma spezza 

3) Ultimo test vedere quando spezza q_2 
    a) Se nella parte 2-adica compare il simbolo [2^x]_y significa che la forma discriminante e' la stessa di quella di una matrice diagonale con diag=(-2)^a,2^b
        e a+b=x b-a\equiv y mod 8.
        In particolare se y \not\equiv -x mod 8 sicuramente b non e' nullo --> TENERE
    b)  Se y\equiv -x mod 8 MA esiste una soluzione di a+b=x e b-a=y mod 8 con b DIVERSO da 0, allora --> TENERE
    c)  Se ho [2^4 4^1]_1 (più in generale [2^x,...]_y) la traccia (che leggo dentro y) riguarda tutta la matrice, quindi
        [2^4 4^1]_1 è la forma discriminante 2 adica di <2>^2+<-2>^2+<4>
        Poichè ho le parentesi [ ] la forma è la stessa di <2>^b+<-2>^a+<4>
        perchè la parte diagonale con digonale 2^{-1} e 2^1 è un blocco 4x4 quindi a+b=4
        per la traccia devo prendere gli esponenti di tutti i termini, quindi ho 
        -a+b+1= y (mod 8). Una soluzione è a=b=2, quindi c'è una soluzione con b non nullo. Quindi la forma spezza come vogliamo
    d)  Se invece c'e' una parte non diagonale allora nella 2-adic compaiono o 2^2 (senza parentesi) o 2^(-2)
        2^2 corrisponde alla matrice [0,2,2,0] che ha determinante -4
        2^(-2) corrisponde alla matrice [4,2,2,4] che ha determinante 12
        (proposizione 1.8.1 Nikulin)
    e)   2^2a sono a blocchi del tipo [0,2,2,0]
        2^(-2a) e' un blocco [4,2,2,4] e (a-1) blocchi [0,2,2,0] 
        (dalla proposizione 1.8.2 2 blocchi di un tipo sono equivalenti a due blocchi dell'altro tipo)




B=IntegralLattice(l[1])
B.discriminant_group()

# sembra il comando giusto per accedere alla matrice 
B.discriminant_group().primary_part(2).normal_form()
#ATTENZIONE se non prendo normal form il determinante cambia!!!
# Con questo comando calcolo il determinante
B.discriminant_group().primary_part(2).normal_form().gram_matrix_bilinear().determinant()
# ATTENIZIONE CAPIRE COME MAI 
#B.discriminant_group().primary_part(2).normal_form().gram_matrix_quadratic().determinant()
# ci da un determinante diverso

# In questo modo restituisce una matrice di Gramm diversa da quella sopre

GS = Genus(l[1])
DF=GS.discriminant_form()
# posso accedere ai singoli p-generi
GS.local_symbol(2)
GS.local_symbol(3)
# Posso moltiplicare la forma discriminante ma rimane un modulo non una matrice
M=3*DF
# Posso anche accedere direttamente senza moltiplicare usando
M.primary_part(3)
# Per accedere alla matrice devo usare questo comando
M.gram_matrix_bilinear()
# Posso calcolare il determinante
M.gram_matrix_bilinear().determinant()
# introduciamo i dumeri 2-adici
Q2.<a>=Qq(2)



ho accesso ai dati del simbolo 2-adico nel seguente modo

GS = Genus(l[1])
GS
DF=GS.discriminant_form()
LS2=GS.local_symbol(2)
LS2.canonical_symbol()
#qui mi restituisce n vettori da cui posso leggere i singoli dati del simbolo
Canonical_2_symbol=LS2.canonical_symbol()
# Per sapere il pezzo con il 2 basta chiedere
2== 2^Canonical_2_symbol[1][0]
# Perché il primo ingresso del vettore mi da l'esponente di 2. 
# Il quinto ingresso del vettore mi da la traccia modulo 8
y=Canonical_2_symbol[1][4]
# il secondo ingresso del vettore mi da il rango della matrice
x=Canonical_2_symbol[1][1]
#Test 12 giugno
y != mod(-x,8)


#################### CASO 15 OK
tmp=0
for l in L15[1]:
    first_p_adic_test(l)
    if not first_p_adic_test(l)[0]:
        quadratic_split_case_with_symbol(l)
        if not quadratic_split_case_with_symbol(l):
            print("--LOOK HERE--\n")
            tmp

    tmp=tmp+1
    print(tmp)
    print("-------\n")

for l in L[1]:
    list_primes_to_check(l)
    
for l in L[1]:
	matrix_lattice_info(l[0],l[1])

caso problematico 

l=L15[1][2]
matrix_lattice_info(l[0],l[1])
Hm=matrix_to_be_tested_p(l,2)
matrix=l[1]
num=Hm.determinant()
den=product_of_entries(Integer_Ring_Invariants(matrix))

##############################################################

#################### CASO 16 


tmp=0
for l in L16[1]:
    quadratic_split_case_with_symbol(l)
    if not quadratic_split_case_with_symbol(l): 
        first_p_adic_test(l)[0]
        if not first_p_adic_test(l)[0]:
            print("--LOOK HERE--\n")
            tmp

    tmp=tmp+1
    print(tmp)
    print("-------\n")


tmp=0
for l in L16[1]:
    first_p_adic_test(l)
    if not first_p_adic_test(l)[0]:
        quadratic_split_case_with_symbol(l)
        if not quadratic_split_case_with_symbol(l):
            print("--LOOK HERE--\n")
            tmp

    tmp=tmp+1
    print(tmp)
    print("-------\n")



log_file_path = '/Users/penegini/desktop/SAGEout_Nik_16_test_simboli.txt'

log_file = open(log_file_path, 'w')
sys.stdout = log_file

tmp=0
for l in L16[1]:
    matrix=l[1]
    GS = Genus(matrix)
    LS2=GS.local_symbol(2)
    LS2.symbol_tuple_list()
    Canonical_2_symbol=LS2.canonical_symbol()
    print(LS2)
    print(Canonical_2_symbol)
    print(LS2.symbol_tuple_list())
    print(canonical_2_adic_compartments(LS2.symbol_tuple_list()))
    first_p_adic_test(l)
    if not first_p_adic_test(l)[0]:
        quadratic_split_case15(l)   
        if not quadratic_split_case15(l):
            print("--LOOK HERE--\n")
            tmp

    tmp=tmp+1
    print(tmp)
    print("-------\n")

# CASI PROBLEMATICI

tmp=0
for l in L16[1]: 
    matrix_lattice_info(l[0],l[1])
    tmp=tmp+1
    print(tmp-1)
    print("-------\n")

l=L16[1][44]
matrix_lattice_info(l[0],l[1])
matrix=l[1]

Hm=matrix_to_be_tested_p(l,2)
num=Hm.determinant()
den=product_of_entries(Integer_Ring_Invariants(matrix))
Q2.<a>=Qq(2)
Q2(num/den).is_square()
Q2(-num/den).is_square()

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
canonical_2_adic_compartments(LS2.symbol_tuple_list())
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol

######

l=L16[1][24]
matrix_lattice_info(l[0],l[1])
matrix=l[1]

Hm=matrix_to_be_tested_p(l,2)
num=Hm.determinant()
den=product_of_entries(Integer_Ring_Invariants(matrix))
Q2.<a>=Qq(2)
Q2(num/den).is_square()
Q2(-num/den).is_square()

B=IntegralLattice(M)
GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
canonical_2_adic_compartments(LS2.symbol_tuple_list())
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol

#####

l=L16[1][11]
matrix_lattice_info(l[0],l[1])

Hm=matrix_to_be_tested_p(l,2)
matrix=l[1]
num=Hm.determinant()
den=product_of_entries(Integer_Ring_Invariants(matrix))
Q2.<a>=Qq(2)
Q2(num/den).is_square()
Q2(-num/den).is_square()

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
canonical_2_adic_compartments(LS2.symbol_tuple_list())
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol

####


l=L16[1][15]
matrix_lattice_info(l[0],l[1])
matrix=l[1]

Hm=matrix_to_be_tested_p(l,2)
num=Hm.determinant()
den=product_of_entries(Integer_Ring_Invariants(matrix))
Q2.<a>=Qq(2)
Q2(num/den).is_square()
Q2(-num/den).is_square()

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol

###

l=L16[1][12]
matrix_lattice_info(l[0],l[1])
matrix=l[1]

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol
canonical_2_adic_compartments(LS2.symbol_tuple_list())

## COMANDI FORSE UTILI
LS2.symbol_tuple_list()
canonical_2_adic_compartments(LS2.symbol_tuple_list())

glue = [[2 * g1]]
IntegralLatticeGluing([L1], glue)
g1 = L1.discriminant_group().gens()[0]



log_file_path = '/Users/penegini/desktop/SAGEout_Nik_16.txt'

log_file = open(log_file_path, 'w')
sys.stdout = log_file


for l in L16[1]:
	matrix_lattice_info(l[0],l[1])


############## CASO 17

log_file_path = '/Users/penegini/desktop/SAGEout_Nik_17_test_simboli.txt'

log_file = open(log_file_path, 'w')
sys.stdout = log_file

tmp=0
for l in L17[1]:
    first_p_adic_test(l)
    if not first_p_adic_test(l)[0] and list_primes_to_check(l)[0]==2:
        quadratic_split_case_with_symbol(l)
        if not quadratic_split_case_with_symbol(l):
            print("--LOOK HERE--\n")
            tmp

    if not first_p_adic_test(l)[0] and list_primes_to_check(l)[0]==3:
        print("--LOOK HERE--\n")
        tmp

    if len(list_primes_to_check(l)) > 1:
        if not first_p_adic_test(l)[1] and list_primes_to_check(l)[1]==3:
            print("--LOOK HERE--\n")
            tmp

    tmp=tmp+1
    print(tmp)
    print("-------\n")


caso problematico

l=L17[1][13]
matrix_lattice_info(l[0],l[1])
first_p_adic_test(l)

l=L17[1][3]
matrix_lattice_info(l[0],l[1])
first_p_adic_test(l)

l=L17[1][1] 
matrix_lattice_info(l[0],l[1]) 
first_p_adic_test(l)

l=L17[1][237]
matrix_lattice_info(l[0],l[1])
first_p_adic_test(l)

l=L17[1][260] 
matrix_lattice_info(l[0],l[1])
first_p_adic_test(l)


l=L17[1][204]
matrix_lattice_info(l[0],l[1])
first_p_adic_test(l)

### SECONDO GRUPPO



l=L17[1][190] # qui abbiamo un problema con la parte 2
matrix_lattice_info(l[0],l[1])
matrix=l[1]

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol
canonical_2_adic_compartments(LS2.symbol_tuple_list())



l=L17[1][198] # qui abbiamo un problema con la parte 2
matrix_lattice_info(l[0],l[1])
matrix=l[1]

GS = Genus(matrix)
LS2=GS.local_symbol(2)
LS2.symbol_tuple_list()
Canonical_2_symbol=LS2.canonical_symbol()
Canonical_2_symbol
canonical_2_adic_compartments(LS2.symbol_tuple_list())
"""