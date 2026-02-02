;; my-math.lsp
;; Mathematical functions for Jovan's Calculator
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core
;; Arizona State University
;; Created: 2/2/2026

(defun symbolic-derivative (expr var)
"Calculate the symbolic derivative of a polynomial expression `expr` with respect to variable `var`."
(cond
 ;; Constant rule: derivative of a constant is 0.
 ((numberp expr) 0)

 ;; Variable rule: derivative of the variable with respect to itself is 1. 
 ((and (symbolp expr) (eq expr var)) 1)

 ;; Power rule: derivative of x^n is n * x^(n-1).
 ((and (listp expr) (eq (car expr) 'expt))
  (let ((base (second expr))
	(power (third expr)))
    (if (and (eq base var) (numberp power))
	(list '* power (list 'expt var (- power 1)))
      0)))
 ;; Addition rule: derivative of a + b is dervative of a plus derivative of b.
 ((and (listp expr) (eq (car expr) '+))
  (list '+ (symbolic-derivative (second expr) var)
	(symbolic-derivative (third expr) var)))

 ;; Multiplication rule: derivative of a * b is (da/dx * b) + (a * db/dx).
 ((and (listp expr) (eq (car expr) '*))
  (list '+
	(list '* (symbolic-derivative (second expr) var) (third expr))
	(list '* (second expr) (symbolic-derivative (third expr) var))))
 
 ;; Default case (unsupported expressions).
 (t 'unsupported)))

;; Example Usage:
;; Define a polynomial f(x) = 3 * x^2 + 5 * x + 2
;; (setq my-poly (list '+ (list '* 3 (list 'expt 'x 2))
;; (list '* 5 'x)
;; 2))
;; (symbolic-derivative my-poly 'x)

(defun simplify (expr)
"Simplify the expression by removing zero terms and combining constants."
(cond
 ((and (listp expr) (eq (car expr) '+))
  (let ((simplified (remove 0 (mapcar #'simplify (cdr expr)))))
    (cond
     ((null simplified) 0)
     ((= (length simplified) 1) (car simplified))
     (t (cons '+ simplified)))))
 ((and (listp expr) (eq (car expr) '*))
  (if (member 0 (mapcar #'simplify (cdr expr)))
      0
    (let ((simplified (mapcar #'simplify (cdr expr))))
      (if (every #'numberp simplified)
	  (apply #'* simplified)
	(cons '* simplified)))))
 ((and (listp expr) (eq (car expr) 'expt))
  (let ((base (simplify (second expr)))
        (power (simplify (third expr))))
    (cond
     ((and (numberp base) (numberp power))
      (expt base power))
     ((and (eq power 0))
      1)
     ((and (eq power 1))
      base)
     (t (list 'expt base power)))))
 (t expr)))