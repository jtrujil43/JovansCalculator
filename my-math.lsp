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

(defun group-terms (expr)
"Group like terms in an expression and combine their coefficients."
(cond
 ;; Handle addition expressions
 ((and (listp expr) (eq (car expr) '+))
  (let ((terms (cdr expr))
        (grouped-terms '()))
    
    ;; Process each term
    (dolist (term terms)
      (let* ((term (simplify term))
             (coeff (extract-coefficient term))
             (var-part (extract-variable-part term))
             (existing (assoc var-part grouped-terms :test #'equal)))
        
        (if existing
            ;; Add coefficient to existing term
            (setf (cdr existing) (+ (cdr existing) coeff))
            ;; Add new term
            (push (cons var-part coeff) grouped-terms))))
    
    ;; Convert back to expression form
    (terms-to-expression grouped-terms)))
 
 ;; For non-addition expressions, just return simplified
 (t (simplify expr))))

(defun extract-coefficient (term)
"Extract the numerical coefficient from a term."
(cond
 ;; Pure number
 ((numberp term) term)
 
 ;; Variable only (coefficient = 1)
 ((symbolp term) 1)
 
 ;; Multiplication expression
 ((and (listp term) (eq (car term) '*))
  (let ((factors (cdr term)))
    (if (numberp (first factors))
        (first factors)
        1)))
 
 ;; Power expression (coefficient = 1)
 ((and (listp term) (eq (car term) 'expt)) 1)
 
 ;; Default coefficient = 1
 (t 1)))

(defun extract-variable-part (term)
"Extract the variable part (non-coefficient) from a term."
(cond
 ;; Pure number has no variable part
 ((numberp term) 1)
 
 ;; Variable only
 ((symbolp term) term)
 
 ;; Multiplication expression
 ((and (listp term) (eq (car term) '*))
  (let ((factors (cdr term)))
    (if (numberp (first factors))
        ;; Remove the coefficient, keep the rest
        (if (= (length factors) 2)
            (second factors)
            (cons '* (rest factors)))
        ;; No numerical coefficient
        term)))
 
 ;; Power expression
 ((and (listp term) (eq (car term) 'expt)) term)
 
 ;; Default: return the term itself
 (t term)))

(defun terms-to-expression (grouped-terms)
"Convert grouped terms back to an expression."
(let ((result-terms '()))
  (dolist (term-pair grouped-terms)
    (let ((var-part (car term-pair))
          (coeff (cdr term-pair)))
      ;; Only include terms with non-zero coefficients
      (unless (= coeff 0)
        (cond
         ;; Coefficient is 1 and we have a variable part
         ((and (= coeff 1) (not (eq var-part 1)))
          (push var-part result-terms))
         
         ;; Coefficient is -1 and we have a variable part
         ((and (= coeff -1) (not (eq var-part 1)))
          (push (list '* -1 var-part) result-terms))
         
         ;; Variable part is 1 (constant term)
         ((eq var-part 1)
          (push coeff result-terms))
         
         ;; General case: coefficient * variable part
         (t (push (list '* coeff var-part) result-terms))))))
  
  ;; Construct the final expression
  (cond
   ((null result-terms) 0)
   ((= (length result-terms) 1) (first result-terms))
   (t (cons '+ (reverse result-terms))))))

;; Example usage:
;; (group-terms '(+ (* 2 x) (* 3 x) 5))  ; Should give (* 5 x) + 5
;; (group-terms '(+ (* 2 x) (* 3 y) (* 4 x) (* -1 y)))  ; Should give (* 6 x) + (* 2 y)

(defun infix-notation (expr)
  "Convert Lisp prefix expressions to infix notation string."
  (cond
   ;; Handle atoms (numbers, symbols)
   ((atom expr) (format nil "~A" expr))
   
   ;; Handle binary addition
   ((and (listp expr) (eq (car expr) '+))
    (let ((terms (cdr expr)))
      (if (= (length terms) 2)
          (format nil "(~A + ~A)" 
                  (infix-notation (first terms))
                  (infix-notation (second terms)))
          ;; Multiple terms
          (let ((result (infix-notation (first terms))))
            (dolist (term (rest terms) result)
              (setf result (format nil "~A + ~A" result (infix-notation term))))))))
   
   ;; Handle binary subtraction
   ((and (listp expr) (eq (car expr) '-))
    (let ((terms (cdr expr)))
      (if (= (length terms) 1)
          ;; Unary minus
          (format nil "-~A" (infix-notation (first terms)))
          ;; Binary minus
          (format nil "(~A - ~A)"
                  (infix-notation (first terms))
                  (infix-notation (second terms))))))
   
   ;; Handle multiplication
   ((and (listp expr) (eq (car expr) '*))
    (let ((factors (cdr expr)))
      (if (= (length factors) 2)
          (let ((left (infix-notation (first factors)))
                (right (infix-notation (second factors))))
            ;; Add parentheses around addition/subtraction in multiplication
            (when (and (listp (first factors))
                       (member (car (first factors)) '(+ -)))
              (setf left (format nil "(~A)" left)))
            (when (and (listp (second factors))
                       (member (car (second factors)) '(+ -)))
              (setf right (format nil "(~A)" right)))
            (format nil "~A * ~A" left right))
          ;; Multiple factors
          (let ((result (infix-notation (first factors))))
            (dolist (factor (rest factors) result)
              (let ((factor-str (infix-notation factor)))
                (when (and (listp factor)
                           (member (car factor) '(+ -)))
                  (setf factor-str (format nil "(~A)" factor-str)))
                (setf result (format nil "~A * ~A" result factor-str))))))))
   
   ;; Handle division
   ((and (listp expr) (eq (car expr) '/))
    (let ((numerator (infix-notation (second expr)))
          (denominator (infix-notation (third expr))))
      ;; Add parentheses around addition/subtraction in division
      (when (and (listp (second expr))
                 (member (car (second expr)) '(+ -)))
        (setf numerator (format nil "(~A)" numerator)))
      (when (and (listp (third expr))
                 (member (car (third expr)) '(+ - * /)))
        (setf denominator (format nil "(~A)" denominator)))
      (format nil "~A / ~A" numerator denominator)))
   
   ;; Handle exponentiation
   ((and (listp expr) (eq (car expr) 'expt))
    (let ((base (infix-notation (second expr)))
          (power (infix-notation (third expr))))
      ;; Add parentheses around complex base expressions
      (when (and (listp (second expr))
                 (member (car (second expr)) '(+ - * /)))
        (setf base (format nil "(~A)" base)))
      (format nil "~A^~A" base power)))
   
   ;; Handle functions
   ((and (listp expr) (symbolp (car expr)))
    (let ((func-name (car expr))
          (args (cdr expr)))
      (format nil "~A(~{~A~^, ~})" 
              func-name 
              (mapcar #'infix-notation args))))
   
   ;; Default case
   (t (format nil "~A" expr))))

(defun pretty-print-expression (expr)
  "Pretty print a mathematical expression in infix notation."
  (let ((infix-str (infix-notation expr)))
    (format t "~A~%" infix-str)
    infix-str))

(defun latex-notation (expr)
  "Convert Lisp expressions to LaTeX mathematical notation."
  (cond
   ;; Handle atoms
   ((atom expr) 
    (cond
     ((symbolp expr) (format nil "~A" expr))
     ((numberp expr) (format nil "~A" expr))
     (t (format nil "~A" expr))))
   
   ;; Handle addition
   ((and (listp expr) (eq (car expr) '+))
    (let ((terms (cdr expr)))
      (format nil "~{~A~^ + ~}" (mapcar #'latex-notation terms))))
   
   ;; Handle subtraction
   ((and (listp expr) (eq (car expr) '-))
    (let ((terms (cdr expr)))
      (if (= (length terms) 1)
          (format nil "-~A" (latex-notation (first terms)))
          (format nil "~A - ~A" 
                  (latex-notation (first terms))
                  (latex-notation (second terms))))))
   
   ;; Handle multiplication
   ((and (listp expr) (eq (car expr) '*))
    (let ((factors (cdr expr)))
      (format nil "~{~A~^ \\cdot ~}" (mapcar #'latex-notation factors))))
   
   ;; Handle division
   ((and (listp expr) (eq (car expr) '/))
    (format nil "\\frac{~A}{~A}" 
            (latex-notation (second expr))
            (latex-notation (third expr))))
   
   ;; Handle exponentiation
   ((and (listp expr) (eq (car expr) 'expt))
    (let ((base (latex-notation (second expr)))
          (power (latex-notation (third expr))))
      ;; Add braces around complex expressions
      (when (and (listp (second expr)))
        (setf base (format nil "{~A}" base)))
      (format nil "~A^{~A}" base power)))
   
   ;; Handle square root
   ((and (listp expr) (eq (car expr) 'sqrt))
    (format nil "\\sqrt{~A}" (latex-notation (second expr))))
   
   ;; Handle functions
   ((and (listp expr) (symbolp (car expr)))
    (let ((func-name (car expr))
          (args (cdr expr)))
      (format nil "\\~A\\left(~{~A~^, ~}\\right)" 
              func-name 
              (mapcar #'latex-notation args))))
   
   ;; Default
   (t (format nil "~A" expr))))

(defun derivative-step-by-step (expr var)
  "Show step-by-step derivative calculation with explanations."
  (format t "Finding the derivative of ~A with respect to ~A:~%" 
          (infix-notation expr) var)
  (format t "Original expression: ~A~%" (infix-notation expr))
  
  (let ((result (symbolic-derivative expr var)))
    (format t "Applying differentiation rules...~%")
    (format t "Result: ~A~%" (infix-notation result))
    
    ;; Simplify and show simplified result
    (let ((simplified (simplify result)))
      (unless (equal result simplified)
        (format t "Simplified: ~A~%" (infix-notation simplified)))
      simplified)))

;; Example usage:
;; (infix-notation '(+ (* 3 (expt x 2)) (* 2 x) 1))  ; Returns "3 * x^2 + 2 * x + 1"
;; (pretty-print-expression '(/ (+ a b) (- c d)))    ; Prints "(a + b) / (c - d)"
;; (latex-notation '(/ (+ a b) (* c d)))             ; Returns "\\frac{a + b}{c \\cdot d}"
;; (derivative-step-by-step '(* 3 (expt x 2)) 'x)    ; Shows step-by-step derivative