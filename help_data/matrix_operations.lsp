;; help_data/matrix_operations.lsp

(push (make-function-info
        :name "make-matrix"
        :description "Create a matrix with specified dimensions and data."
        :parameters "(n m my-list)"
        :category "Matrix Operations"
        :example "(make-matrix 2 3 '(1 2 3 4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "display-matrix-subset"
        :description "Display a subset of matrix elements within specified ranges."
        :parameters "(start-i end-i start-j end-j my-matrix)"
        :category "Matrix Operations"
        :example "(display-matrix-subset 0 2 0 2 my-matrix)")
      *help-functions*)

;;; ============================================================
;;; Matrix Creation & Initialization
;;; ============================================================

(push (make-function-info
        :name "identity-matrix"
        :description "Create an n x n identity matrix."
        :parameters "(n)"
        :category "Matrix Operations"
        :example "(identity-matrix 3)")
      *help-functions*)

(push (make-function-info
        :name "zero-matrix"
        :description "Create an n x m matrix of zeros."
        :parameters "(n m)"
        :category "Matrix Operations"
        :example "(zero-matrix 3 4)")
      *help-functions*)

(push (make-function-info
        :name "ones-matrix"
        :description "Create an n x m matrix of ones."
        :parameters "(n m)"
        :category "Matrix Operations"
        :example "(ones-matrix 2 3)")
      *help-functions*)

(push (make-function-info
        :name "diagonal-matrix"
        :description "Create a square diagonal matrix from a list of diagonal entries."
        :parameters "(diag-list)"
        :category "Matrix Operations"
        :example "(diagonal-matrix '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "random-matrix"
        :description "Create an n x m matrix with uniform random entries in [0,1)."
        :parameters "(n m)"
        :category "Matrix Operations"
        :example "(random-matrix 3 3)")
      *help-functions*)

(push (make-function-info
        :name "random-normal-matrix"
        :description "Create an n x m matrix with standard normal random entries."
        :parameters "(n m)"
        :category "Matrix Operations"
        :example "(random-normal-matrix 3 3)")
      *help-functions*)

(push (make-function-info
        :name "constant-matrix"
        :description "Create an n x m matrix filled with constant value val."
        :parameters "(n m val)"
        :category "Matrix Operations"
        :example "(constant-matrix 3 3 7)")
      *help-functions*)

(push (make-function-info
        :name "matrix-from-rows"
        :description "Create a matrix from a list of row lists."
        :parameters "(row-lists)"
        :category "Matrix Operations"
        :example "(matrix-from-rows '((1 2 3) (4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-from-columns"
        :description "Create a matrix from a list of column lists."
        :parameters "(col-lists)"
        :category "Matrix Operations"
        :example "(matrix-from-columns '((1 4) (2 5) (3 6)))")
      *help-functions*)

(push (make-function-info
        :name "copy-matrix"
        :description "Create a deep copy of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(copy-matrix my-matrix)")
      *help-functions*)

(push (make-function-info
        :name "hilbert-matrix"
        :description "Create an n x n Hilbert matrix: H(i,j) = 1/(i+j+1)."
        :parameters "(n)"
        :category "Matrix Operations"
        :example "(hilbert-matrix 4)")
      *help-functions*)

(push (make-function-info
        :name "vandermonde-matrix"
        :description "Create a Vandermonde matrix from a vector (list)."
        :parameters "(vec)"
        :category "Matrix Operations"
        :example "(vandermonde-matrix '(1 2 3 4))")
      *help-functions*)

(push (make-function-info
        :name "toeplitz-matrix"
        :description "Create a symmetric Toeplitz matrix from its first row."
        :parameters "(first-row)"
        :category "Matrix Operations"
        :example "(toeplitz-matrix '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "companion-matrix"
        :description "Create a companion matrix for a monic polynomial with given coefficients (lowest degree first)."
        :parameters "(coeffs)"
        :category "Matrix Operations"
        :example "(companion-matrix '(6 -5 1))")
      *help-functions*)

(push (make-function-info
        :name "exchange-matrix"
        :description "Create an n x n exchange (reversal) matrix."
        :parameters "(n)"
        :category "Matrix Operations"
        :example "(exchange-matrix 4)")
      *help-functions*)

(push (make-function-info
        :name "circulant-matrix"
        :description "Create a circulant matrix from its first row."
        :parameters "(first-row)"
        :category "Matrix Operations"
        :example "(circulant-matrix '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "tridiagonal-matrix"
        :description "Create an n x n tridiagonal matrix with given lower, main, and upper diagonal values."
        :parameters "(n lower main upper)"
        :category "Matrix Operations"
        :example "(tridiagonal-matrix 4 -1 2 -1)")
      *help-functions*)

(push (make-function-info
        :name "upper-triangular-from-list"
        :description "Create an n x n upper triangular matrix from a flat list of upper entries."
        :parameters "(n vals)"
        :category "Matrix Operations"
        :example "(upper-triangular-from-list 3 '(1 2 3 4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "lower-triangular-from-list"
        :description "Create an n x n lower triangular matrix from a flat list of lower entries."
        :parameters "(n vals)"
        :category "Matrix Operations"
        :example "(lower-triangular-from-list 3 '(1 2 3 4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "block-diagonal-matrix"
        :description "Create a block diagonal matrix from a list of square matrices."
        :parameters "(matrices)"
        :category "Matrix Operations"
        :example "(block-diagonal-matrix (list (identity-matrix 2) (identity-matrix 3)))")
      *help-functions*)

(push (make-function-info
        :name "augmented-matrix"
        :description "Create an augmented matrix [A|b] from matrix A and vector b."
        :parameters "(mat vec)"
        :category "Matrix Operations"
        :example "(augmented-matrix (identity-matrix 3) '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "hankel-matrix"
        :description "Create a Hankel matrix from its first column."
        :parameters "(first-col)"
        :category "Matrix Operations"
        :example "(hankel-matrix '(1 2 3 4))")
      *help-functions*)

(push (make-function-info
        :name "sparse-to-dense"
        :description "Create an n x m matrix from a list of (row col value) triplets."
        :parameters "(n m triplets)"
        :category "Matrix Operations"
        :example "(sparse-to-dense 3 3 '((0 0 1) (1 1 2) (2 2 3)))")
      *help-functions*)

(push (make-function-info
        :name "range-vector"
        :description "Create a list (vector) from start to end (exclusive) with given step."
        :parameters "(start end &optional step)"
        :category "Matrix Operations"
        :example "(range-vector 0 10 2)")
      *help-functions*)

(push (make-function-info
        :name "linspace-vector"
        :description "Create a list of n evenly spaced values from start to end (inclusive)."
        :parameters "(start end n)"
        :category "Matrix Operations"
        :example "(linspace-vector 0 1 5)")
      *help-functions*)

;;; ============================================================
;;; Matrix Properties & Queries
;;; ============================================================

(push (make-function-info
        :name "matrix-rows"
        :description "Return the number of rows in a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-rows (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-cols"
        :description "Return the number of columns in a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-cols (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-dimensions"
        :description "Return a list (rows cols) of matrix dimensions."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-dimensions (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element"
        :description "Return the element at row i, column j of the matrix."
        :parameters "(mat i j)"
        :category "Matrix Operations"
        :example "(matrix-element (identity-matrix 3) 0 0)")
      *help-functions*)

(push (make-function-info
        :name "matrix-set-element"
        :description "Set the element at row i, column j to val. Returns the modified matrix."
        :parameters "(mat i j val)"
        :category "Matrix Operations"
        :example "(matrix-set-element (identity-matrix 3) 0 1 5)")
      *help-functions*)

(push (make-function-info
        :name "matrix-trace"
        :description "Calculate the trace (sum of diagonal elements) of a square matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-trace (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-rank-estimate"
        :description "Estimate the rank of a matrix using SVD singular values."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-rank-estimate (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-determinant"
        :description "Calculate the determinant of a square matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-determinant (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "is-square-p"
        :description "Check if a matrix is square."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(is-square-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-symmetric-p"
        :description "Check if a matrix is symmetric within tolerance."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-symmetric-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-diagonal-p"
        :description "Check if a matrix is diagonal within tolerance."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-diagonal-p (diagonal-matrix '(1 2 3)))")
      *help-functions*)

(push (make-function-info
        :name "is-upper-triangular-p"
        :description "Check if a matrix is upper triangular within tolerance."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-upper-triangular-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-lower-triangular-p"
        :description "Check if a matrix is lower triangular within tolerance."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-lower-triangular-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-identity-p"
        :description "Check if a matrix is an identity matrix within tolerance."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-identity-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-orthogonal-p"
        :description "Check if a matrix is orthogonal: A^T * A = I."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-orthogonal-p (rotation-matrix-2d 0.5))")
      *help-functions*)

(push (make-function-info
        :name "is-positive-definite-p"
        :description "Check if a symmetric matrix is positive definite via Cholesky attempt."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(is-positive-definite-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-singular-p"
        :description "Check if a matrix is singular (determinant near zero)."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-singular-p (zero-matrix 3 3))")
      *help-functions*)

(push (make-function-info
        :name "is-nilpotent-p"
        :description "Check if A^k = 0 for given k."
        :parameters "(mat k)"
        :category "Matrix Operations"
        :example "(is-nilpotent-p (zero-matrix 3 3) 1)")
      *help-functions*)

(push (make-function-info
        :name "is-involutory-p"
        :description "Check if A^2 = I (matrix is its own inverse)."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-involutory-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "is-idempotent-p"
        :description "Check if A^2 = A."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-idempotent-p (identity-matrix 3))")
      *help-functions*)

;;; ============================================================
;;; Basic Matrix Arithmetic
;;; ============================================================

(push (make-function-info
        :name "matrix-add"
        :description "Add two matrices element-wise."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-add (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-subtract"
        :description "Subtract matrix b from matrix a element-wise."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-subtract (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-scale"
        :description "Multiply every element of a matrix by a scalar."
        :parameters "(scalar mat)"
        :category "Matrix Operations"
        :example "(matrix-scale 3 (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-multiply"
        :description "Multiply two matrices using matmult."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-multiply (identity-matrix 2) (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-transpose"
        :description "Transpose a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-transpose (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-inverse"
        :description "Compute the inverse of a square matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-inverse (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-negate"
        :description "Negate all elements of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-negate (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-multiply"
        :description "Hadamard (element-wise) product of two matrices."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-element-multiply (ones-matrix 2 2) (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-divide"
        :description "Element-wise division of matrix a by matrix b."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-element-divide (make-matrix 2 2 '(4 6 8 10)) (make-matrix 2 2 '(2 3 4 5)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-add-scalar"
        :description "Add scalar s to every element of a matrix."
        :parameters "(mat s)"
        :category "Matrix Operations"
        :example "(matrix-element-add-scalar (identity-matrix 2) 5)")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-power"
        :description "Raise every element of a matrix to power p."
        :parameters "(mat p)"
        :category "Matrix Operations"
        :example "(matrix-element-power (make-matrix 2 2 '(1 2 3 4)) 2)")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-sqrt"
        :description "Take the square root of every element of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-element-sqrt (make-matrix 2 2 '(1 4 9 16)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-abs"
        :description "Take the absolute value of every element of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-element-abs (make-matrix 2 2 '(-1 2 -3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-max"
        :description "Element-wise maximum of two matrices."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-element-max (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-element-min"
        :description "Element-wise minimum of two matrices."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-element-min (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-power"
        :description "Raise a square matrix to the nth power (non-negative integer)."
        :parameters "(mat n)"
        :category "Matrix Operations"
        :example "(matrix-power (make-matrix 2 2 '(1 1 0 1)) 5)")
      *help-functions*)

(push (make-function-info
        :name "matrix-square"
        :description "Compute A^2 = A * A."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-square (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-cube"
        :description "Compute A^3 = A * A * A."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-cube (make-matrix 2 2 '(1 1 0 1)))")
      *help-functions*)

(push (make-function-info
        :name "commutator"
        :description "Compute the commutator [A, B] = AB - BA."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(commutator (make-matrix 2 2 '(1 0 0 2)) (make-matrix 2 2 '(0 1 1 0)))")
      *help-functions*)

(push (make-function-info
        :name "anticommutator"
        :description "Compute the anticommutator {A, B} = AB + BA."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(anticommutator (make-matrix 2 2 '(1 0 0 2)) (make-matrix 2 2 '(0 1 1 0)))")
      *help-functions*)

;;; ============================================================
;;; Row & Column Operations
;;; ============================================================

(push (make-function-info
        :name "matrix-row"
        :description "Extract row i of a matrix as a list."
        :parameters "(mat i)"
        :category "Matrix Operations"
        :example "(matrix-row (make-matrix 2 3 '(1 2 3 4 5 6)) 0)")
      *help-functions*)

(push (make-function-info
        :name "matrix-column"
        :description "Extract column j of a matrix as a list."
        :parameters "(mat j)"
        :category "Matrix Operations"
        :example "(matrix-column (make-matrix 2 3 '(1 2 3 4 5 6)) 1)")
      *help-functions*)

(push (make-function-info
        :name "matrix-diagonal"
        :description "Extract the main diagonal of a matrix as a list."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-diagonal (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-set-row"
        :description "Return a new matrix with row i replaced by the given row list."
        :parameters "(mat i row)"
        :category "Matrix Operations"
        :example "(matrix-set-row (identity-matrix 3) 0 '(9 8 7))")
      *help-functions*)

(push (make-function-info
        :name "matrix-set-column"
        :description "Return a new matrix with column j replaced by the given column list."
        :parameters "(mat j col)"
        :category "Matrix Operations"
        :example "(matrix-set-column (identity-matrix 3) 0 '(9 8 7))")
      *help-functions*)

(push (make-function-info
        :name "matrix-swap-rows"
        :description "Return a new matrix with rows i1 and i2 swapped."
        :parameters "(mat i1 i2)"
        :category "Matrix Operations"
        :example "(matrix-swap-rows (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)) 0 2)")
      *help-functions*)

(push (make-function-info
        :name "matrix-swap-columns"
        :description "Return a new matrix with columns j1 and j2 swapped."
        :parameters "(mat j1 j2)"
        :category "Matrix Operations"
        :example "(matrix-swap-columns (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)) 0 2)")
      *help-functions*)

(push (make-function-info
        :name "matrix-scale-row"
        :description "Return a new matrix with row i scaled by scalar."
        :parameters "(mat i scalar)"
        :category "Matrix Operations"
        :example "(matrix-scale-row (identity-matrix 3) 0 5)")
      *help-functions*)

(push (make-function-info
        :name "matrix-add-scaled-row"
        :description "Return a new matrix with row target-i += scalar * row source-i."
        :parameters "(mat target-i source-i scalar)"
        :category "Matrix Operations"
        :example "(matrix-add-scaled-row (identity-matrix 3) 1 0 3)")
      *help-functions*)

(push (make-function-info
        :name "matrix-delete-row"
        :description "Return a new matrix with row i removed."
        :parameters "(mat i)"
        :category "Matrix Operations"
        :example "(matrix-delete-row (identity-matrix 3) 1)")
      *help-functions*)

(push (make-function-info
        :name "matrix-delete-column"
        :description "Return a new matrix with column j removed."
        :parameters "(mat j)"
        :category "Matrix Operations"
        :example "(matrix-delete-column (identity-matrix 3) 1)")
      *help-functions*)

(push (make-function-info
        :name "matrix-insert-row"
        :description "Return a new matrix with row inserted at position i."
        :parameters "(mat i row)"
        :category "Matrix Operations"
        :example "(matrix-insert-row (identity-matrix 2) 1 '(5 6))")
      *help-functions*)

(push (make-function-info
        :name "matrix-insert-column"
        :description "Return a new matrix with column inserted at position j."
        :parameters "(mat j col)"
        :category "Matrix Operations"
        :example "(matrix-insert-column (identity-matrix 2) 1 '(5 6))")
      *help-functions*)

(push (make-function-info
        :name "matrix-submatrix"
        :description "Extract submatrix from rows [r1,r2) and columns [c1,c2)."
        :parameters "(mat r1 r2 c1 c2)"
        :category "Matrix Operations"
        :example "(matrix-submatrix (make-matrix 4 4 '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)) 0 2 0 2)")
      *help-functions*)

(push (make-function-info
        :name "matrix-upper-triangular"
        :description "Extract the upper triangular part of a matrix (including diagonal)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-upper-triangular (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-lower-triangular"
        :description "Extract the lower triangular part of a matrix (including diagonal)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-lower-triangular (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-strict-upper"
        :description "Extract the strictly upper triangular part (above diagonal)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-strict-upper (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-strict-lower"
        :description "Extract the strictly lower triangular part (below diagonal)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-strict-lower (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-flatten"
        :description "Flatten a matrix into a single list (row-major order)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-flatten (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-reshape"
        :description "Reshape a matrix to new dimensions n x m (total elements must match)."
        :parameters "(mat n m)"
        :category "Matrix Operations"
        :example "(matrix-reshape (make-matrix 2 3 '(1 2 3 4 5 6)) 3 2)")
      *help-functions*)

;;; ============================================================
;;; Matrix Decompositions
;;; ============================================================

(push (make-function-info
        :name "lu-decomposition"
        :description "Compute LU decomposition. Returns list (L U pivot)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(lu-decomposition (make-matrix 3 3 '(2 1 1 4 3 3 8 7 9)))")
      *help-functions*)

(push (make-function-info
        :name "qr-decomposition"
        :description "Compute QR decomposition. Returns list (Q R)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(qr-decomposition (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)))")
      *help-functions*)

(push (make-function-info
        :name "cholesky-decomposition"
        :description "Compute Cholesky decomposition of a positive definite matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(cholesky-decomposition (make-matrix 2 2 '(4 2 2 3)))")
      *help-functions*)

(push (make-function-info
        :name "svd-decomposition"
        :description "Compute Singular Value Decomposition. Returns list (U S V)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(svd-decomposition (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "eigen-decomposition"
        :description "Compute eigenvalues and eigenvectors. Returns list (eigenvalues eigenvectors)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(eigen-decomposition (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "eigenvalues-of"
        :description "Compute the eigenvalues of a square matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(eigenvalues-of (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "eigenvectors-of"
        :description "Estimate eigenvectors using the SVD approach."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(eigenvectors-of (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "singular-values"
        :description "Extract the singular values of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(singular-values (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "left-singular-vectors"
        :description "Extract the left singular vectors (U matrix) from SVD."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(left-singular-vectors (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "right-singular-vectors"
        :description "Extract the right singular vectors (V matrix) from SVD."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(right-singular-vectors (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-diagonalize"
        :description "Attempt to diagonalize a matrix using eigenvalues."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-diagonalize (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "schur-decomposition"
        :description "Approximate Schur decomposition using QR iteration. Returns list (Q T)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(schur-decomposition (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)))")
      *help-functions*)

(push (make-function-info
        :name "hessenberg-form"
        :description "Reduce a matrix to upper Hessenberg form. Returns list (Q H)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(hessenberg-form (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)))")
      *help-functions*)

(push (make-function-info
        :name "polar-decomposition"
        :description "Compute polar decomposition A = U*P using SVD."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(polar-decomposition (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "spectral-decomposition"
        :description "Compute spectral decomposition of a symmetric matrix as eigenvalue-eigenvector pairs."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(spectral-decomposition (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

;;; ============================================================
;;; Solving Linear Systems
;;; ============================================================

(push (make-function-info
        :name "solve-system"
        :description "Solve the linear system Ax = b."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(solve-system (make-matrix 2 2 '(1 2 3 4)) '(5 6))")
      *help-functions*)

(push (make-function-info
        :name "solve-upper-triangular"
        :description "Solve an upper triangular system Ux = b by back-substitution."
        :parameters "(u b)"
        :category "Matrix Operations"
        :example "(solve-upper-triangular (make-matrix 2 2 '(1 2 0 3)) '(5 6))")
      *help-functions*)

(push (make-function-info
        :name "solve-lower-triangular"
        :description "Solve a lower triangular system Lx = b by forward-substitution."
        :parameters "(l b)"
        :category "Matrix Operations"
        :example "(solve-lower-triangular (make-matrix 2 2 '(1 0 2 3)) '(1 8))")
      *help-functions*)

(push (make-function-info
        :name "gaussian-elimination"
        :description "Perform Gaussian elimination to produce an upper triangular matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(gaussian-elimination (make-matrix 3 3 '(2 1 -1 -3 -1 2 -2 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "gauss-jordan-elimination"
        :description "Perform Gauss-Jordan elimination to reduced row echelon form."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(gauss-jordan-elimination (make-matrix 3 4 '(1 2 3 9 4 5 6 24 7 8 10 41)))")
      *help-functions*)

(push (make-function-info
        :name "row-echelon-form"
        :description "Compute row echelon form of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(row-echelon-form (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)))")
      *help-functions*)

(push (make-function-info
        :name "reduced-row-echelon-form"
        :description "Compute reduced row echelon form (RREF) of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(reduced-row-echelon-form (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)))")
      *help-functions*)

(push (make-function-info
        :name "least-squares-solve"
        :description "Solve the least squares problem min ||Ax - b||^2."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(least-squares-solve (make-matrix 3 2 '(1 1 1 2 1 3)) '(1 2 2))")
      *help-functions*)

(push (make-function-info
        :name "weighted-least-squares"
        :description "Solve weighted least squares with diagonal weight matrix."
        :parameters "(a b w)"
        :category "Matrix Operations"
        :example "(weighted-least-squares (make-matrix 3 2 '(1 1 1 2 1 3)) '(1 2 2) '(1 1 2))")
      *help-functions*)

(push (make-function-info
        :name "tikhonov-regularization"
        :description "Solve Tikhonov-regularized least squares with regularization parameter lambda."
        :parameters "(a b lambda-val)"
        :category "Matrix Operations"
        :example "(tikhonov-regularization (make-matrix 3 2 '(1 1 1 2 1 3)) '(1 2 2) 0.1)")
      *help-functions*)

(push (make-function-info
        :name "cramers-rule-2x2"
        :description "Solve a 2x2 system Ax = b using Cramer's rule."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(cramers-rule-2x2 (make-matrix 2 2 '(2 1 5 3)) '(11 27))")
      *help-functions*)

(push (make-function-info
        :name "cramers-rule-3x3"
        :description "Solve a 3x3 system Ax = b using Cramer's rule."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(cramers-rule-3x3 (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)) '(14 32 53))")
      *help-functions*)

(push (make-function-info
        :name "iterative-jacobi"
        :description "Solve Ax = b using Jacobi iterative method."
        :parameters "(a b &optional tol max-iter)"
        :category "Matrix Operations"
        :example "(iterative-jacobi (make-matrix 3 3 '(10 -1 2 -1 11 -1 2 -1 10)) '(6 25 -11))")
      *help-functions*)

(push (make-function-info
        :name "iterative-gauss-seidel"
        :description "Solve Ax = b using Gauss-Seidel iterative method."
        :parameters "(a b &optional tol max-iter)"
        :category "Matrix Operations"
        :example "(iterative-gauss-seidel (make-matrix 3 3 '(10 -1 2 -1 11 -1 2 -1 10)) '(6 25 -11))")
      *help-functions*)

(push (make-function-info
        :name "conjugate-gradient-solve"
        :description "Solve symmetric positive definite system Ax = b using conjugate gradient method."
        :parameters "(a b &optional tol max-iter)"
        :category "Matrix Operations"
        :example "(conjugate-gradient-solve (make-matrix 2 2 '(4 1 1 3)) '(1 2))")
      *help-functions*)

;;; ============================================================
;;; Norms & Metrics
;;; ============================================================

(push (make-function-info
        :name "vector-norm-1"
        :description "Compute the L1 norm (Manhattan norm) of a vector (list)."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-norm-1 '(1 -2 3))")
      *help-functions*)

(push (make-function-info
        :name "vector-norm-2"
        :description "Compute the L2 norm (Euclidean norm) of a vector (list)."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-norm-2 '(3 4))")
      *help-functions*)

(push (make-function-info
        :name "vector-norm-inf"
        :description "Compute the L-infinity norm (max absolute value) of a vector."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-norm-inf '(1 -5 3))")
      *help-functions*)

(push (make-function-info
        :name "vector-norm-p"
        :description "Compute the Lp norm of a vector."
        :parameters "(v p)"
        :category "Matrix Operations"
        :example "(vector-norm-p '(1 2 3) 3)")
      *help-functions*)

(push (make-function-info
        :name "frobenius-norm"
        :description "Compute the Frobenius norm of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(frobenius-norm (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-norm-1"
        :description "Compute the 1-norm (max column sum of absolute values)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-norm-1 (make-matrix 2 2 '(1 -2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-norm-inf"
        :description "Compute the infinity-norm (max row sum of absolute values)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-norm-inf (make-matrix 2 2 '(1 -2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "spectral-norm"
        :description "Compute the spectral norm (largest singular value)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(spectral-norm (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "condition-number"
        :description "Compute the condition number using ratio of largest to smallest singular values."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(condition-number (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-distance"
        :description "Compute the Frobenius distance between two matrices."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-distance (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "vector-distance"
        :description "Compute the Euclidean distance between two vectors."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-distance '(1 2 3) '(4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "cosine-similarity"
        :description "Compute the cosine similarity between two vectors."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(cosine-similarity '(1 0) '(0 1))")
      *help-functions*)

(push (make-function-info
        :name "angle-between-vectors"
        :description "Compute the angle (in radians) between two vectors."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(angle-between-vectors '(1 0) '(0 1))")
      *help-functions*)

(push (make-function-info
        :name "matrix-sparsity"
        :description "Compute the sparsity ratio (fraction of zero elements)."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-sparsity (identity-matrix 10))")
      *help-functions*)

(push (make-function-info
        :name "residual-norm"
        :description "Compute ||Ax - b|| for solution verification."
        :parameters "(a x b)"
        :category "Matrix Operations"
        :example "(residual-norm (identity-matrix 2) '(1 2) '(1 2))")
      *help-functions*)

;;; ============================================================
;;; Vector Operations
;;; ============================================================

(push (make-function-info
        :name "dot-product"
        :description "Compute the dot product of two vectors (lists)."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(dot-product '(1 2 3) '(4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "cross-product-3d"
        :description "Compute the cross product of two 3D vectors."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(cross-product-3d '(1 0 0) '(0 1 0))")
      *help-functions*)

(push (make-function-info
        :name "outer-product"
        :description "Compute the outer product of two vectors, returning a matrix."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(outer-product '(1 2) '(3 4))")
      *help-functions*)

(push (make-function-info
        :name "vector-add"
        :description "Add two vectors element-wise."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-add '(1 2 3) '(4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "vector-subtract"
        :description "Subtract vector v from vector u element-wise."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-subtract '(4 5 6) '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "vector-scale"
        :description "Multiply a vector by a scalar."
        :parameters "(scalar v)"
        :category "Matrix Operations"
        :example "(vector-scale 3 '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "normalize-vector"
        :description "Normalize a vector to unit length."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(normalize-vector '(3 4))")
      *help-functions*)

(push (make-function-info
        :name "vector-length"
        :description "Compute the length (L2 norm) of a vector."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-length '(3 4))")
      *help-functions*)

(push (make-function-info
        :name "vector-projection"
        :description "Project vector u onto vector v."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-projection '(3 4) '(1 0))")
      *help-functions*)

(push (make-function-info
        :name "scalar-projection"
        :description "Compute the scalar projection of u onto v."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(scalar-projection '(3 4) '(1 0))")
      *help-functions*)

(push (make-function-info
        :name "vector-rejection"
        :description "Compute the rejection of u from v (component perpendicular to v)."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-rejection '(3 4) '(1 0))")
      *help-functions*)

(push (make-function-info
        :name "vector-reflect"
        :description "Reflect vector v across a plane with given normal."
        :parameters "(v normal)"
        :category "Matrix Operations"
        :example "(vector-reflect '(1 1) '(0 1))")
      *help-functions*)

(push (make-function-info
        :name "gram-schmidt"
        :description "Perform Gram-Schmidt orthonormalization on a list of vectors."
        :parameters "(vectors)"
        :category "Matrix Operations"
        :example "(gram-schmidt '((1 1) (1 0)))")
      *help-functions*)

(push (make-function-info
        :name "is-orthogonal-set-p"
        :description "Check if a set of vectors is mutually orthogonal."
        :parameters "(vectors &optional tol)"
        :category "Matrix Operations"
        :example "(is-orthogonal-set-p '((1 0) (0 1)))")
      *help-functions*)

(push (make-function-info
        :name "triple-scalar-product"
        :description "Compute the scalar triple product u . (v x w)."
        :parameters "(u v w)"
        :category "Matrix Operations"
        :example "(triple-scalar-product '(1 0 0) '(0 1 0) '(0 0 1))")
      *help-functions*)

(push (make-function-info
        :name "triple-vector-product"
        :description "Compute the vector triple product u x (v x w)."
        :parameters "(u v w)"
        :category "Matrix Operations"
        :example "(triple-vector-product '(1 0 0) '(0 1 0) '(0 0 1))")
      *help-functions*)

(push (make-function-info
        :name "vector-lerp"
        :description "Linear interpolation between vectors u and v at parameter t."
        :parameters "(u v param-t)"
        :category "Matrix Operations"
        :example "(vector-lerp '(0 0) '(10 10) 0.5)")
      *help-functions*)

(push (make-function-info
        :name "unit-vector"
        :description "Create the ith standard basis vector of dimension n."
        :parameters "(i n)"
        :category "Matrix Operations"
        :example "(unit-vector 0 3)")
      *help-functions*)

(push (make-function-info
        :name "random-unit-vector"
        :description "Generate a random unit vector of dimension n."
        :parameters "(n)"
        :category "Matrix Operations"
        :example "(random-unit-vector 3)")
      *help-functions*)

(push (make-function-info
        :name "vector-rotate-2d"
        :description "Rotate a 2D vector by angle (radians)."
        :parameters "(v angle)"
        :category "Matrix Operations"
        :example "(vector-rotate-2d '(1 0) 1.5708)")
      *help-functions*)

(push (make-function-info
        :name "vector-component"
        :description "Extract component i from vector v."
        :parameters "(v i)"
        :category "Matrix Operations"
        :example "(vector-component '(10 20 30) 1)")
      *help-functions*)

(push (make-function-info
        :name "vector-cross-matrix"
        :description "Create the skew-symmetric cross-product matrix [v]x for a 3D vector."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-cross-matrix '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "vector-element-multiply"
        :description "Element-wise multiplication of two vectors."
        :parameters "(u v)"
        :category "Matrix Operations"
        :example "(vector-element-multiply '(1 2 3) '(4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "vector-cumulative-sum"
        :description "Compute the cumulative sum of a vector."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-cumulative-sum '(1 2 3 4))")
      *help-functions*)

(push (make-function-info
        :name "vector-reverse"
        :description "Reverse the order of elements in a vector."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(vector-reverse '(1 2 3 4))")
      *help-functions*)

;;; ============================================================
;;; Subspace Operations
;;; ============================================================

(push (make-function-info
        :name "null-space-basis"
        :description "Compute an approximate basis for the null space of a matrix using SVD."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(null-space-basis (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "column-space-basis"
        :description "Compute a basis for the column space of a matrix using SVD."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(column-space-basis (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "row-space-basis"
        :description "Compute a basis for the row space of a matrix."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(row-space-basis (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "projection-matrix"
        :description "Compute the orthogonal projection matrix onto the column space of A."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(projection-matrix (make-matrix 3 1 '(1 0 0)))")
      *help-functions*)

(push (make-function-info
        :name "orthogonal-complement"
        :description "Compute the projection matrix onto the orthogonal complement: I - P."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(orthogonal-complement (make-matrix 3 1 '(1 0 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-image-dim"
        :description "Compute the dimension of the image (column space) of a matrix."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-image-dim (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-kernel-dim"
        :description "Compute the dimension of the kernel (null space) of a matrix."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-kernel-dim (zero-matrix 3 3))")
      *help-functions*)

(push (make-function-info
        :name "is-linearly-independent-p"
        :description "Check if a list of vectors is linearly independent."
        :parameters "(vectors)"
        :category "Matrix Operations"
        :example "(is-linearly-independent-p '((1 0 0) (0 1 0) (0 0 1)))")
      *help-functions*)

(push (make-function-info
        :name "span-contains-p"
        :description "Check if a vector lies in the span of the given basis vectors."
        :parameters "(basis vec &optional tol)"
        :category "Matrix Operations"
        :example "(span-contains-p '((1 0) (0 1)) '(3 4))")
      *help-functions*)

(push (make-function-info
        :name "four-fundamental-subspaces"
        :description "Compute the four fundamental subspaces of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(four-fundamental-subspaces (make-matrix 2 3 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "basis-change-matrix"
        :description "Compute the change of basis matrix from old-basis to new-basis."
        :parameters "(old-basis new-basis)"
        :category "Matrix Operations"
        :example "(basis-change-matrix '((1 0) (0 1)) '((1 1) (1 -1)))")
      *help-functions*)

(push (make-function-info
        :name "coordinates-in-basis"
        :description "Express a vector in terms of the given basis vectors."
        :parameters "(vec basis)"
        :category "Matrix Operations"
        :example "(coordinates-in-basis '(3 4) '((1 0) (0 1)))")
      *help-functions*)

(push (make-function-info
        :name "orthogonal-projection-onto"
        :description "Project a vector onto the subspace spanned by the given basis."
        :parameters "(subspace-basis vec)"
        :category "Matrix Operations"
        :example "(orthogonal-projection-onto '((1 0 0)) '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "gram-schmidt-matrix"
        :description "Apply Gram-Schmidt to the columns of a matrix, returning orthonormalized columns."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(gram-schmidt-matrix (make-matrix 3 2 '(1 1 0 1 1 0)))")
      *help-functions*)

(push (make-function-info
        :name "dimension-of-span"
        :description "Compute the dimension of the span of a set of vectors."
        :parameters "(vectors &optional tol)"
        :category "Matrix Operations"
        :example "(dimension-of-span '((1 0 0) (0 1 0) (1 1 0)))")
      *help-functions*)

;;; ============================================================
;;; Transformations & Geometry
;;; ============================================================

(push (make-function-info
        :name "rotation-matrix-2d"
        :description "Create a 2D rotation matrix for given angle (radians)."
        :parameters "(angle)"
        :category "Matrix Operations"
        :example "(rotation-matrix-2d (/ pi 4))")
      *help-functions*)

(push (make-function-info
        :name "rotation-matrix-x"
        :description "Create a 3D rotation matrix around the X axis."
        :parameters "(angle)"
        :category "Matrix Operations"
        :example "(rotation-matrix-x (/ pi 2))")
      *help-functions*)

(push (make-function-info
        :name "rotation-matrix-y"
        :description "Create a 3D rotation matrix around the Y axis."
        :parameters "(angle)"
        :category "Matrix Operations"
        :example "(rotation-matrix-y (/ pi 2))")
      *help-functions*)

(push (make-function-info
        :name "rotation-matrix-z"
        :description "Create a 3D rotation matrix around the Z axis."
        :parameters "(angle)"
        :category "Matrix Operations"
        :example "(rotation-matrix-z (/ pi 2))")
      *help-functions*)

(push (make-function-info
        :name "scaling-matrix-2d"
        :description "Create a 2D scaling matrix."
        :parameters "(sx sy)"
        :category "Matrix Operations"
        :example "(scaling-matrix-2d 2 3)")
      *help-functions*)

(push (make-function-info
        :name "scaling-matrix-3d"
        :description "Create a 3D scaling matrix."
        :parameters "(sx sy sz)"
        :category "Matrix Operations"
        :example "(scaling-matrix-3d 2 3 4)")
      *help-functions*)

(push (make-function-info
        :name "translation-matrix-3d"
        :description "Create a 4x4 homogeneous translation matrix."
        :parameters "(tx ty tz)"
        :category "Matrix Operations"
        :example "(translation-matrix-3d 1 2 3)")
      *help-functions*)

(push (make-function-info
        :name "reflection-matrix-2d"
        :description "Create a 2D reflection matrix across a line at the given angle from x-axis."
        :parameters "(angle)"
        :category "Matrix Operations"
        :example "(reflection-matrix-2d (/ pi 4))")
      *help-functions*)

(push (make-function-info
        :name "shear-matrix-2d"
        :description "Create a 2D shear matrix."
        :parameters "(kx ky)"
        :category "Matrix Operations"
        :example "(shear-matrix-2d 0.5 0)")
      *help-functions*)

(push (make-function-info
        :name "householder-matrix"
        :description "Create a Householder reflection matrix: H = I - 2*v*v^T/||v||^2."
        :parameters "(v)"
        :category "Matrix Operations"
        :example "(householder-matrix '(1 1))")
      *help-functions*)

(push (make-function-info
        :name "givens-rotation-matrix"
        :description "Create an n x n Givens rotation matrix rotating in the (i,j) plane."
        :parameters "(n i j angle)"
        :category "Matrix Operations"
        :example "(givens-rotation-matrix 3 0 1 (/ pi 4))")
      *help-functions*)

(push (make-function-info
        :name "rodrigues-rotation"
        :description "Create a 3D rotation matrix using Rodrigues' rotation formula."
        :parameters "(axis angle)"
        :category "Matrix Operations"
        :example "(rodrigues-rotation '(0 0 1) (/ pi 4))")
      *help-functions*)

(push (make-function-info
        :name "look-at-matrix"
        :description "Create a look-at view matrix from eye position, target, and up vector."
        :parameters "(eye target up)"
        :category "Matrix Operations"
        :example "(look-at-matrix '(0 0 5) '(0 0 0) '(0 1 0))")
      *help-functions*)

(push (make-function-info
        :name "perspective-projection-matrix"
        :description "Create a perspective projection matrix. fov in radians."
        :parameters "(fov aspect near far)"
        :category "Matrix Operations"
        :example "(perspective-projection-matrix 1.047 1.333 0.1 100)")
      *help-functions*)

(push (make-function-info
        :name "euler-to-rotation"
        :description "Convert Euler angles (Z-Y-X convention) to a 3x3 rotation matrix."
        :parameters "(alpha beta gamma)"
        :category "Matrix Operations"
        :example "(euler-to-rotation 0.1 0.2 0.3)")
      *help-functions*)

(push (make-function-info
        :name "affine-transform"
        :description "Apply an affine transformation: result = mat * point + vec."
        :parameters "(mat vec point)"
        :category "Matrix Operations"
        :example "(affine-transform (identity-matrix 3) '(1 2 3) '(0 0 0))")
      *help-functions*)

(push (make-function-info
        :name "apply-transformation"
        :description "Apply a transformation matrix to a list of point vectors."
        :parameters "(transform-mat points)"
        :category "Matrix Operations"
        :example "(apply-transformation (rotation-matrix-2d (/ pi 2)) '((1 0) (0 1)))")
      *help-functions*)

(push (make-function-info
        :name "compose-transformations"
        :description "Compose two transformation matrices (multiply t1 * t2)."
        :parameters "(t1 t2)"
        :category "Matrix Operations"
        :example "(compose-transformations (rotation-matrix-2d 0.5) (rotation-matrix-2d 0.5))")
      *help-functions*)

(push (make-function-info
        :name "homogeneous-coordinates"
        :description "Convert 3D points to homogeneous coordinates (append 1)."
        :parameters "(points)"
        :category "Matrix Operations"
        :example "(homogeneous-coordinates '((1 2 3) (4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "cartesian-from-homogeneous"
        :description "Convert homogeneous coordinates back to Cartesian by dividing by w."
        :parameters "(hpoints)"
        :category "Matrix Operations"
        :example "(cartesian-from-homogeneous '((2 4 6 2) (3 6 9 3)))")
      *help-functions*)

;;; ============================================================
;;; Statistical Matrix Operations
;;; ============================================================

(push (make-function-info
        :name "covariance-matrix"
        :description "Compute the sample covariance matrix of data (rows = observations, cols = variables)."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(covariance-matrix (make-matrix 4 2 '(1 2 3 4 5 6 7 8)))")
      *help-functions*)

(push (make-function-info
        :name "correlation-matrix"
        :description "Compute the correlation matrix from data."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(correlation-matrix (make-matrix 4 2 '(1 2 3 4 5 6 7 8)))")
      *help-functions*)

(push (make-function-info
        :name "mean-vector"
        :description "Compute the mean of each column of a data matrix."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(mean-vector (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "center-matrix"
        :description "Center a data matrix by subtracting column means."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(center-matrix (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "standardize-matrix"
        :description "Standardize a data matrix (zero mean, unit variance per column)."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(standardize-matrix (make-matrix 4 2 '(1 2 3 4 5 6 7 8)))")
      *help-functions*)

(push (make-function-info
        :name "principal-components"
        :description "Compute the first k principal components. Returns (scores loadings eigenvalues)."
        :parameters "(data-matrix k)"
        :category "Matrix Operations"
        :example "(principal-components (make-matrix 4 3 '(1 2 3 4 5 6 7 8 9 10 11 12)) 2)")
      *help-functions*)

(push (make-function-info
        :name "mahalanobis-distance"
        :description "Compute the Mahalanobis distance of point x from a distribution."
        :parameters "(x mean-vec cov-mat)"
        :category "Matrix Operations"
        :example "(mahalanobis-distance '(1 1) '(0 0) (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "whitening-matrix"
        :description "Compute the whitening (ZCA) matrix for the data."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(whitening-matrix (make-matrix 4 2 '(1 2 3 4 5 6 7 8)))")
      *help-functions*)

(push (make-function-info
        :name "scatter-matrix"
        :description "Compute the scatter matrix (unnormalized covariance)."
        :parameters "(data-matrix)"
        :category "Matrix Operations"
        :example "(scatter-matrix (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "explained-variance-ratio"
        :description "Compute the fraction of variance explained by the first k principal components."
        :parameters "(data-matrix k)"
        :category "Matrix Operations"
        :example "(explained-variance-ratio (make-matrix 4 3 '(1 2 3 4 5 6 7 8 9 10 11 12)) 2)")
      *help-functions*)

;;; ============================================================
;;; Additional Utility Functions
;;; ============================================================

(push (make-function-info
        :name "matrix-kronecker-product"
        :description "Compute the Kronecker product A (x) B."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-kronecker-product (identity-matrix 2) (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-direct-sum"
        :description "Compute the direct sum of matrices A and B (block diagonal)."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-direct-sum (identity-matrix 2) (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-vec"
        :description "Vectorize a matrix by stacking columns into a single list."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-vec (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-sum-all"
        :description "Sum all elements of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-sum-all (ones-matrix 3 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-max-element"
        :description "Find the maximum element in a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-max-element (make-matrix 2 2 '(1 5 3 2)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-min-element"
        :description "Find the minimum element in a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-min-element (make-matrix 2 2 '(1 5 3 2)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-abs-max"
        :description "Find the maximum absolute value element in a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-abs-max (make-matrix 2 2 '(-5 3 1 -2)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-apply"
        :description "Apply a function to every element of a matrix."
        :parameters "(func mat)"
        :category "Matrix Operations"
        :example "(matrix-apply #'sqrt (make-matrix 2 2 '(1 4 9 16)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-map-rows"
        :description "Apply a function to each row of a matrix, returning a list of results."
        :parameters "(func mat)"
        :category "Matrix Operations"
        :example "(matrix-map-rows #'(lambda (r) (apply #'+ r)) (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-map-columns"
        :description "Apply a function to each column of a matrix, returning a list of results."
        :parameters "(func mat)"
        :category "Matrix Operations"
        :example "(matrix-map-columns #'(lambda (c) (apply #'+ c)) (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-column-sums"
        :description "Compute the sum of each column."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-column-sums (ones-matrix 3 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-row-sums"
        :description "Compute the sum of each row."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-row-sums (ones-matrix 3 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-column-means"
        :description "Compute the mean of each column."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-column-means (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-row-means"
        :description "Compute the mean of each row."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-row-means (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-stack-vertical"
        :description "Stack two matrices vertically (concatenate rows)."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-stack-vertical (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-stack-horizontal"
        :description "Stack two matrices horizontally (concatenate columns)."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-stack-horizontal (identity-matrix 2) (ones-matrix 2 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-repmat"
        :description "Tile a matrix nr times vertically and nc times horizontally."
        :parameters "(mat nr nc)"
        :category "Matrix Operations"
        :example "(matrix-repmat (identity-matrix 2) 2 3)")
      *help-functions*)

(push (make-function-info
        :name "matrix-minor"
        :description "Compute the (i,j) minor of a matrix."
        :parameters "(mat i j)"
        :category "Matrix Operations"
        :example "(matrix-minor (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)) 0 0)")
      *help-functions*)

(push (make-function-info
        :name "matrix-cofactor"
        :description "Compute the (i,j) cofactor of a matrix."
        :parameters "(mat i j)"
        :category "Matrix Operations"
        :example "(matrix-cofactor (make-matrix 3 3 '(1 2 3 4 5 6 7 8 10)) 0 0)")
      *help-functions*)

(push (make-function-info
        :name "matrix-adjugate"
        :description "Compute the adjugate (classical adjoint) of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-adjugate (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-pseudoinverse"
        :description "Compute the Moore-Penrose pseudoinverse using SVD."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-pseudoinverse (make-matrix 3 2 '(1 2 3 4 5 6)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-exp-pade"
        :description "Approximate the matrix exponential using Pade approximation."
        :parameters "(mat &optional order)"
        :category "Matrix Operations"
        :example "(matrix-exp-pade (make-matrix 2 2 '(0 1 -1 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-log-series"
        :description "Approximate matrix logarithm using series expansion."
        :parameters "(mat &optional terms)"
        :category "Matrix Operations"
        :example "(matrix-log-series (matrix-element-add-scalar (matrix-scale 0.1 (identity-matrix 2)) 1))")
      *help-functions*)

(push (make-function-info
        :name "matrix-sqrt-denman-beavers"
        :description "Compute the matrix square root using the Denman-Beavers iteration."
        :parameters "(mat &optional max-iter tol)"
        :category "Matrix Operations"
        :example "(matrix-sqrt-denman-beavers (make-matrix 2 2 '(4 0 0 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-is-hermitian-p"
        :description "Check if a matrix is Hermitian (equal to its conjugate transpose)."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-is-hermitian-p (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-symmetrize"
        :description "Symmetrize a matrix: (A + A^T) / 2."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-symmetrize (make-matrix 2 2 '(1 3 1 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-skew-symmetrize"
        :description "Skew-symmetrize a matrix: (A - A^T) / 2."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-skew-symmetrize (make-matrix 2 2 '(1 3 1 4)))")
      *help-functions*)

(push (make-function-info
        :name "is-skew-symmetric-p"
        :description "Check if a matrix is skew-symmetric: A^T = -A."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(is-skew-symmetric-p (make-matrix 2 2 '(0 1 -1 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-column-norms"
        :description "Compute the L2 norm of each column."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-column-norms (make-matrix 2 2 '(3 1 4 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-row-norms"
        :description "Compute the L2 norm of each row."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-row-norms (make-matrix 2 2 '(3 4 1 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-normalize-columns"
        :description "Normalize each column of a matrix to unit length."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-normalize-columns (make-matrix 2 2 '(3 1 4 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-normalize-rows"
        :description "Normalize each row of a matrix to unit length."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-normalize-rows (make-matrix 2 2 '(3 4 1 0)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-khatri-rao"
        :description "Compute the Khatri-Rao (column-wise Kronecker) product."
        :parameters "(a b)"
        :category "Matrix Operations"
        :example "(matrix-khatri-rao (identity-matrix 2) (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "matrix-hadamard-power"
        :description "Raise each element of a matrix to the pth power (Hadamard power)."
        :parameters "(mat p)"
        :category "Matrix Operations"
        :example "(matrix-hadamard-power (make-matrix 2 2 '(1 2 3 4)) 2)")
      *help-functions*)

(push (make-function-info
        :name "matrix-entrywise-log"
        :description "Apply natural log to each element of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-entrywise-log (make-matrix 2 2 '(1 2.718 7.389 20.086)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-entrywise-exp"
        :description "Apply exp to each element of a matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-entrywise-exp (make-matrix 2 2 '(0 1 2 3)))")
      *help-functions*)

(push (make-function-info
        :name "display-matrix"
        :description "Pretty-print a matrix with formatted output."
        :parameters "(mat &optional format-str)"
        :category "Matrix Operations"
        :example "(display-matrix (hilbert-matrix 4))")
      *help-functions*)

(push (make-function-info
        :name "matrix-to-list-of-lists"
        :description "Convert a matrix to a list of row lists."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-to-list-of-lists (identity-matrix 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-from-function"
        :description "Create an n x m matrix where element (i,j) = (func i j)."
        :parameters "(n m func)"
        :category "Matrix Operations"
        :example "(matrix-from-function 3 3 #'(lambda (i j) (* i j)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-anti-diagonal"
        :description "Extract the anti-diagonal of a square matrix."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-anti-diagonal (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-polynomial"
        :description "Evaluate a matrix polynomial p(A) = c0*I + c1*A + c2*A^2 + ..."
        :parameters "(mat coeffs)"
        :category "Matrix Operations"
        :example "(matrix-polynomial (identity-matrix 2) '(1 2 3))")
      *help-functions*)

(push (make-function-info
        :name "matrix-commutes-p"
        :description "Check if two matrices commute: AB = BA."
        :parameters "(a b &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-commutes-p (identity-matrix 2) (make-matrix 2 2 '(1 2 3 4)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-similar-p"
        :description "Check if two matrices are similar (same eigenvalues)."
        :parameters "(a b &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-similar-p (identity-matrix 2) (identity-matrix 2))")
      *help-functions*)

(push (make-function-info
        :name "characteristic-polynomial-coeffs"
        :description "Compute coefficients of the characteristic polynomial using Faddeev-LeVerrier."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(characteristic-polynomial-coeffs (make-matrix 2 2 '(2 1 1 2)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-permanent-small"
        :description "Compute the permanent of a small matrix (brute force, up to ~8x8)."
        :parameters "(mat)"
        :category "Matrix Operations"
        :example "(matrix-permanent-small (make-matrix 3 3 '(1 2 3 4 5 6 7 8 9)))")
      *help-functions*)

(push (make-function-info
        :name "matrix-band-width"
        :description "Compute the bandwidth of a matrix."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-band-width (tridiagonal-matrix 5 -1 2 -1))")
      *help-functions*)

(push (make-function-info
        :name "matrix-density"
        :description "Compute the density (fraction of non-zero elements) of a matrix."
        :parameters "(mat &optional tol)"
        :category "Matrix Operations"
        :example "(matrix-density (identity-matrix 10))")
      *help-functions*)
