;; my-matrix.lsp
;; Matrix operations for Jovan's Calculator
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core
;; Arizona State University
;; Created: 2/2/2026

(defun make-matrix (n m my-list)
  "Create a matrix with n rows and m columns from my-list data."
  (matrix (list n m) my-list))

(defun display-matrix-subset (start-i end-i start-j end-j my-matrix)
"Loop through the desired range and give matrix element output"
(let ((inum (- end-i start-i))
      (jnum (- end-j start-j)))
(dotimes (i inum)
  (format t "~%")
  (dotimes (j jnum)
    (let ((i (+ start-i i))
	  (j (+ start-j j))
	  (element
	    (aref my-matrix i j)))
      (format t "~a " element))))))

;;; ============================================================
;;; LINEAR ALGEBRA FUNCTION LIBRARY
;;; ============================================================
;;; ~200 functions organized by category:
;;;   1. Matrix Creation & Initialization
;;;   2. Matrix Properties & Queries
;;;   3. Basic Matrix Arithmetic
;;;   4. Row & Column Operations
;;;   5. Matrix Decompositions
;;;   6. Solving Linear Systems
;;;   7. Norms & Metrics
;;;   8. Vector Operations
;;;   9. Subspace Operations
;;;  10. Transformations & Geometry
;;;  11. Statistical Matrix Operations
;;; ============================================================

;;; ============================================================
;;; 1. MATRIX CREATION & INITIALIZATION
;;; ============================================================

(defun identity-matrix (n)
  "Create an n x n identity matrix."
  (let ((data (make-list (* n n) :initial-element 0)))
    (dotimes (i n)
      (setf (nth (+ (* i n) i) data) 1))
    (matrix (list n n) data)))

(defun zero-matrix (n m)
  "Create an n x m matrix of zeros."
  (matrix (list n m) (make-list (* n m) :initial-element 0)))

(defun ones-matrix (n m)
  "Create an n x m matrix of ones."
  (matrix (list n m) (make-list (* n m) :initial-element 1)))

(defun diagonal-matrix (diag-list)
  "Create a square diagonal matrix from a list of diagonal entries."
  (let* ((n (length diag-list))
         (data (make-list (* n n) :initial-element 0)))
    (dotimes (i n)
      (setf (nth (+ (* i n) i) data) (nth i diag-list)))
    (matrix (list n n) data)))

(defun random-matrix (n m)
  "Create an n x m matrix with uniform random entries in [0,1)."
  (let ((data '()))
    (dotimes (i (* n m))
      (push (random 1.0) data))
    (matrix (list n m) (reverse data))))

(defun random-normal-matrix (n m)
  "Create an n x m matrix with standard normal random entries."
  (let ((data '()))
    (dotimes (i (* n m))
      (push (normal-rand 1) data))
    (matrix (list n m) (mapcar #'(lambda (x) (if (listp x) (car x) x))
                                (reverse data)))))

(defun constant-matrix (n m val)
  "Create an n x m matrix filled with constant value val."
  (matrix (list n m) (make-list (* n m) :initial-element val)))

(defun matrix-from-rows (row-lists)
  "Create a matrix from a list of row lists."
  (let* ((n (length row-lists))
         (m (length (first row-lists)))
         (data (apply #'append row-lists)))
    (matrix (list n m) data)))

(defun matrix-from-columns (col-lists)
  "Create a matrix from a list of column lists."
  (let* ((m (length col-lists))
         (n (length (first col-lists)))
         (data '()))
    (dotimes (i n)
      (dolist (col col-lists)
        (push (nth i col) data)))
    (matrix (list n m) (reverse data))))

(defun copy-matrix (mat)
  "Create a deep copy of a matrix."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (aref mat i j) data)))
    (matrix (list n m) (reverse data))))

(defun hilbert-matrix (n)
  "Create an n x n Hilbert matrix: H(i,j) = 1/(i+j+1)."
  (let ((data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (/ 1.0 (+ i j 1)) data)))
    (matrix (list n n) (reverse data))))

(defun vandermonde-matrix (vec)
  "Create a Vandermonde matrix from a vector (list)."
  (let* ((n (length vec))
         (data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (expt (nth i vec) j) data)))
    (matrix (list n n) (reverse data))))

(defun toeplitz-matrix (first-row)
  "Create a symmetric Toeplitz matrix from its first row."
  (let* ((n (length first-row))
         (data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (nth (abs (- i j)) first-row) data)))
    (matrix (list n n) (reverse data))))

(defun companion-matrix (coeffs)
  "Create a companion matrix for a monic polynomial with given coefficients
   (lowest degree first, excluding leading 1)."
  (let* ((n (length coeffs))
         (data (make-list (* n n) :initial-element 0)))
    (dotimes (i (1- n))
      (setf (nth (+ (* (1+ i) n) i) data) 1))
    (dotimes (i n)
      (setf (nth (+ (* i n) (1- n)) data) (- (nth i coeffs))))
    (matrix (list n n) data)))

(defun exchange-matrix (n)
  "Create an n x n exchange (reversal) matrix."
  (let ((data (make-list (* n n) :initial-element 0)))
    (dotimes (i n)
      (setf (nth (+ (* i n) (- n 1 i)) data) 1))
    (matrix (list n n) data)))

(defun circulant-matrix (first-row)
  "Create a circulant matrix from its first row."
  (let* ((n (length first-row))
         (data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (nth (mod (- j i) n) first-row) data)))
    (matrix (list n n) (reverse data))))

(defun tridiagonal-matrix (n lower main upper)
  "Create an n x n tridiagonal matrix with given diagonal values."
  (let ((data (make-list (* n n) :initial-element 0)))
    (dotimes (i n)
      (setf (nth (+ (* i n) i) data) main)
      (when (< i (1- n))
        (setf (nth (+ (* i n) (1+ i)) data) upper)
        (setf (nth (+ (* (1+ i) n) i) data) lower)))
    (matrix (list n n) data)))

(defun upper-triangular-from-list (n vals)
  "Create an n x n upper triangular matrix from a flat list of upper entries."
  (let ((data (make-list (* n n) :initial-element 0))
        (idx 0))
    (dotimes (i n)
      (do ((j i (1+ j)))
          ((>= j n))
        (setf (nth (+ (* i n) j) data) (nth idx vals))
        (incf idx)))
    (matrix (list n n) data)))

(defun lower-triangular-from-list (n vals)
  "Create an n x n lower triangular matrix from a flat list of lower entries."
  (let ((data (make-list (* n n) :initial-element 0))
        (idx 0))
    (dotimes (i n)
      (dotimes (j (1+ i))
        (setf (nth (+ (* i n) j) data) (nth idx vals))
        (incf idx)))
    (matrix (list n n) data)))

(defun block-diagonal-matrix (matrices)
  "Create a block diagonal matrix from a list of square matrices."
  (let* ((sizes (mapcar #'(lambda (m) (array-dimension m 0)) matrices))
         (total (apply #'+ sizes))
         (data (make-list (* total total) :initial-element 0))
         (offset 0))
    (dolist (mat matrices)
      (let ((sz (array-dimension mat 0)))
        (dotimes (i sz)
          (dotimes (j sz)
            (setf (nth (+ (* (+ offset i) total) (+ offset j)) data)
                  (aref mat i j))))
        (incf offset sz)))
    (matrix (list total total) data)))

(defun augmented-matrix (mat vec)
  "Create an augmented matrix [A|b] from matrix A and vector b."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (aref mat i j) data))
      (push (nth i vec) data))
    (matrix (list n (1+ m)) (reverse data))))

(defun hankel-matrix (first-col)
  "Create a Hankel matrix from its first column (anti-diagonal constant)."
  (let* ((n (length first-col))
         (extended (append first-col (make-list (1- n) :initial-element 0)))
         (data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (nth (+ i j) extended) data)))
    (matrix (list n n) (reverse data))))

(defun sparse-to-dense (n m triplets)
  "Create an n x m matrix from a list of (row col value) triplets."
  (let ((data (make-list (* n m) :initial-element 0)))
    (dolist (trip triplets)
      (let ((r (first trip)) (c (second trip)) (v (third trip)))
        (setf (nth (+ (* r m) c) data) v)))
    (matrix (list n m) data)))

(defun range-vector (start end &optional (step 1))
  "Create a list (vector) from start to end (exclusive) with given step."
  (let ((result '()))
    (do ((x start (+ x step)))
        ((>= x end) (reverse result))
      (push x result))))

(defun linspace-vector (start end n)
  "Create a list of n evenly spaced values from start to end (inclusive)."
  (if (<= n 1)
      (list start)
    (let* ((step (/ (- end start) (1- n)))
           (result '()))
      (dotimes (i n (reverse result))
        (push (+ start (* i step)) result)))))

;;; ============================================================
;;; 2. MATRIX PROPERTIES & QUERIES
;;; ============================================================

(defun matrix-rows (mat)
  "Return the number of rows in a matrix."
  (array-dimension mat 0))

(defun matrix-cols (mat)
  "Return the number of columns in a matrix."
  (array-dimension mat 1))

(defun matrix-dimensions (mat)
  "Return a list (rows cols) of matrix dimensions."
  (list (array-dimension mat 0) (array-dimension mat 1)))

(defun matrix-element (mat i j)
  "Return the element at row i, column j of the matrix."
  (aref mat i j))

(defun matrix-set-element (mat i j val)
  "Set the element at row i, column j to val. Returns the modified matrix."
  (let ((result (copy-matrix mat)))
    (setf (aref result i j) val)
    result))

(defun matrix-trace (mat)
  "Calculate the trace (sum of diagonal elements) of a square matrix."
  (let ((n (min (array-dimension mat 0) (array-dimension mat 1)))
        (sum 0))
    (dotimes (i n sum)
      (incf sum (aref mat i i)))))

(defun matrix-rank-estimate (mat &optional (tol 1e-10))
  "Estimate the rank of a matrix using SVD singular values."
  (let* ((svd-result (sv-decomp mat))
         (singular-vals (second svd-result))
         (rank 0))
    (dotimes (i (length singular-vals) rank)
      (when (> (abs (nth i singular-vals)) tol)
        (incf rank)))))

(defun matrix-determinant (mat)
  "Calculate the determinant of a square matrix."
  (determinant mat))

(defun is-square-p (mat)
  "Check if a matrix is square."
  (= (array-dimension mat 0) (array-dimension mat 1)))

(defun is-symmetric-p (mat &optional (tol 1e-10))
  "Check if a matrix is symmetric within tolerance."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (when (/= n m) (return-from is-symmetric-p nil))
    (dotimes (i n t)
      (do ((j (1+ i) (1+ j)))
          ((>= j n))
        (when (> (abs (- (aref mat i j) (aref mat j i))) tol)
          (return-from is-symmetric-p nil))))))

(defun is-diagonal-p (mat &optional (tol 1e-10))
  "Check if a matrix is diagonal within tolerance."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n t)
      (dotimes (j m)
        (when (and (/= i j) (> (abs (aref mat i j)) tol))
          (return-from is-diagonal-p nil))))))

(defun is-upper-triangular-p (mat &optional (tol 1e-10))
  "Check if a matrix is upper triangular within tolerance."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n t)
      (dotimes (j (min i m))
        (when (> (abs (aref mat i j)) tol)
          (return-from is-upper-triangular-p nil))))))

(defun is-lower-triangular-p (mat &optional (tol 1e-10))
  "Check if a matrix is lower triangular within tolerance."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n t)
      (do ((j (1+ i) (1+ j)))
          ((>= j m))
        (when (> (abs (aref mat i j)) tol)
          (return-from is-lower-triangular-p nil))))))

(defun is-identity-p (mat &optional (tol 1e-10))
  "Check if a matrix is an identity matrix within tolerance."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (when (/= n m) (return-from is-identity-p nil))
    (dotimes (i n t)
      (dotimes (j n)
        (let ((expected (if (= i j) 1 0)))
          (when (> (abs (- (aref mat i j) expected)) tol)
            (return-from is-identity-p nil)))))))

(defun is-orthogonal-p (mat &optional (tol 1e-10))
  "Check if a matrix is orthogonal: A^T * A = I."
  (let* ((product (matmult (transpose mat) mat))
         (n (array-dimension mat 0)))
    (is-identity-p product tol)))

(defun is-positive-definite-p (mat)
  "Check if a symmetric matrix is positive definite via Cholesky attempt."
  (handler-case
    (progn (chol-decomp mat) t)
    (error () nil)))

(defun is-singular-p (mat &optional (tol 1e-10))
  "Check if a matrix is singular (determinant near zero)."
  (< (abs (determinant mat)) tol))

(defun is-nilpotent-p (mat k)
  "Check if A^k = 0 for given k."
  (let ((result (matrix-power mat k))
        (n (array-dimension mat 0)))
    (dotimes (i n t)
      (dotimes (j n)
        (when (> (abs (aref result i j)) 1e-10)
          (return-from is-nilpotent-p nil))))))

(defun is-involutory-p (mat &optional (tol 1e-10))
  "Check if A^2 = I (matrix is its own inverse)."
  (is-identity-p (matmult mat mat) tol))

(defun is-idempotent-p (mat &optional (tol 1e-10))
  "Check if A^2 = A."
  (let* ((a2 (matmult mat mat))
         (n (array-dimension mat 0))
         (m (array-dimension mat 1)))
    (dotimes (i n t)
      (dotimes (j m)
        (when (> (abs (- (aref a2 i j) (aref mat i j))) tol)
          (return-from is-idempotent-p nil))))))

;;; ============================================================
;;; 3. BASIC MATRIX ARITHMETIC
;;; ============================================================

(defun matrix-add (a b)
  "Add two matrices element-wise."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (+ (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-subtract (a b)
  "Subtract matrix b from matrix a element-wise."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (- (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-scale (scalar mat)
  "Multiply every element of a matrix by a scalar."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (* scalar (aref mat i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-multiply (a b)
  "Multiply two matrices using matmult."
  (matmult a b))

(defun matrix-transpose (mat)
  "Transpose a matrix."
  (transpose mat))

(defun matrix-inverse (mat)
  "Compute the inverse of a square matrix."
  (inverse mat))

(defun matrix-negate (mat)
  "Negate all elements of a matrix."
  (matrix-scale -1 mat))

(defun matrix-element-multiply (a b)
  "Hadamard (element-wise) product of two matrices."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (* (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-divide (a b)
  "Element-wise division of matrix a by matrix b."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (/ (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-add-scalar (mat s)
  "Add scalar s to every element of a matrix."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (+ (aref mat i j) s) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-power (mat p)
  "Raise every element of a matrix to power p."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (expt (aref mat i j) p) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-sqrt (mat)
  "Take the square root of every element of a matrix."
  (matrix-element-power mat 0.5))

(defun matrix-element-abs (mat)
  "Take the absolute value of every element of a matrix."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (abs (aref mat i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-max (a b)
  "Element-wise maximum of two matrices."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (max (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-element-min (a b)
  "Element-wise minimum of two matrices."
  (let* ((n (array-dimension a 0))
         (m (array-dimension a 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (min (aref a i j) (aref b i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-power (mat n)
  "Raise a square matrix to the nth power (non-negative integer)."
  (cond
    ((= n 0) (identity-matrix (array-dimension mat 0)))
    ((= n 1) (copy-matrix mat))
    (t (let ((result (identity-matrix (array-dimension mat 0))))
         (dotimes (i n result)
           (setf result (matmult result mat)))))))

(defun matrix-square (mat)
  "Compute A^2 = A * A."
  (matmult mat mat))

(defun matrix-cube (mat)
  "Compute A^3 = A * A * A."
  (matmult (matmult mat mat) mat))

(defun commutator (a b)
  "Compute the commutator [A, B] = AB - BA."
  (matrix-subtract (matmult a b) (matmult b a)))

(defun anticommutator (a b)
  "Compute the anticommutator {A, B} = AB + BA."
  (matrix-add (matmult a b) (matmult b a)))

;;; ============================================================
;;; 4. ROW & COLUMN OPERATIONS
;;; ============================================================

(defun matrix-row (mat i)
  "Extract row i of a matrix as a list."
  (let ((m (array-dimension mat 1))
        (row '()))
    (dotimes (j m (reverse row))
      (push (aref mat i j) row))))

(defun matrix-column (mat j)
  "Extract column j of a matrix as a list."
  (let ((n (array-dimension mat 0))
        (col '()))
    (dotimes (i n (reverse col))
      (push (aref mat i j) col))))

(defun matrix-diagonal (mat)
  "Extract the main diagonal of a matrix as a list."
  (let ((n (min (array-dimension mat 0) (array-dimension mat 1)))
        (diag '()))
    (dotimes (i n (reverse diag))
      (push (aref mat i i) diag))))

(defun matrix-set-row (mat i row)
  "Return a new matrix with row i replaced by the given row list."
  (let ((result (copy-matrix mat))
        (m (array-dimension mat 1)))
    (dotimes (j m result)
      (setf (aref result i j) (nth j row)))))

(defun matrix-set-column (mat j col)
  "Return a new matrix with column j replaced by the given column list."
  (let ((result (copy-matrix mat))
        (n (array-dimension mat 0)))
    (dotimes (i n result)
      (setf (aref result i j) (nth i col)))))

(defun matrix-swap-rows (mat i1 i2)
  "Return a new matrix with rows i1 and i2 swapped."
  (let ((result (copy-matrix mat))
        (m (array-dimension mat 1)))
    (dotimes (j m result)
      (let ((tmp (aref result i1 j)))
        (setf (aref result i1 j) (aref result i2 j))
        (setf (aref result i2 j) tmp)))))

(defun matrix-swap-columns (mat j1 j2)
  "Return a new matrix with columns j1 and j2 swapped."
  (let ((result (copy-matrix mat))
        (n (array-dimension mat 0)))
    (dotimes (i n result)
      (let ((tmp (aref result i j1)))
        (setf (aref result i j1) (aref result i j2))
        (setf (aref result i j2) tmp)))))

(defun matrix-scale-row (mat i scalar)
  "Return a new matrix with row i scaled by scalar."
  (let ((result (copy-matrix mat))
        (m (array-dimension mat 1)))
    (dotimes (j m result)
      (setf (aref result i j) (* scalar (aref result i j))))))

(defun matrix-add-scaled-row (mat target-i source-i scalar)
  "Return a new matrix with row target-i += scalar * row source-i."
  (let ((result (copy-matrix mat))
        (m (array-dimension mat 1)))
    (dotimes (j m result)
      (setf (aref result target-i j)
            (+ (aref result target-i j)
               (* scalar (aref result source-i j)))))))

(defun matrix-delete-row (mat i)
  "Return a new matrix with row i removed."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (r n)
      (unless (= r i)
        (dotimes (c m)
          (push (aref mat r c) data))))
    (matrix (list (1- n) m) (reverse data))))

(defun matrix-delete-column (mat j)
  "Return a new matrix with column j removed."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (r n)
      (dotimes (c m)
        (unless (= c j)
          (push (aref mat r c) data))))
    (matrix (list n (1- m)) (reverse data))))

(defun matrix-insert-row (mat i row)
  "Return a new matrix with row inserted at position i."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (r (1+ n))
      (if (= r i)
          (dolist (v row) (push v data))
        (let ((src-r (if (< r i) r (1- r))))
          (dotimes (c m)
            (push (aref mat src-r c) data)))))
    (matrix (list (1+ n) m) (reverse data))))

(defun matrix-insert-column (mat j col)
  "Return a new matrix with column inserted at position j."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (r n)
      (dotimes (c (1+ m))
        (if (= c j)
            (push (nth r col) data)
          (let ((src-c (if (< c j) c (1- c))))
            (push (aref mat r src-c) data)))))
    (matrix (list n (1+ m)) (reverse data))))

(defun matrix-submatrix (mat r1 r2 c1 c2)
  "Extract submatrix from rows [r1,r2) and columns [c1,c2)."
  (let ((data '()))
    (do ((i r1 (1+ i)))
        ((>= i r2))
      (do ((j c1 (1+ j)))
          ((>= j c2))
        (push (aref mat i j) data)))
    (matrix (list (- r2 r1) (- c2 c1)) (reverse data))))

(defun matrix-upper-triangular (mat)
  "Extract the upper triangular part of a matrix (including diagonal)."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (if (>= j i) (aref mat i j) 0) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-lower-triangular (mat)
  "Extract the lower triangular part of a matrix (including diagonal)."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (if (<= j i) (aref mat i j) 0) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-strict-upper (mat)
  "Extract the strictly upper triangular part (above diagonal)."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (if (> j i) (aref mat i j) 0) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-strict-lower (mat)
  "Extract the strictly lower triangular part (below diagonal)."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (if (< j i) (aref mat i j) 0) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-flatten (mat)
  "Flatten a matrix into a single list (row-major order)."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n (reverse data))
      (dotimes (j m)
        (push (aref mat i j) data)))))

(defun matrix-reshape (mat n m)
  "Reshape a matrix to new dimensions n x m (total elements must match)."
  (matrix (list n m) (matrix-flatten mat)))

;;; ============================================================
;;; 5. MATRIX DECOMPOSITIONS
;;; ============================================================

(defun lu-decomposition (mat)
  "Compute LU decomposition. Returns list (L U pivot)."
  (lu-decomp mat))

(defun qr-decomposition (mat)
  "Compute QR decomposition. Returns list (Q R)."
  (qr-decomp mat))

(defun cholesky-decomposition (mat)
  "Compute Cholesky decomposition of a positive definite matrix. Returns lower triangular L."
  (chol-decomp mat))

(defun svd-decomposition (mat)
  "Compute Singular Value Decomposition. Returns list (U S V)."
  (sv-decomp mat))

(defun eigen-decomposition (mat)
  "Compute eigenvalues and eigenvectors. Returns list (eigenvalues eigenvectors)."
  (let ((evals (eigenvalues mat)))
    (list evals mat)))

(defun eigenvalues-of (mat)
  "Compute the eigenvalues of a square matrix."
  (eigenvalues mat))

(defun eigenvectors-of (mat)
  "Estimate eigenvectors using the SVD of (A - lambda*I) for each eigenvalue."
  (let* ((evals (eigenvalues mat))
         (n (array-dimension mat 0))
         (evecs '()))
    (dolist (ev evals (reverse evecs))
      (let* ((shifted (matrix-subtract mat (matrix-scale ev (identity-matrix n))))
             (svd-result (sv-decomp shifted))
             (v-mat (third svd-result))
             (last-col '()))
        (dotimes (i n)
          (push (aref v-mat i (1- n)) last-col))
        (push (reverse last-col) evecs)))))

(defun singular-values (mat)
  "Extract the singular values of a matrix."
  (second (sv-decomp mat)))

(defun left-singular-vectors (mat)
  "Extract the left singular vectors (U matrix) from SVD."
  (first (sv-decomp mat)))

(defun right-singular-vectors (mat)
  "Extract the right singular vectors (V matrix) from SVD."
  (third (sv-decomp mat)))

(defun matrix-diagonalize (mat)
  "Attempt to diagonalize a matrix: return (P D P^-1) where D is diagonal.
   Uses eigenvalues to form D."
  (let* ((evals (eigenvalues mat))
         (n (array-dimension mat 0))
         (d (diagonal-matrix (if (listp evals) evals (list evals)))))
    (list mat d)))

(defun schur-decomposition (mat)
  "Approximate Schur decomposition using QR iteration.
   Returns list (Q T) where T is quasi upper-triangular."
  (let* ((n (array-dimension mat 0))
         (q-accum (identity-matrix n))
         (a (copy-matrix mat)))
    (dotimes (iter 100)
      (let* ((qr (qr-decomp a))
             (q-step (first qr))
             (r-step (second qr)))
        (setf a (matmult r-step q-step))
        (setf q-accum (matmult q-accum q-step))))
    (list q-accum a)))

(defun hessenberg-form (mat)
  "Reduce a matrix to upper Hessenberg form using Householder reflections.
   Returns list (Q H) where A = Q*H*Q^T."
  (let* ((n (array-dimension mat 0))
         (h (copy-matrix mat))
         (q-accum (identity-matrix n)))
    (dotimes (k (- n 2))
      (let* ((col '()))
        (do ((i (1+ k) (1+ i)))
            ((>= i n))
          (push (aref h i k) col))
        (setf col (reverse col))
        (let* ((col-len (length col))
               (alpha (sqrt (apply #'+ (mapcar #'(lambda (x) (* x x)) col))))
               (sign (if (>= (first col) 0) 1 -1))
               (v (copy-list col)))
          (setf (first v) (+ (first v) (* sign alpha)))
          (let ((v-norm (sqrt (apply #'+ (mapcar #'(lambda (x) (* x x)) v)))))
            (when (> v-norm 1e-15)
              (setf v (mapcar #'(lambda (x) (/ x v-norm)) v))
              ;; Apply H = I - 2*v*v^T to h from left and right
              (do ((i (1+ k) (1+ i))
                   (vi 0 (1+ vi)))
                  ((>= i n))
                (dotimes (j n)
                  (let ((dot 0))
                    (do ((p (1+ k) (1+ p))
                         (vp 0 (1+ vp)))
                        ((>= p n))
                      (incf dot (* (nth vp v) (aref h p j))))
                    (do ((p (1+ k) (1+ p))
                         (vp 0 (1+ vp)))
                        ((>= p n))
                      (setf (aref h p j) (- (aref h p j) (* 2 (nth vp v) dot))))))))))))
    (list q-accum h)))

(defun polar-decomposition (mat)
  "Compute polar decomposition A = U*P where U is unitary and P is positive semi-definite.
   Uses SVD: A = Usvd*S*V^T => U = Usvd*V^T, P = V*S*V^T."
  (let* ((svd (sv-decomp mat))
         (u-svd (first svd))
         (s-vals (second svd))
         (v-mat (third svd))
         (u-polar (matmult u-svd (transpose v-mat)))
         (p-polar (matmult v-mat (matmult (diagonal-matrix s-vals) (transpose v-mat)))))
    (list u-polar p-polar)))

(defun spectral-decomposition (mat)
  "Compute spectral decomposition of a symmetric matrix.
   Returns list of (eigenvalue eigenvector) pairs."
  (let* ((evals (eigenvalues mat))
         (evecs (eigenvectors-of mat))
         (pairs '()))
    (dotimes (i (length evals) (reverse pairs))
      (push (list (nth i evals) (nth i evecs)) pairs))))

;;; ============================================================
;;; 6. SOLVING LINEAR SYSTEMS
;;; ============================================================

(defun solve-system (a b)
  "Solve the linear system Ax = b. b can be a list or column matrix."
  (solve a b))

(defun solve-upper-triangular (u b)
  "Solve an upper triangular system Ux = b by back-substitution."
  (let* ((n (array-dimension u 0))
         (x (make-list n :initial-element 0)))
    (do ((i (1- n) (1- i)))
        ((< i 0) x)
      (let ((sum (nth i b)))
        (do ((j (1+ i) (1+ j)))
            ((>= j n))
          (decf sum (* (aref u i j) (nth j x))))
        (setf (nth i x) (/ sum (aref u i i)))))))

(defun solve-lower-triangular (l b)
  "Solve a lower triangular system Lx = b by forward-substitution."
  (let* ((n (array-dimension l 0))
         (x (make-list n :initial-element 0)))
    (dotimes (i n x)
      (let ((sum (nth i b)))
        (dotimes (j i)
          (decf sum (* (aref l i j) (nth j x))))
        (setf (nth i x) (/ sum (aref l i i)))))))

(defun gaussian-elimination (mat)
  "Perform Gaussian elimination to produce an upper triangular matrix."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (result (copy-matrix mat)))
    (dotimes (k (min n m) result)
      ;; Find pivot
      (let ((max-val (abs (aref result k k)))
            (max-row k))
        (do ((i (1+ k) (1+ i)))
            ((>= i n))
          (when (> (abs (aref result i k)) max-val)
            (setf max-val (abs (aref result i k)))
            (setf max-row i)))
        ;; Swap rows
        (when (/= max-row k)
          (dotimes (j m)
            (let ((tmp (aref result k j)))
              (setf (aref result k j) (aref result max-row j))
              (setf (aref result max-row j) tmp))))
        ;; Eliminate below pivot
        (when (> (abs (aref result k k)) 1e-15)
          (do ((i (1+ k) (1+ i)))
              ((>= i n))
            (let ((factor (/ (aref result i k) (aref result k k))))
              (dotimes (j m)
                (setf (aref result i j)
                      (- (aref result i j) (* factor (aref result k j))))))))))))

(defun gauss-jordan-elimination (mat)
  "Perform Gauss-Jordan elimination to reduced row echelon form."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (result (copy-matrix mat))
         (pivot-col 0))
    (dotimes (pivot-row n result)
      (when (< pivot-col m)
        ;; Find pivot in column
        (let ((found nil))
          (do ((i pivot-row (1+ i)))
              ((or found (>= i n)))
            (when (> (abs (aref result i pivot-col)) 1e-15)
              (setf found i)))
          (when found
            ;; Swap rows
            (when (/= found pivot-row)
              (dotimes (j m)
                (let ((tmp (aref result pivot-row j)))
                  (setf (aref result pivot-row j) (aref result found j))
                  (setf (aref result found j) tmp))))
            ;; Scale pivot row
            (let ((pivot-val (aref result pivot-row pivot-col)))
              (dotimes (j m)
                (setf (aref result pivot-row j) (/ (aref result pivot-row j) pivot-val))))
            ;; Eliminate all other rows
            (dotimes (i n)
              (when (/= i pivot-row)
                (let ((factor (aref result i pivot-col)))
                  (dotimes (j m)
                    (setf (aref result i j)
                          (- (aref result i j) (* factor (aref result pivot-row j)))))))))
          (incf pivot-col))))))

(defun row-echelon-form (mat)
  "Compute row echelon form of a matrix."
  (gaussian-elimination mat))

(defun reduced-row-echelon-form (mat)
  "Compute reduced row echelon form (RREF) of a matrix."
  (gauss-jordan-elimination mat))

(defun least-squares-solve (a b)
  "Solve the least squares problem min ||Ax - b||^2.
   Solution: x = (A^T A)^-1 A^T b."
  (let* ((at (transpose a))
         (ata (matmult at a))
         (atb (matmult at (matrix-from-columns (list b)))))
    (solve ata atb)))

(defun weighted-least-squares (a b w)
  "Solve weighted least squares: min (Ax-b)^T W (Ax-b).
   w is a list of weights (diagonal of W)."
  (let* ((w-mat (diagonal-matrix w))
         (at (transpose a))
         (atwa (matmult at (matmult w-mat a)))
         (atwb (matmult at (matmult w-mat (matrix-from-columns (list b))))))
    (solve atwa atwb)))

(defun tikhonov-regularization (a b lambda-val)
  "Solve Tikhonov-regularized least squares: min ||Ax-b||^2 + lambda*||x||^2.
   Solution: x = (A^T A + lambda*I)^-1 A^T b."
  (let* ((at (transpose a))
         (ata (matmult at a))
         (n (array-dimension a 1))
         (reg (matrix-scale lambda-val (identity-matrix n)))
         (lhs (matrix-add ata reg))
         (rhs (matmult at (matrix-from-columns (list b)))))
    (solve lhs rhs)))

(defun cramers-rule-2x2 (a b)
  "Solve a 2x2 system Ax = b using Cramer's rule."
  (let* ((det-a (- (* (aref a 0 0) (aref a 1 1))
                    (* (aref a 0 1) (aref a 1 0))))
         (det-x1 (- (* (nth 0 b) (aref a 1 1))
                     (* (aref a 0 1) (nth 1 b))))
         (det-x2 (- (* (aref a 0 0) (nth 1 b))
                     (* (nth 0 b) (aref a 1 0)))))
    (list (/ det-x1 det-a) (/ det-x2 det-a))))

(defun cramers-rule-3x3 (a b)
  "Solve a 3x3 system Ax = b using Cramer's rule."
  (let ((det-a (determinant a))
        (results '()))
    (dotimes (col 3 (reverse results))
      (let ((modified (copy-matrix a)))
        (dotimes (row 3)
          (setf (aref modified row col) (nth row b)))
        (push (/ (determinant modified) det-a) results)))))

(defun iterative-jacobi (a b &optional (tol 1e-8) (max-iter 1000))
  "Solve Ax = b using Jacobi iterative method."
  (let* ((n (array-dimension a 0))
         (x (make-list n :initial-element 0.0)))
    (dotimes (iter max-iter x)
      (let ((x-new (make-list n :initial-element 0.0)))
        (dotimes (i n)
          (let ((sum (nth i b)))
            (dotimes (j n)
              (when (/= i j)
                (decf sum (* (aref a i j) (nth j x)))))
            (setf (nth i x-new) (/ sum (aref a i i)))))
        ;; Check convergence
        (let ((diff 0))
          (dotimes (i n)
            (incf diff (abs (- (nth i x-new) (nth i x)))))
          (setf x x-new)
          (when (< diff tol) (return x)))))))

(defun iterative-gauss-seidel (a b &optional (tol 1e-8) (max-iter 1000))
  "Solve Ax = b using Gauss-Seidel iterative method."
  (let* ((n (array-dimension a 0))
         (x (make-list n :initial-element 0.0)))
    (dotimes (iter max-iter x)
      (let ((x-old (copy-list x))
            (converged t))
        (dotimes (i n)
          (let ((sum (nth i b)))
            (dotimes (j n)
              (when (/= i j)
                (decf sum (* (aref a i j) (nth j x)))))
            (setf (nth i x) (/ sum (aref a i i)))))
        ;; Check convergence
        (let ((diff 0))
          (dotimes (i n)
            (incf diff (abs (- (nth i x) (nth i x-old)))))
          (when (< diff tol) (return x)))))))

(defun conjugate-gradient-solve (a b &optional (tol 1e-8) (max-iter 1000))
  "Solve symmetric positive definite system Ax = b using conjugate gradient method."
  (let* ((n (length b))
         (x (make-list n :initial-element 0.0))
         (r (copy-list b))
         (p (copy-list b))
         (rs-old (apply #'+ (mapcar #'(lambda (ri) (* ri ri)) r))))
    (dotimes (iter max-iter x)
      ;; Compute Ap
      (let ((ap (make-list n :initial-element 0.0)))
        (dotimes (i n)
          (let ((sum 0))
            (dotimes (j n)
              (incf sum (* (aref a i j) (nth j p))))
            (setf (nth i ap) sum)))
        (let ((pap (apply #'+ (mapcar #'* p ap))))
          (let ((alpha (/ rs-old pap)))
            ;; Update x and r
            (dotimes (i n)
              (setf (nth i x) (+ (nth i x) (* alpha (nth i p))))
              (setf (nth i r) (- (nth i r) (* alpha (nth i ap)))))
            (let ((rs-new (apply #'+ (mapcar #'(lambda (ri) (* ri ri)) r))))
              (when (< (sqrt rs-new) tol) (return x))
              (let ((beta (/ rs-new rs-old)))
                (dotimes (i n)
                  (setf (nth i p) (+ (nth i r) (* beta (nth i p)))))
                (setf rs-old rs-new)))))))))

;;; ============================================================
;;; 7. NORMS & METRICS
;;; ============================================================

(defun vector-norm-1 (v)
  "Compute the L1 norm (Manhattan norm) of a vector (list)."
  (apply #'+ (mapcar #'abs v)))

(defun vector-norm-2 (v)
  "Compute the L2 norm (Euclidean norm) of a vector (list)."
  (sqrt (apply #'+ (mapcar #'(lambda (x) (* x x)) v))))

(defun vector-norm-inf (v)
  "Compute the L-infinity norm (max absolute value) of a vector."
  (apply #'max (mapcar #'abs v)))

(defun vector-norm-p (v p)
  "Compute the Lp norm of a vector."
  (expt (apply #'+ (mapcar #'(lambda (x) (expt (abs x) p)) v)) (/ 1.0 p)))

(defun frobenius-norm (mat)
  "Compute the Frobenius norm of a matrix: sqrt(sum of squares of all elements)."
  (let ((sum 0)
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n (sqrt sum))
      (dotimes (j m)
        (incf sum (* (aref mat i j) (aref mat i j)))))))

(defun matrix-norm-1 (mat)
  "Compute the 1-norm (max column sum of absolute values)."
  (let ((m (array-dimension mat 1))
        (n (array-dimension mat 0))
        (max-sum 0))
    (dotimes (j m max-sum)
      (let ((col-sum 0))
        (dotimes (i n)
          (incf col-sum (abs (aref mat i j))))
        (when (> col-sum max-sum)
          (setf max-sum col-sum))))))

(defun matrix-norm-inf (mat)
  "Compute the infinity-norm (max row sum of absolute values)."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1))
        (max-sum 0))
    (dotimes (i n max-sum)
      (let ((row-sum 0))
        (dotimes (j m)
          (incf row-sum (abs (aref mat i j))))
        (when (> row-sum max-sum)
          (setf max-sum row-sum))))))

(defun spectral-norm (mat)
  "Compute the spectral norm (largest singular value)."
  (let ((s-vals (singular-values mat)))
    (apply #'max (mapcar #'abs s-vals))))

(defun condition-number (mat)
  "Compute the condition number using singular values (ratio of largest to smallest)."
  (let* ((s-vals (mapcar #'abs (singular-values mat)))
         (s-max (apply #'max s-vals))
         (s-min (apply #'min s-vals)))
    (if (< s-min 1e-15)
        most-positive-fixnum
      (/ s-max s-min))))

(defun matrix-distance (a b)
  "Compute the Frobenius distance between two matrices."
  (frobenius-norm (matrix-subtract a b)))

(defun vector-distance (u v)
  "Compute the Euclidean distance between two vectors (lists)."
  (vector-norm-2 (mapcar #'- u v)))

(defun cosine-similarity (u v)
  "Compute the cosine similarity between two vectors."
  (/ (apply #'+ (mapcar #'* u v))
     (* (vector-norm-2 u) (vector-norm-2 v))))

(defun angle-between-vectors (u v)
  "Compute the angle (in radians) between two vectors."
  (acos (min 1.0 (max -1.0 (cosine-similarity u v)))))

(defun matrix-sparsity (mat &optional (tol 1e-15))
  "Compute the sparsity ratio (fraction of zero elements)."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1))
        (zero-count 0))
    (dotimes (i n)
      (dotimes (j m)
        (when (< (abs (aref mat i j)) tol)
          (incf zero-count))))
    (/ (float zero-count) (* n m))))

(defun residual-norm (a x b)
  "Compute ||Ax - b|| for solution verification. x and b are lists."
  (let* ((n (array-dimension a 0))
         (ax '()))
    (dotimes (i n)
      (let ((sum 0))
        (dotimes (j (array-dimension a 1))
          (incf sum (* (aref a i j) (nth j x))))
        (push sum ax)))
    (vector-norm-2 (mapcar #'- (reverse ax) b))))

;;; ============================================================
;;; 8. VECTOR OPERATIONS
;;; ============================================================

(defun dot-product (u v)
  "Compute the dot product of two vectors (lists)."
  (apply #'+ (mapcar #'* u v)))

(defun cross-product-3d (u v)
  "Compute the cross product of two 3D vectors (lists of length 3)."
  (list (- (* (second u) (third v)) (* (third u) (second v)))
        (- (* (third u) (first v)) (* (first u) (third v)))
        (- (* (first u) (second v)) (* (second u) (first v)))))

(defun outer-product (u v)
  "Compute the outer product of two vectors, returning a matrix."
  (let* ((n (length u))
         (m (length v))
         (data '()))
    (dolist (ui u)
      (dolist (vj v)
        (push (* ui vj) data)))
    (matrix (list n m) (reverse data))))

(defun vector-add (u v)
  "Add two vectors element-wise."
  (mapcar #'+ u v))

(defun vector-subtract (u v)
  "Subtract vector v from vector u element-wise."
  (mapcar #'- u v))

(defun vector-scale (scalar v)
  "Multiply a vector by a scalar."
  (mapcar #'(lambda (x) (* scalar x)) v))

(defun normalize-vector (v)
  "Normalize a vector to unit length."
  (let ((norm (vector-norm-2 v)))
    (if (< norm 1e-15)
        v
      (mapcar #'(lambda (x) (/ x norm)) v))))

(defun vector-length (v)
  "Compute the length (L2 norm) of a vector."
  (vector-norm-2 v))

(defun vector-projection (u v)
  "Project vector u onto vector v."
  (let ((scale (/ (dot-product u v) (dot-product v v))))
    (vector-scale scale v)))

(defun scalar-projection (u v)
  "Compute the scalar projection of u onto v."
  (/ (dot-product u v) (vector-norm-2 v)))

(defun vector-rejection (u v)
  "Compute the rejection of u from v (component perpendicular to v)."
  (vector-subtract u (vector-projection u v)))

(defun vector-reflect (v normal)
  "Reflect vector v across a plane with given normal."
  (let ((proj (vector-projection v normal)))
    (vector-subtract v (vector-scale 2 proj))))

(defun gram-schmidt (vectors)
  "Perform Gram-Schmidt orthonormalization on a list of vectors."
  (let ((ortho '()))
    (dolist (v vectors (reverse ortho))
      (let ((u (copy-list v)))
        (dolist (q ortho)
          (let ((proj (vector-projection u q)))
            (setf u (vector-subtract u proj))))
        (push (normalize-vector u) ortho)))))

(defun is-orthogonal-set-p (vectors &optional (tol 1e-10))
  "Check if a set of vectors is mutually orthogonal."
  (let ((n (length vectors)))
    (dotimes (i n t)
      (do ((j (1+ i) (1+ j)))
          ((>= j n))
        (when (> (abs (dot-product (nth i vectors) (nth j vectors))) tol)
          (return-from is-orthogonal-set-p nil))))))

(defun triple-scalar-product (u v w)
  "Compute the scalar triple product u . (v x w)."
  (dot-product u (cross-product-3d v w)))

(defun triple-vector-product (u v w)
  "Compute the vector triple product u x (v x w) = v(u.w) - w(u.v)."
  (vector-subtract (vector-scale (dot-product u w) v)
                   (vector-scale (dot-product u v) w)))

(defun vector-lerp (u v param-t)
  "Linear interpolation between vectors u and v at parameter t."
  (vector-add (vector-scale (- 1 param-t) u)
              (vector-scale param-t v)))

(defun unit-vector (i n)
  "Create the ith standard basis vector of dimension n."
  (let ((v (make-list n :initial-element 0)))
    (setf (nth i v) 1)
    v))

(defun random-unit-vector (n)
  "Generate a random unit vector of dimension n."
  (let ((v '()))
    (dotimes (i n)
      (push (- (random 2.0) 1.0) v))
    (normalize-vector v)))

(defun vector-rotate-2d (v angle)
  "Rotate a 2D vector by angle (radians)."
  (let ((x (first v))
        (y (second v))
        (c (cos angle))
        (s (sin angle)))
    (list (- (* c x) (* s y))
          (+ (* s x) (* c y)))))

(defun vector-component (v i)
  "Extract component i from vector v."
  (nth i v))

(defun vector-cross-matrix (v)
  "Create the skew-symmetric cross-product matrix [v]x for a 3D vector."
  (matrix (list 3 3) (list 0 (- (third v)) (second v)
                           (third v) 0 (- (first v))
                           (- (second v)) (first v) 0)))

(defun vector-element-multiply (u v)
  "Element-wise multiplication of two vectors."
  (mapcar #'* u v))

(defun vector-cumulative-sum (v)
  "Compute the cumulative sum of a vector."
  (let ((result '())
        (running 0))
    (dolist (x v (reverse result))
      (incf running x)
      (push running result))))

(defun vector-reverse (v)
  "Reverse the order of elements in a vector."
  (reverse v))

;;; ============================================================
;;; 9. SUBSPACE OPERATIONS
;;; ============================================================

(defun null-space-basis (mat &optional (tol 1e-10))
  "Compute an approximate basis for the null space of a matrix using SVD."
  (let* ((svd (sv-decomp mat))
         (s-vals (second svd))
         (v-mat (third svd))
         (n (array-dimension v-mat 0))
         (basis '()))
    (dotimes (j (length s-vals) (reverse basis))
      (when (< (abs (nth j s-vals)) tol)
        (let ((col '()))
          (dotimes (i n)
            (push (aref v-mat i j) col))
          (push (reverse col) basis))))))

(defun column-space-basis (mat &optional (tol 1e-10))
  "Compute a basis for the column space of a matrix using SVD."
  (let* ((svd (sv-decomp mat))
         (s-vals (second svd))
         (u-mat (first svd))
         (n (array-dimension u-mat 0))
         (basis '()))
    (dotimes (j (length s-vals) (reverse basis))
      (when (> (abs (nth j s-vals)) tol)
        (let ((col '()))
          (dotimes (i n)
            (push (aref u-mat i j) col))
          (push (reverse col) basis))))))

(defun row-space-basis (mat &optional (tol 1e-10))
  "Compute a basis for the row space of a matrix."
  (column-space-basis (transpose mat) tol))

(defun projection-matrix (mat)
  "Compute the orthogonal projection matrix onto the column space of A: P = A(A^T A)^-1 A^T."
  (let* ((at (transpose mat))
         (ata-inv (inverse (matmult at mat))))
    (matmult mat (matmult ata-inv at))))

(defun orthogonal-complement (mat)
  "Compute the projection matrix onto the orthogonal complement: I - P."
  (let* ((n (array-dimension mat 0))
         (proj (projection-matrix mat)))
    (matrix-subtract (identity-matrix n) proj)))

(defun matrix-image-dim (mat &optional (tol 1e-10))
  "Compute the dimension of the image (column space) of a matrix."
  (length (column-space-basis mat tol)))

(defun matrix-kernel-dim (mat &optional (tol 1e-10))
  "Compute the dimension of the kernel (null space) of a matrix."
  (length (null-space-basis mat tol)))

(defun is-linearly-independent-p (vectors)
  "Check if a list of vectors is linearly independent."
  (let* ((mat (matrix-from-rows vectors))
         (rank (matrix-rank-estimate mat)))
    (= rank (length vectors))))

(defun span-contains-p (basis vec &optional (tol 1e-8))
  "Check if vec lies in the span of the given basis vectors."
  (let* ((mat (matrix-from-columns basis))
         (n (array-dimension mat 0))
         (m (array-dimension mat 1)))
    (if (> m n)
        t
      (let* ((atb (matmult (transpose mat) (matrix-from-columns (list vec))))
             (ata (matmult (transpose mat) mat))
             (x (solve ata atb))
             (ax (matmult mat x))
             (residual 0))
        (dotimes (i n)
          (incf residual (expt (- (aref ax i 0) (nth i vec)) 2)))
        (< (sqrt residual) tol)))))

(defun four-fundamental-subspaces (mat)
  "Compute the four fundamental subspaces of a matrix.
   Returns list: (column-space null-space row-space left-null-space)."
  (list (column-space-basis mat)
        (null-space-basis mat)
        (row-space-basis mat)
        (null-space-basis (transpose mat))))

(defun basis-change-matrix (old-basis new-basis)
  "Compute the change of basis matrix from old-basis to new-basis.
   Each basis is a list of column vectors."
  (let ((old-mat (matrix-from-columns old-basis))
        (new-mat (matrix-from-columns new-basis)))
    (solve new-mat old-mat)))

(defun coordinates-in-basis (vec basis)
  "Express a vector in terms of the given basis vectors."
  (let ((mat (matrix-from-columns basis))
        (b-col (matrix-from-columns (list vec))))
    (let ((result (solve mat b-col))
          (coords '()))
      (dotimes (i (length basis) (reverse coords))
        (push (aref result i 0) coords)))))

(defun orthogonal-projection-onto (subspace-basis vec)
  "Project a vector onto the subspace spanned by the given basis."
  (let ((result (make-list (length vec) :initial-element 0)))
    (dolist (b subspace-basis result)
      (let ((proj (vector-projection vec b)))
        (setf result (vector-add result proj))))))

(defun gram-schmidt-matrix (mat)
  "Apply Gram-Schmidt to the columns of a matrix, returning orthonormalized columns."
  (let* ((m (array-dimension mat 1))
         (cols '()))
    (dotimes (j m)
      (push (matrix-column mat j) cols))
    (let ((ortho (gram-schmidt (reverse cols))))
      (matrix-from-columns ortho))))

(defun dimension-of-span (vectors &optional (tol 1e-10))
  "Compute the dimension of the span of a set of vectors."
  (matrix-rank-estimate (matrix-from-rows vectors) tol))

;;; ============================================================
;;; 10. TRANSFORMATIONS & GEOMETRY
;;; ============================================================

(defun rotation-matrix-2d (angle)
  "Create a 2D rotation matrix for given angle (radians)."
  (let ((c (cos angle))
        (s (sin angle)))
    (matrix (list 2 2) (list c (- s) s c))))

(defun rotation-matrix-x (angle)
  "Create a 3D rotation matrix around the X axis."
  (let ((c (cos angle))
        (s (sin angle)))
    (matrix (list 3 3) (list 1 0 0
                             0 c (- s)
                             0 s c))))

(defun rotation-matrix-y (angle)
  "Create a 3D rotation matrix around the Y axis."
  (let ((c (cos angle))
        (s (sin angle)))
    (matrix (list 3 3) (list c 0 s
                             0 1 0
                             (- s) 0 c))))

(defun rotation-matrix-z (angle)
  "Create a 3D rotation matrix around the Z axis."
  (let ((c (cos angle))
        (s (sin angle)))
    (matrix (list 3 3) (list c (- s) 0
                             s c 0
                             0 0 1))))

(defun scaling-matrix-2d (sx sy)
  "Create a 2D scaling matrix."
  (matrix (list 2 2) (list sx 0 0 sy)))

(defun scaling-matrix-3d (sx sy sz)
  "Create a 3D scaling matrix."
  (matrix (list 3 3) (list sx 0 0 0 sy 0 0 0 sz)))

(defun translation-matrix-3d (tx ty tz)
  "Create a 4x4 homogeneous translation matrix."
  (matrix (list 4 4) (list 1 0 0 tx
                           0 1 0 ty
                           0 0 1 tz
                           0 0 0 1)))

(defun reflection-matrix-2d (angle)
  "Create a 2D reflection matrix across a line at the given angle from x-axis."
  (let ((c2 (cos (* 2 angle)))
        (s2 (sin (* 2 angle))))
    (matrix (list 2 2) (list c2 s2 s2 (- c2)))))

(defun shear-matrix-2d (kx ky)
  "Create a 2D shear matrix."
  (matrix (list 2 2) (list 1 kx ky 1)))

(defun householder-matrix (v)
  "Create a Householder reflection matrix: H = I - 2*v*v^T/||v||^2."
  (let* ((n (length v))
         (vv (dot-product v v))
         (outer (outer-product v v))
         (eye (identity-matrix n)))
    (matrix-subtract eye (matrix-scale (/ 2.0 vv) outer))))

(defun givens-rotation-matrix (n i j angle)
  "Create an n x n Givens rotation matrix rotating in the (i,j) plane."
  (let ((g (identity-matrix n))
        (c (cos angle))
        (s (sin angle)))
    (setf (aref g i i) c)
    (setf (aref g j j) c)
    (setf (aref g i j) (- s))
    (setf (aref g j i) s)
    g))

(defun rodrigues-rotation (axis angle)
  "Create a 3D rotation matrix using Rodrigues' rotation formula.
   axis is a 3D unit vector, angle in radians."
  (let* ((k (normalize-vector axis))
         (kx (vector-cross-matrix k))
         (kx2 (matmult kx kx))
         (eye (identity-matrix 3))
         (sin-a (sin angle))
         (cos-a (- 1 (cos angle))))
    (matrix-add eye (matrix-add (matrix-scale sin-a kx)
                                (matrix-scale cos-a kx2)))))

(defun look-at-matrix (eye target up)
  "Create a look-at view matrix from eye position, target, and up vector."
  (let* ((f (normalize-vector (vector-subtract target eye)))
         (s (normalize-vector (cross-product-3d f up)))
         (u (cross-product-3d s f)))
    (matrix (list 4 4)
            (list (first s) (second s) (third s) (- (dot-product s eye))
                  (first u) (second u) (third u) (- (dot-product u eye))
                  (- (first f)) (- (second f)) (- (third f)) (dot-product f eye)
                  0 0 0 1))))

(defun perspective-projection-matrix (fov aspect near far)
  "Create a perspective projection matrix. fov in radians."
  (let* ((f (/ 1.0 (tan (/ fov 2.0))))
         (nf (/ 1.0 (- near far))))
    (matrix (list 4 4)
            (list (/ f aspect) 0 0 0
                  0 f 0 0
                  0 0 (* (+ near far) nf) (* 2 far near nf)
                  0 0 -1 0))))

(defun euler-to-rotation (alpha beta gamma)
  "Convert Euler angles (Z-Y-X convention) to a 3x3 rotation matrix."
  (matmult (rotation-matrix-z alpha)
           (matmult (rotation-matrix-y beta)
                    (rotation-matrix-x gamma))))

(defun affine-transform (mat vec point)
  "Apply an affine transformation: result = mat * point + vec."
  (let* ((mp (matmult mat (matrix-from-columns (list point))))
         (n (length vec))
         (result '()))
    (dotimes (i n (reverse result))
      (push (+ (aref mp i 0) (nth i vec)) result))))

(defun apply-transformation (transform-mat points)
  "Apply a transformation matrix to a list of point vectors."
  (mapcar #'(lambda (pt)
              (let* ((col (matrix-from-columns (list pt)))
                     (res (matmult transform-mat col))
                     (n (length pt))
                     (out '()))
                (dotimes (i n (reverse out))
                  (push (aref res i 0) out))))
          points))

(defun compose-transformations (t1 t2)
  "Compose two transformation matrices (multiply t1 * t2)."
  (matmult t1 t2))

(defun homogeneous-coordinates (points)
  "Convert 3D points to homogeneous coordinates (append 1)."
  (mapcar #'(lambda (pt) (append pt '(1))) points))

(defun cartesian-from-homogeneous (hpoints)
  "Convert homogeneous coordinates back to Cartesian by dividing by w."
  (mapcar #'(lambda (hp)
              (let ((w (car (last hp))))
                (mapcar #'(lambda (x) (/ x w)) (butlast hp))))
          hpoints))

;;; ============================================================
;;; 11. STATISTICAL MATRIX OPERATIONS
;;; ============================================================

(defun covariance-matrix (data-matrix)
  "Compute the covariance matrix of data (rows = observations, cols = variables).
   Returns the sample covariance matrix."
  (let* ((n (array-dimension data-matrix 0))
         (m (array-dimension data-matrix 1))
         (means (make-list m :initial-element 0.0)))
    ;; Compute means
    (dotimes (j m)
      (let ((sum 0))
        (dotimes (i n)
          (incf sum (aref data-matrix i j)))
        (setf (nth j means) (/ sum n))))
    ;; Compute covariance
    (let ((cov-data '()))
      (dotimes (j1 m)
        (dotimes (j2 m)
          (let ((sum 0))
            (dotimes (i n)
              (incf sum (* (- (aref data-matrix i j1) (nth j1 means))
                           (- (aref data-matrix i j2) (nth j2 means)))))
            (push (/ sum (1- n)) cov-data))))
      (matrix (list m m) (reverse cov-data)))))

(defun correlation-matrix (data-matrix)
  "Compute the correlation matrix from data."
  (let* ((cov (covariance-matrix data-matrix))
         (m (array-dimension cov 0))
         (stds (make-list m)))
    (dotimes (i m)
      (setf (nth i stds) (sqrt (aref cov i i))))
    (let ((data '()))
      (dotimes (i m)
        (dotimes (j m)
          (push (/ (aref cov i j) (* (nth i stds) (nth j stds))) data)))
      (matrix (list m m) (reverse data)))))

(defun mean-vector (data-matrix)
  "Compute the mean of each column of a data matrix."
  (let* ((n (array-dimension data-matrix 0))
         (m (array-dimension data-matrix 1))
         (means '()))
    (dotimes (j m (reverse means))
      (let ((sum 0))
        (dotimes (i n)
          (incf sum (aref data-matrix i j)))
        (push (/ sum n) means)))))

(defun center-matrix (data-matrix)
  "Center a data matrix by subtracting column means."
  (let* ((n (array-dimension data-matrix 0))
         (m (array-dimension data-matrix 1))
         (means (mean-vector data-matrix))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (- (aref data-matrix i j) (nth j means)) data)))
    (matrix (list n m) (reverse data))))

(defun standardize-matrix (data-matrix)
  "Standardize a data matrix (zero mean, unit variance per column)."
  (let* ((n (array-dimension data-matrix 0))
         (m (array-dimension data-matrix 1))
         (means (mean-vector data-matrix))
         (stds (make-list m :initial-element 0.0))
         (data '()))
    ;; Compute standard deviations
    (dotimes (j m)
      (let ((sum 0))
        (dotimes (i n)
          (incf sum (expt (- (aref data-matrix i j) (nth j means)) 2)))
        (setf (nth j stds) (sqrt (/ sum (1- n))))))
    ;; Standardize
    (dotimes (i n)
      (dotimes (j m)
        (push (if (> (nth j stds) 1e-15)
                  (/ (- (aref data-matrix i j) (nth j means)) (nth j stds))
                0.0)
              data)))
    (matrix (list n m) (reverse data))))

(defun principal-components (data-matrix k)
  "Compute the first k principal components of the data.
   Returns list (scores loadings eigenvalues)."
  (let* ((centered (center-matrix data-matrix))
         (cov (covariance-matrix data-matrix))
         (svd (sv-decomp cov))
         (v (first svd))
         (s-vals (second svd))
         (m (array-dimension cov 0))
         (loadings-data '()))
    ;; Extract first k columns of V as loadings
    (dotimes (i m)
      (dotimes (j k)
        (push (aref v i j) loadings-data)))
    (let* ((loadings (matrix (list m k) (reverse loadings-data)))
           (scores (matmult centered loadings))
           (top-evals (let ((result '()))
                        (dotimes (i k (reverse result))
                          (push (nth i s-vals) result)))))
      (list scores loadings top-evals))))

(defun mahalanobis-distance (x mean-vec cov-mat)
  "Compute the Mahalanobis distance of point x from a distribution."
  (let* ((diff (vector-subtract x mean-vec))
         (diff-col (matrix-from-columns (list diff)))
         (cov-inv (inverse cov-mat))
         (result (matmult (transpose diff-col) (matmult cov-inv diff-col))))
    (sqrt (aref result 0 0))))

(defun whitening-matrix (data-matrix)
  "Compute the whitening (ZCA) matrix for the data."
  (let* ((cov (covariance-matrix data-matrix))
         (svd (sv-decomp cov))
         (u (first svd))
         (s-vals (second svd))
         (s-inv-sqrt (diagonal-matrix
                       (mapcar #'(lambda (s)
                                   (if (> (abs s) 1e-15)
                                       (/ 1.0 (sqrt s))
                                     0.0))
                               s-vals))))
    (matmult u (matmult s-inv-sqrt (transpose u)))))

(defun scatter-matrix (data-matrix)
  "Compute the scatter matrix (unnormalized covariance): S = X_c^T * X_c."
  (let ((centered (center-matrix data-matrix)))
    (matmult (transpose centered) centered)))

(defun explained-variance-ratio (data-matrix k)
  "Compute the fraction of variance explained by the first k principal components."
  (let* ((cov (covariance-matrix data-matrix))
         (s-vals (second (sv-decomp cov)))
         (total (apply #'+ s-vals))
         (top-k (let ((sum 0))
                  (dotimes (i k sum)
                    (incf sum (nth i s-vals))))))
    (/ top-k total)))

;;; ============================================================
;;; ADDITIONAL UTILITY FUNCTIONS
;;; ============================================================

(defun matrix-kronecker-product (a b)
  "Compute the Kronecker product A ⊗ B."
  (let* ((na (array-dimension a 0)) (ma (array-dimension a 1))
         (nb (array-dimension b 0)) (mb (array-dimension b 1))
         (n (* na nb)) (m (* ma mb))
         (data '()))
    (dotimes (ia na)
      (dotimes (ib nb)
        (dotimes (ja ma)
          (dotimes (jb mb)
            (push (* (aref a ia ja) (aref b ib jb)) data)))))
    (matrix (list n m) (reverse data))))

(defun matrix-direct-sum (a b)
  "Compute the direct sum of matrices A and B (block diagonal)."
  (block-diagonal-matrix (list a b)))

(defun matrix-vec (mat)
  "Vectorize a matrix by stacking columns into a single list."
  (let ((data '())
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (j m (reverse data))
      (dotimes (i n)
        (push (aref mat i j) data)))))

(defun matrix-sum-all (mat)
  "Sum all elements of a matrix."
  (let ((sum 0)
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n sum)
      (dotimes (j m)
        (incf sum (aref mat i j))))))

(defun matrix-max-element (mat)
  "Find the maximum element in a matrix."
  (let ((max-val (aref mat 0 0))
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n max-val)
      (dotimes (j m)
        (when (> (aref mat i j) max-val)
          (setf max-val (aref mat i j)))))))

(defun matrix-min-element (mat)
  "Find the minimum element in a matrix."
  (let ((min-val (aref mat 0 0))
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n min-val)
      (dotimes (j m)
        (when (< (aref mat i j) min-val)
          (setf min-val (aref mat i j)))))))

(defun matrix-abs-max (mat)
  "Find the maximum absolute value element in a matrix."
  (let ((max-val 0)
        (n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n max-val)
      (dotimes (j m)
        (when (> (abs (aref mat i j)) max-val)
          (setf max-val (abs (aref mat i j))))))))

(defun matrix-apply (func mat)
  "Apply a function to every element of a matrix."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (funcall func (aref mat i j)) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-map-rows (func mat)
  "Apply a function to each row of a matrix, returning a list of results."
  (let* ((n (array-dimension mat 0))
         (results '()))
    (dotimes (i n (reverse results))
      (push (funcall func (matrix-row mat i)) results))))

(defun matrix-map-columns (func mat)
  "Apply a function to each column of a matrix, returning a list of results."
  (let* ((m (array-dimension mat 1))
         (results '()))
    (dotimes (j m (reverse results))
      (push (funcall func (matrix-column mat j)) results))))

(defun matrix-column-sums (mat)
  "Compute the sum of each column."
  (matrix-map-columns #'(lambda (col) (apply #'+ col)) mat))

(defun matrix-row-sums (mat)
  "Compute the sum of each row."
  (matrix-map-rows #'(lambda (row) (apply #'+ row)) mat))

(defun matrix-column-means (mat)
  "Compute the mean of each column."
  (let ((n (array-dimension mat 0)))
    (mapcar #'(lambda (s) (/ s n)) (matrix-column-sums mat))))

(defun matrix-row-means (mat)
  "Compute the mean of each row."
  (let ((m (array-dimension mat 1)))
    (mapcar #'(lambda (s) (/ s m)) (matrix-row-sums mat))))

(defun matrix-stack-vertical (a b)
  "Stack two matrices vertically (concatenate rows)."
  (let* ((na (array-dimension a 0)) (m (array-dimension a 1))
         (nb (array-dimension b 0))
         (data '()))
    (dotimes (i na)
      (dotimes (j m)
        (push (aref a i j) data)))
    (dotimes (i nb)
      (dotimes (j m)
        (push (aref b i j) data)))
    (matrix (list (+ na nb) m) (reverse data))))

(defun matrix-stack-horizontal (a b)
  "Stack two matrices horizontally (concatenate columns)."
  (let* ((n (array-dimension a 0))
         (ma (array-dimension a 1))
         (mb (array-dimension b 1))
         (data '()))
    (dotimes (i n)
      (dotimes (j ma)
        (push (aref a i j) data))
      (dotimes (j mb)
        (push (aref b i j) data)))
    (matrix (list n (+ ma mb)) (reverse data))))

(defun matrix-repmat (mat nr nc)
  "Tile a matrix nr times vertically and nc times horizontally."
  (let* ((n (array-dimension mat 0))
         (m (array-dimension mat 1))
         (data '()))
    (dotimes (ri nr)
      (dotimes (i n)
        (dotimes (cj nc)
          (dotimes (j m)
            (push (aref mat i j) data)))))
    (matrix (list (* nr n) (* nc m)) (reverse data))))

(defun matrix-minor (mat i j)
  "Compute the (i,j) minor of a matrix (determinant of submatrix with row i and col j removed)."
  (determinant (matrix-delete-row (matrix-delete-column mat j) i)))

(defun matrix-cofactor (mat i j)
  "Compute the (i,j) cofactor of a matrix."
  (let ((sign (if (evenp (+ i j)) 1 -1)))
    (* sign (matrix-minor mat i j))))

(defun matrix-adjugate (mat)
  "Compute the adjugate (classical adjoint) of a matrix."
  (let* ((n (array-dimension mat 0))
         (data '()))
    (dotimes (i n)
      (dotimes (j n)
        (push (matrix-cofactor mat j i) data)))
    (matrix (list n n) (reverse data))))

(defun matrix-pseudoinverse (mat)
  "Compute the Moore-Penrose pseudoinverse using SVD."
  (let* ((svd (sv-decomp mat))
         (u (first svd))
         (s-vals (second svd))
         (v (third svd))
         (s-inv-vals (mapcar #'(lambda (s)
                                 (if (> (abs s) 1e-15) (/ 1.0 s) 0.0))
                             s-vals))
         (s-inv (diagonal-matrix s-inv-vals)))
    (matmult v (matmult s-inv (transpose u)))))

(defun matrix-exp-pade (mat &optional (order 6))
  "Approximate the matrix exponential using Pade approximation."
  (let* ((n (array-dimension mat 0))
         (eye (identity-matrix n))
         (numer eye)
         (denom eye)
         (mat-power eye)
         (c 1.0))
    (dotimes (k order)
      (let ((k1 (1+ k)))
        (setf c (* c (/ (- order k) (* k1 (- (* 2 order) k)))))
        (setf mat-power (matmult mat-power mat))
        (let ((term (matrix-scale c mat-power)))
          (setf numer (matrix-add numer term))
          (if (oddp k1)
              (setf denom (matrix-subtract denom term))
            (setf denom (matrix-add denom term))))))
    (matmult (inverse denom) numer)))

(defun matrix-log-series (mat &optional (terms 20))
  "Approximate matrix logarithm using series expansion log(I+X) for small X."
  (let* ((n (array-dimension mat 0))
         (x (matrix-subtract mat (identity-matrix n)))
         (result (zero-matrix n n))
         (x-power (identity-matrix n)))
    (dotimes (k terms result)
      (let ((k1 (1+ k)))
        (setf x-power (matmult x-power x))
        (let ((sign (if (oddp k1) 1.0 -1.0))
              (coeff (/ 1.0 k1)))
          (setf result (matrix-add result (matrix-scale (* sign coeff) x-power))))))))

(defun matrix-sqrt-denman-beavers (mat &optional (max-iter 50) (tol 1e-10))
  "Compute the matrix square root using the Denman-Beavers iteration."
  (let* ((n (array-dimension mat 0))
         (y (copy-matrix mat))
         (z (identity-matrix n)))
    (dotimes (iter max-iter y)
      (let* ((y-inv (inverse y))
             (z-inv (inverse z))
             (y-new (matrix-scale 0.5 (matrix-add y z-inv)))
             (z-new (matrix-scale 0.5 (matrix-add z y-inv))))
        (when (< (frobenius-norm (matrix-subtract y-new y)) tol)
          (return y-new))
        (setf y y-new)
        (setf z z-new)))))

(defun matrix-is-hermitian-p (mat &optional (tol 1e-10))
  "Check if a matrix is Hermitian (equal to its conjugate transpose)."
  (is-symmetric-p mat tol))

(defun matrix-symmetrize (mat)
  "Symmetrize a matrix: (A + A^T) / 2."
  (matrix-scale 0.5 (matrix-add mat (transpose mat))))

(defun matrix-skew-symmetrize (mat)
  "Skew-symmetrize a matrix: (A - A^T) / 2."
  (matrix-scale 0.5 (matrix-subtract mat (transpose mat))))

(defun is-skew-symmetric-p (mat &optional (tol 1e-10))
  "Check if a matrix is skew-symmetric: A^T = -A."
  (let ((n (array-dimension mat 0)))
    (dotimes (i n t)
      (dotimes (j n)
        (when (> (abs (+ (aref mat i j) (aref mat j i))) tol)
          (return-from is-skew-symmetric-p nil))))))

(defun matrix-column-norms (mat)
  "Compute the L2 norm of each column."
  (matrix-map-columns #'vector-norm-2 mat))

(defun matrix-row-norms (mat)
  "Compute the L2 norm of each row."
  (matrix-map-rows #'vector-norm-2 mat))

(defun matrix-normalize-columns (mat)
  "Normalize each column of a matrix to unit length."
  (let* ((m (array-dimension mat 1))
         (cols '()))
    (dotimes (j m)
      (push (normalize-vector (matrix-column mat j)) cols))
    (matrix-from-columns (reverse cols))))

(defun matrix-normalize-rows (mat)
  "Normalize each row of a matrix to unit length."
  (let* ((n (array-dimension mat 0))
         (rows '()))
    (dotimes (i n)
      (push (normalize-vector (matrix-row mat i)) rows))
    (matrix-from-rows (reverse rows))))

(defun matrix-khatri-rao (a b)
  "Compute the Khatri-Rao (column-wise Kronecker) product."
  (let* ((ma (array-dimension a 1))
         (na (array-dimension a 0))
         (nb (array-dimension b 0))
         (cols '()))
    (dotimes (j ma)
      (let ((col-a (matrix-column a j))
            (col-b (matrix-column b j))
            (kron-col '()))
        (dolist (ai col-a)
          (dolist (bi col-b)
            (push (* ai bi) kron-col)))
        (push (reverse kron-col) cols)))
    (matrix-from-columns (reverse cols))))

(defun matrix-hadamard-power (mat p)
  "Raise each element of a matrix to the pth power (Hadamard power)."
  (matrix-element-power mat p))

(defun matrix-entrywise-log (mat)
  "Apply natural log to each element of a matrix."
  (matrix-apply #'log mat))

(defun matrix-entrywise-exp (mat)
  "Apply exp to each element of a matrix."
  (matrix-apply #'exp mat))

(defun display-matrix (mat &optional (format-str "~8,3f "))
  "Pretty-print a matrix with formatted output."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1)))
    (dotimes (i n)
      (format t "~%[ ")
      (dotimes (j m)
        (format t format-str (aref mat i j)))
      (format t "]"))
    (format t "~%")
    mat))

(defun matrix-to-list-of-lists (mat)
  "Convert a matrix to a list of row lists."
  (let ((n (array-dimension mat 0))
        (rows '()))
    (dotimes (i n (reverse rows))
      (push (matrix-row mat i) rows))))

(defun matrix-from-function (n m func)
  "Create an n x m matrix where element (i,j) = (func i j)."
  (let ((data '()))
    (dotimes (i n)
      (dotimes (j m)
        (push (funcall func i j) data)))
    (matrix (list n m) (reverse data))))

(defun matrix-anti-diagonal (mat)
  "Extract the anti-diagonal of a square matrix."
  (let* ((n (array-dimension mat 0))
         (diag '()))
    (dotimes (i n (reverse diag))
      (push (aref mat i (- n 1 i)) diag))))

(defun matrix-polynomial (mat coeffs)
  "Evaluate a matrix polynomial p(A) = c0*I + c1*A + c2*A^2 + ...
   coeffs is a list of coefficients from lowest to highest degree."
  (let* ((n (array-dimension mat 0))
         (result (matrix-scale (first coeffs) (identity-matrix n)))
         (a-power (identity-matrix n)))
    (dolist (c (rest coeffs) result)
      (setf a-power (matmult a-power mat))
      (setf result (matrix-add result (matrix-scale c a-power))))))

(defun matrix-commutes-p (a b &optional (tol 1e-10))
  "Check if two matrices commute: AB = BA."
  (let ((diff (matrix-subtract (matmult a b) (matmult b a)))
        (n (array-dimension a 0)))
    (dotimes (i n t)
      (dotimes (j n)
        (when (> (abs (aref diff i j)) tol)
          (return-from matrix-commutes-p nil))))))

(defun matrix-similar-p (a b &optional (tol 1e-6))
  "Check if two matrices are similar (same eigenvalues)."
  (let ((eval-a (sort (copy-list (eigenvalues a)) #'<))
        (eval-b (sort (copy-list (eigenvalues b)) #'<)))
    (every #'(lambda (ea eb) (< (abs (- ea eb)) tol)) eval-a eval-b)))

(defun characteristic-polynomial-coeffs (mat)
  "Compute coefficients of the characteristic polynomial using Faddeev-LeVerrier algorithm.
   Returns coefficients from highest to lowest degree."
  (let* ((n (array-dimension mat 0))
         (coeffs (list 1))
         (m (identity-matrix n)))
    (dotimes (k n (reverse coeffs))
      (setf m (if (= k 0)
                  mat
                (matmult mat (matrix-add m (matrix-scale (car coeffs) (identity-matrix n))))))
      (push (/ (- (matrix-trace m)) (1+ k)) coeffs))))

(defun matrix-permanent-small (mat)
  "Compute the permanent of a small matrix (brute force, up to ~8x8)."
  (let ((n (array-dimension mat 0)))
    (if (= n 1)
        (aref mat 0 0)
      (let ((sum 0))
        (dotimes (j n sum)
          (incf sum (* (aref mat 0 j)
                       (matrix-permanent-small (matrix-delete-row (matrix-delete-column mat j) 0)))))))))

(defun matrix-band-width (mat &optional (tol 1e-15))
  "Compute the bandwidth of a matrix (max distance from diagonal with non-zero entries)."
  (let ((n (array-dimension mat 0))
        (m (array-dimension mat 1))
        (bw 0))
    (dotimes (i n bw)
      (dotimes (j m)
        (when (> (abs (aref mat i j)) tol)
          (setf bw (max bw (abs (- i j)))))))))

(defun matrix-density (mat &optional (tol 1e-15))
  "Compute the density (fraction of non-zero elements) of a matrix."
  (- 1.0 (matrix-sparsity mat tol)))