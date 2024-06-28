"""
These are the scripts for SAGE we used in the article


To use them first Load a file  (ex in rank 14)

load('/Users/.../gap4r8/SAGE_PROVA_T14.sage')

Containing a list of matrices with divisible vectores as for example:


A=Matrix(QQ,14,14, [-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2])
vect1 = vector([1/2,1/2,1/2,1/2,1/2,1/2,1/2,1/2,0,0,0,0,0,0])
vect2= vector([1/2,1/2,1/2,1/2,0,0,0,0,1/2,1/2,1/2,1/2,0,0])
vect3= vector([1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2,0,0,1/2,1/2])

The following function return the intersaction matrix of the overlattice induced by A and the three vectors vect1, vect2,vect3

T=three_vector_new_matrix(A, vect1,vect2, vect3) 

Create a list
list_of_pair_of_matrices = []

and append in the list the datum T=(T[0],T[1]) -- which is a pair of matrices: the first matrix T[0]=A and the second one
is the matrix of an overlatice. If no divisible vector are to be added then T[0]=T[1].

list_of_pair_of_matrices.append(T)

Once you have the list_of_pair_of_matrices you can dived them into Good Nikulin and Discarded cases. This is done by the function 

L14=categorize_lattices(list_of_pair_of_matrices)

OUTPUT
-----------------
L14[0]=Good cases 
L14[1]=Nikulin cases --> need further attentions
L14[2]=Discarded cases
----------------

Then consider L14[1] and use the function

L14NikGood=Nik_Good_List_function(L14[1])

to apply Thm 1.12.2 [Nikulin] to check if the lattice embeds in lambda_k3 properly. 

The union of the lists: L14[0] + L14NikGood is the wished list of all the ADE lattices 

"""

# SOME PAKAGES REQUIRED
from sage.quadratic_forms.genera.genus import GenusSymbol_global_ring, LocalGenusSymbol
from sage.rings.padics.padic_generic import ResidueLiftingMap
from sage.quadratic_forms.genera.genus import LocalGenusSymbol
from sage.quadratic_forms.genera.genus import canonical_2_adic_compartments
from sage.quadratic_forms.genera.genus import p_adic_symbol
from sage.quadratic_forms.genera.genus import Genus_Symbol_p_adic_ring

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
# Example
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
 Example usage:

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

def simple_k3_list(pair_of_matrices):

    simple_k3 = []
    for A in pair_of_matrices:
        if A[0]==A[1]:
            simple_k3.append(A)

    return simple_k3



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
        num=(-1)*matrix_to_be_tested_p(pair_matrices,p).determinant()
        #num=(-1)^lat_info.rank()*matrix_to_be_tested_p(pair_matrices,p).determinant()
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
    if matrix.nrows() < 17:
        tmp = len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))>0
        return len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))>0
    
    if  matrix.nrows() == 17:
        print(canonical_2_adic_compartments(LS2.symbol_tuple_list()))
        tmp = canonical_2_adic_compartments(LS2.symbol_tuple_list())[0]!=[2]
        return canonical_2_adic_compartments(LS2.symbol_tuple_list())[0]!=[2]
    
    if  matrix.nrows() > 17:
        print(canonical_2_adic_compartments(LS2.symbol_tuple_list()))
        if len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))==0:
            tmp = False
            return False
        if len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))>1:
            tmp = True
            return True    
        if len(canonical_2_adic_compartments(LS2.symbol_tuple_list()))==1:   
            if len(canonical_2_adic_compartments(LS2.symbol_tuple_list())[0])>1:
                tmp = True
                return True
            if len(canonical_2_adic_compartments(LS2.symbol_tuple_list())[0])==1:
                if canonical_2_adic_compartments(LS2.symbol_tuple_list())[0]!=[1]:
                    tmp = False
                    return False
                if canonical_2_adic_compartments(LS2.symbol_tuple_list())[0]==[1]:
                    if GS.local_symbol(2).level() == 2:
                        tmp = True
                        return True
                    else:
                        if LS2.number_of_blocks() > 2:
                            tmp = True
                            return True
                        else:    
                            tmp =False
                            return False

    return tmp



def Nikulin_Test_Final(pair_matrices): 

    matrix=pair_matrices[1]
    tmp = True
    print("SQUARE TEST:")
    print(first_p_adic_test(pair_matrices))
    if not first_p_adic_test(pair_matrices)[0] and list_primes_to_check(pair_matrices)[0]==2:
        print("2-adic TEST:")
        print(quadratic_split_case_with_symbol(pair_matrices))
        if not quadratic_split_case_with_symbol(pair_matrices):
            tmp = False
            print("--DO BE DISCARTED--\n")
            

    if not first_p_adic_test(pair_matrices)[0] and list_primes_to_check(pair_matrices)[0]>2:
        tmp = False
        print("--DO BE DISCARTED--\n")
        

    if len(list_primes_to_check(pair_matrices)) > 1:
        if not first_p_adic_test(pair_matrices)[1] and list_primes_to_check(pair_matrices)[1]>2:
            tmp = False
            print("--DO BE DISCARTED--\n")
        
    print("TMP=")
    print(tmp)
    print("-----END CASE ---")
    return tmp

def Nik_Good_List_function(pair_of_matrices):

    Nik_Good_List=[]
    i=0
    for A in pair_of_matrices:
        if Nikulin_Test_Final(A):
            print(i)
            i=i+1
            Nik_Good_List.append(A)

    return Nik_Good_List

def Is_simple_test(pair_matrices):

    if pair_matrices[0] == pair_matrices[1]:
        return True

    return False