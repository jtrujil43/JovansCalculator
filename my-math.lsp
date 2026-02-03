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

;;; ============================================================================
;;; ALGEBRAIC GEOMETRY FUNCTIONS
;;; ============================================================================

;; -----------------------------------------------------------------------------
;; Polynomial and Curve Representations
;; -----------------------------------------------------------------------------

(defun make-polynomial (coeffs var)
  "Create a polynomial expression from a list of coefficients (lowest degree first).
   Example: (make-polynomial '(1 2 3) 'x) => 1 + 2x + 3x^2"
  (let ((terms '())
        (degree 0))
    (dolist (coeff coeffs)
      (unless (= coeff 0)
        (cond
         ((= degree 0)
          (push coeff terms))
         ((= degree 1)
          (if (= coeff 1)
              (push var terms)
              (push (list '* coeff var) terms)))
         (t
          (if (= coeff 1)
              (push (list 'expt var degree) terms)
              (push (list '* coeff (list 'expt var degree)) terms)))))
      (incf degree))
    (cond
     ((null terms) 0)
     ((= (length terms) 1) (first terms))
     (t (cons '+ (reverse terms))))))

(defun polynomial-degree (coeffs)
  "Return the degree of a polynomial given its coefficient list (lowest degree first)."
  (let ((deg (1- (length coeffs))))
    (loop while (and (>= deg 0) (= (nth deg coeffs) 0))
          do (decf deg))
    (max 0 deg)))

(defun evaluate-polynomial (coeffs x-val)
  "Evaluate a polynomial at a given point using Horner's method.
   Coefficients are given lowest degree first."
  (let ((result 0)
        (n (length coeffs)))
    (loop for i from (1- n) downto 0
          do (setf result (+ (nth i coeffs) (* result x-val))))
    result))

(defun polynomial-add (coeffs1 coeffs2)
  "Add two polynomials represented as coefficient lists."
  (let* ((len1 (length coeffs1))
         (len2 (length coeffs2))
         (max-len (max len1 len2))
         (result '()))
    (dotimes (i max-len)
      (let ((c1 (if (< i len1) (nth i coeffs1) 0))
            (c2 (if (< i len2) (nth i coeffs2) 0)))
        (push (+ c1 c2) result)))
    (reverse result)))

(defun polynomial-multiply (coeffs1 coeffs2)
  "Multiply two polynomials represented as coefficient lists."
  (let* ((len1 (length coeffs1))
         (len2 (length coeffs2))
         (result-len (+ len1 len2 -1))
         (result (make-list result-len :initial-element 0)))
    (dotimes (i len1)
      (dotimes (j len2)
        (let ((pos (+ i j)))
          (setf (nth pos result) 
                (+ (nth pos result) 
                   (* (nth i coeffs1) (nth j coeffs2)))))))
    result))

;; -----------------------------------------------------------------------------
;; Algebraic Curves
;; -----------------------------------------------------------------------------

(defun make-affine-curve (poly vars)
  "Create an affine algebraic curve representation.
   poly: polynomial expression defining f(x,y) = 0
   vars: list of variables, typically '(x y)"
  (list :type 'affine-curve
        :polynomial poly
        :variables vars
        :dimension 2))

(defun make-projective-curve (poly vars)
  "Create a projective algebraic curve representation.
   poly: homogeneous polynomial defining f(x,y,z) = 0
   vars: list of variables, typically '(x y z)"
  (list :type 'projective-curve
        :polynomial poly
        :variables vars
        :dimension 2))

(defun curve-polynomial (curve)
  "Extract the defining polynomial from a curve."
  (getf curve :polynomial))

(defun curve-variables (curve)
  "Extract the variables from a curve definition."
  (getf curve :variables))

(defun homogenize-polynomial (poly var-x var-y var-z degree)
  "Homogenize a polynomial in x,y by introducing z to make all terms degree d.
   This converts an affine curve to a projective curve."
  (cond
   ;; Number case: multiply by z^degree
   ((numberp poly)
    (if (= degree 0)
        poly
        (list '* poly (list 'expt var-z degree))))
   
   ;; Variable case
   ((symbolp poly)
    (cond
     ((eq poly var-x) 
      (if (= degree 1)
          var-x
          (list '* var-x (list 'expt var-z (1- degree)))))
     ((eq poly var-y)
      (if (= degree 1)
          var-y
          (list '* var-y (list 'expt var-z (1- degree)))))
     (t poly)))
   
   ;; Addition
   ((and (listp poly) (eq (car poly) '+))
    (cons '+ (mapcar (lambda (term) 
                       (homogenize-polynomial term var-x var-y var-z degree))
                     (cdr poly))))
   
   ;; Multiplication - recursively process
   ((and (listp poly) (eq (car poly) '*))
    (cons '* (cdr poly)))
   
   ;; Exponentiation
   ((and (listp poly) (eq (car poly) 'expt))
    poly)
   
   (t poly)))

;; -----------------------------------------------------------------------------
;; Elliptic Curves
;; -----------------------------------------------------------------------------

(defun make-elliptic-curve (a b)
  "Create an elliptic curve in Weierstrass form: y^2 = x^3 + ax + b.
   Returns nil if the discriminant is zero (singular curve)."
  (let ((discriminant (+ (* 4 a a a) (* 27 b b))))
    (if (= discriminant 0)
        (progn
          (format t "Warning: Discriminant is zero, curve is singular.~%")
          nil)
        (list :type 'elliptic-curve
              :a a
              :b b
              :discriminant discriminant
              :j-invariant (if (= discriminant 0) 
                               nil 
                               (/ (* -1728 4 a a a) discriminant))))))

(defun elliptic-curve-discriminant (a b)
  "Calculate the discriminant of an elliptic curve y^2 = x^3 + ax + b.
   Discriminant = -16(4a^3 + 27b^2). Curve is non-singular iff discriminant != 0."
  (* -16 (+ (* 4 a a a) (* 27 b b))))

(defun elliptic-curve-j-invariant (a b)
  "Calculate the j-invariant of an elliptic curve y^2 = x^3 + ax + b.
   j = -1728 * (4a^3) / discriminant"
  (let ((disc (elliptic-curve-discriminant a b)))
    (if (= disc 0)
        nil
        (/ (* -1728 4 a a a) disc))))

(defun elliptic-point-on-curve-p (x y a b)
  "Check if a point (x, y) lies on the elliptic curve y^2 = x^3 + ax + b."
  (let ((lhs (* y y))
        (rhs (+ (* x x x) (* a x) b)))
    (< (abs (- lhs rhs)) 1e-10)))

(defun elliptic-curve-add (p1 p2 a b)
  "Add two points on an elliptic curve y^2 = x^3 + ax + b.
   Points are represented as (x . y) pairs. Point at infinity is 'infinity."
  (cond
   ;; Adding point at infinity
   ((eq p1 'infinity) p2)
   ((eq p2 'infinity) p1)
   
   ;; Points are inverses
   ((and (= (car p1) (car p2))
         (= (+ (cdr p1) (cdr p2)) 0))
    'infinity)
   
   ;; Same point (point doubling)
   ((and (= (car p1) (car p2))
         (= (cdr p1) (cdr p2)))
    (if (= (cdr p1) 0)
        'infinity
        (let* ((x1 (car p1))
               (y1 (cdr p1))
               (lambda-val (/ (+ (* 3 x1 x1) a) (* 2 y1)))
               (x3 (- (* lambda-val lambda-val) (* 2 x1)))
               (y3 (- (* lambda-val (- x1 x3)) y1)))
          (cons x3 y3))))
   
   ;; Different points
   (t
    (let* ((x1 (car p1))
           (y1 (cdr p1))
           (x2 (car p2))
           (y2 (cdr p2))
           (lambda-val (/ (- y2 y1) (- x2 x1)))
           (x3 (- (* lambda-val lambda-val) x1 x2))
           (y3 (- (* lambda-val (- x1 x3)) y1)))
      (cons x3 y3)))))

(defun elliptic-curve-scalar-mult (n p a b)
  "Scalar multiplication: compute n*P on elliptic curve using double-and-add."
  (cond
   ((= n 0) 'infinity)
   ((= n 1) p)
   ((evenp n) 
    (elliptic-curve-scalar-mult (/ n 2) 
                                 (elliptic-curve-add p p a b)
                                 a b))
   (t
    (elliptic-curve-add p 
                        (elliptic-curve-scalar-mult (1- n) p a b)
                        a b))))

;; -----------------------------------------------------------------------------
;; Bezout's Theorem and Intersection Theory
;; -----------------------------------------------------------------------------

(defun bezout-number (deg1 deg2)
  "Calculate the Bezout number for two curves of given degrees.
   Two general curves of degrees d1 and d2 intersect in exactly d1*d2 points
   (counting multiplicities and points at infinity in projective space)."
  (* deg1 deg2))

(defun intersection-multiplicity-at-origin (poly1 poly2)
  "Estimate the intersection multiplicity of two curves at the origin.
   This is a simplified version that counts the minimum degree of terms."
  (let ((min-deg1 (find-minimum-degree poly1))
        (min-deg2 (find-minimum-degree poly2)))
    (* min-deg1 min-deg2)))

(defun find-minimum-degree (poly)
  "Find the minimum total degree of any term in a polynomial."
  (cond
   ((numberp poly) 
    (if (= poly 0) most-positive-fixnum 0))
   ((symbolp poly) 1)
   ((and (listp poly) (eq (car poly) '+))
    (apply #'min (mapcar #'find-minimum-degree (cdr poly))))
   ((and (listp poly) (eq (car poly) '*))
    (apply #'+ (mapcar #'find-minimum-degree (cdr poly))))
   ((and (listp poly) (eq (car poly) 'expt))
    (* (find-minimum-degree (second poly)) (third poly)))
   (t 0)))

;; -----------------------------------------------------------------------------
;; Genus and Topological Invariants
;; -----------------------------------------------------------------------------

(defun genus-smooth-plane-curve (degree)
  "Calculate the genus of a smooth plane curve of given degree.
   Formula: g = (d-1)(d-2)/2 where d is the degree."
  (/ (* (- degree 1) (- degree 2)) 2))

(defun euler-characteristic-surface (genus)
  "Calculate the Euler characteristic of a closed orientable surface.
   chi = 2 - 2g where g is the genus."
  (- 2 (* 2 genus)))

(defun arithmetic-genus (degree dimension)
  "Calculate the arithmetic genus of a hypersurface of degree d in P^n.
   For a smooth curve in P^2: p_a = (d-1)(d-2)/2
   For a smooth surface in P^3: p_a = (d-1)(d-2)(d-3)/6"
  (cond
   ((= dimension 2)
    (/ (* (- degree 1) (- degree 2)) 2))
   ((= dimension 3)
    (/ (* (- degree 1) (- degree 2) (- degree 3)) 6))
   (t
    (format t "General formula not implemented for dimension ~A~%" dimension)
    nil)))

;; -----------------------------------------------------------------------------
;; Rational Curves and Parameterizations
;; -----------------------------------------------------------------------------

(defun make-rational-curve (x-param y-param param-var)
  "Create a rational parametric curve representation.
   x-param, y-param: rational expressions in param-var
   Example: Circle: x=cos(t), y=sin(t) or rationally x=(1-t^2)/(1+t^2), y=2t/(1+t^2)"
  (list :type 'rational-curve
        :x-param x-param
        :y-param y-param
        :parameter param-var))

(defun evaluate-rational-curve (curve t-val)
  "Evaluate a rational parametric curve at parameter value t."
  (let ((x-param (getf curve :x-param))
        (y-param (getf curve :y-param))
        (param (getf curve :parameter)))
    ;; This is a simplified evaluation - a full implementation would 
    ;; need symbolic substitution
    (list (cons 'x x-param) (cons 'y y-param) (cons 't t-val))))

(defun circle-rational-param ()
  "Return the rational parameterization of the unit circle.
   x = (1-t^2)/(1+t^2), y = 2t/(1+t^2)"
  (make-rational-curve
   '(/ (- 1 (expt t 2)) (+ 1 (expt t 2)))
   '(/ (* 2 t) (+ 1 (expt t 2)))
   't))

;; -----------------------------------------------------------------------------
;; Singularity Analysis
;; -----------------------------------------------------------------------------

(defun is-singular-point (poly x-val y-val var-x var-y)
  "Check if (x-val, y-val) is a singular point of the curve f(x,y)=0.
   A point is singular if f=0 and all first partial derivatives vanish."
  ;; This would require evaluation of the polynomial and its derivatives
  ;; at the given point - simplified version returns a placeholder
  (list :point (list x-val y-val)
        :f-value 'needs-evaluation
        :singular-p 'needs-evaluation))

(defun count-nodes-and-cusps (poly)
  "Analyze a polynomial for ordinary double points (nodes) and cusps.
   Returns estimated count based on polynomial structure."
  ;; Simplified - actual implementation would require solving systems
  (list :nodes 'to-be-computed
        :cusps 'to-be-computed
        :polynomial poly))

(defun milnor-number (singularity-type)
  "Return the Milnor number for common singularity types.
   A_n (nodes): n, D_n: n, E_6: 6, E_7: 7, E_8: 8"
  (cond
   ((and (listp singularity-type) (eq (car singularity-type) 'A))
    (second singularity-type))
   ((and (listp singularity-type) (eq (car singularity-type) 'D))
    (second singularity-type))
   ((eq singularity-type 'E6) 6)
   ((eq singularity-type 'E7) 7)
   ((eq singularity-type 'E8) 8)
   ((eq singularity-type 'node) 1)
   ((eq singularity-type 'cusp) 2)
   (t nil)))

;; -----------------------------------------------------------------------------
;; Projective Geometry Utilities
;; -----------------------------------------------------------------------------

(defun affine-to-projective (x y)
  "Convert affine coordinates (x,y) to projective coordinates [x:y:1]."
  (list x y 1))

(defun projective-to-affine (coords)
  "Convert projective coordinates [x:y:z] to affine coordinates (x/z, y/z).
   Returns nil if z=0 (point at infinity)."
  (let ((x (first coords))
        (y (second coords))
        (z (third coords)))
    (if (= z 0)
        nil
        (list (/ x z) (/ y z)))))

(defun projective-line-through-points (p1 p2)
  "Find the projective line through two points in P^2.
   Returns coefficients [a:b:c] such that ax + by + cz = 0."
  (let ((x1 (first p1)) (y1 (second p1)) (z1 (third p1))
        (x2 (first p2)) (y2 (second p2)) (z2 (third p2)))
    ;; Line coefficients from cross product
    (list (- (* y1 z2) (* y2 z1))
          (- (* z1 x2) (* z2 x1))
          (- (* x1 y2) (* x2 y1)))))

(defun projective-intersection (line1 line2)
  "Find the intersection point of two projective lines.
   Lines given as [a:b:c] representing ax + by + cz = 0."
  (let ((a1 (first line1)) (b1 (second line1)) (c1 (third line1))
        (a2 (first line2)) (b2 (second line2)) (c2 (third line2)))
    ;; Intersection from cross product
    (list (- (* b1 c2) (* b2 c1))
          (- (* c1 a2) (* c2 a1))
          (- (* a1 b2) (* a2 b1)))))

(defun cross-ratio (p1 p2 p3 p4)
  "Calculate the cross-ratio of four collinear points in projective space.
   Cross-ratio (p1,p2;p3,p4) = ((p1-p3)(p2-p4))/((p1-p4)(p2-p3))"
  (let ((num (* (- p1 p3) (- p2 p4)))
        (den (* (- p1 p4) (- p2 p3))))
    (if (= den 0)
        'infinity
        (/ num den))))

;; -----------------------------------------------------------------------------
;; Degree and Dimension Calculations
;; -----------------------------------------------------------------------------

(defun hilbert-polynomial-curve (degree)
  "Return the Hilbert polynomial of a plane curve of given degree.
   For a curve C of degree d: P(n) = d*n + 1 - g where g = (d-1)(d-2)/2"
  (let ((g (genus-smooth-plane-curve degree)))
    (lambda (n) (+ (* degree n) 1 (- g)))))

(defun dimension-linear-system (degree genus num-points)
  "Estimate dimension of linear system |D| using Riemann-Roch.
   For a divisor D of degree d on a curve of genus g:
   dim|D| >= d - g (with equality for d > 2g-2)"
  (max 0 (- degree genus)))

;; Example usage:
;; (make-polynomial '(1 2 3) 'x)                    ; 1 + 2x + 3x^2
;; (evaluate-polynomial '(1 2 3) 2)                  ; 1 + 4 + 12 = 17
;; (make-elliptic-curve -1 0)                        ; y^2 = x^3 - x
;; (elliptic-curve-add '(0 . 0) '(1 . 0) -1 0)      ; Point addition
;; (genus-smooth-plane-curve 3)                      ; Genus of cubic = 1
;; (bezout-number 2 3)                               ; Line meets cubic in 6 pts
;; (cross-ratio 0 1 2 3)                             ; Cross-ratio calculation