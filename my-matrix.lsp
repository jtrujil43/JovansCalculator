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