;; Non-Abelian Braid Statistics Example
;; Jovan Trujillo

;; 2/20/2025

;; Function to generate Pauli matrices
(defun pauli-matrices ()
  (list (matrix '(2 2) '(0 1 1 0))
	(matrix '(2 2) '(0 #C(0.0 -1.0) #C(0.0 1.0) 0))
	(matrix '(2 2) '(1 0 0 -1))))

;; Function to calculate braiding matrix
(defun braiding-matrix (sigma)
  (let ((j (sqrt -1)))
    (exp (* j sigma))))

;; Function to simulate non-Abelian braiding
(defun simulate-braiding ()
  (let ( (sigmas (pauli-matrices))
	 (identity (matrix '(2 2) '(1 0 0 1))))
    (dotimes (j 3 identity)
      (let ((sigma (nth j sigmas)))
	    (setq identity (matmult identity (braiding-matrix sigma)))))
  identity))

;; (simulate-braiding)
