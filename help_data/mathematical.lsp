;; help_data/mathematical.lsp

(push (make-function-info
        :name "symbolic-derivative"
        :description "Calculate the symbolic derivative of a polynomial expression with respect to a variable."
        :parameters "(expr var)"
        :category "Mathematical"
        :example "(symbolic-derivative '(* 3 (expt x 2)) 'x)")
      *help-functions*)

(push (make-function-info
        :name "simplify"
        :description "Simplify mathematical expressions by removing zero terms and combining constants."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(simplify '(+ (* 0 x) (* 1 y)))")
      *help-functions*)

(push (make-function-info
        :name "group-terms"
        :description "Group like terms in an expression and combine their coefficients."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(group-terms '(+ (* 2 x) (* 3 x) 5))")
      *help-functions*)

(push (make-function-info
        :name "infix-notation"
        :description "Convert Lisp prefix expressions to readable infix notation string."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(infix-notation '(+ (* 3 (expt x 2)) (* 2 x) 1))")
      *help-functions*)

(push (make-function-info
        :name "pretty-print-expression"
        :description "Pretty print a mathematical expression in infix notation to console."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(pretty-print-expression '(/ (+ a b) (- c d)))")
      *help-functions*)

(push (make-function-info
        :name "latex-notation"
        :description "Convert Lisp expressions to LaTeX mathematical notation for typesetting."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(latex-notation '(/ (+ a b) (* c d)))")
      *help-functions*)

(push (make-function-info
        :name "derivative-step-by-step"
        :description "Show step-by-step derivative calculation with explanations and infix output."
        :parameters "(expr var)"
        :category "Mathematical"
        :example "(derivative-step-by-step '(* 3 (expt x 2)) 'x)")
      *help-functions*)

;;; Algebraic Geometry Functions

(push (make-function-info
        :name "make-polynomial"
        :description "Create a polynomial expression from a list of coefficients (lowest degree first)."
        :parameters "(coeffs var)"
        :category "Mathematical"
        :example "(make-polynomial '(1 2 3) 'x)")
      *help-functions*)

(push (make-function-info
        :name "polynomial-degree"
        :description "Return the degree of a polynomial given its coefficient list (lowest degree first)."
        :parameters "(coeffs)"
        :category "Mathematical"
        :example "(polynomial-degree '(1 2 3 0))")
      *help-functions*)

(push (make-function-info
        :name "evaluate-polynomial"
        :description "Evaluate a polynomial at a given point using Horner's method."
        :parameters "(coeffs x-val)"
        :category "Mathematical"
        :example "(evaluate-polynomial '(1 2 3) 2)")
      *help-functions*)

(push (make-function-info
        :name "polynomial-add"
        :description "Add two polynomials represented as coefficient lists."
        :parameters "(coeffs1 coeffs2)"
        :category "Mathematical"
        :example "(polynomial-add '(1 2) '(3 4 5))")
      *help-functions*)

(push (make-function-info
        :name "polynomial-multiply"
        :description "Multiply two polynomials represented as coefficient lists."
        :parameters "(coeffs1 coeffs2)"
        :category "Mathematical"
        :example "(polynomial-multiply '(1 1) '(1 -1))")
      *help-functions*)

(push (make-function-info
        :name "make-affine-curve"
        :description "Create an affine algebraic curve representation from polynomial f(x,y)=0."
        :parameters "(poly vars)"
        :category "Mathematical"
        :example "(make-affine-curve '(- (expt y 2) (expt x 3)) '(x y))")
      *help-functions*)

(push (make-function-info
        :name "make-projective-curve"
        :description "Create a projective algebraic curve from homogeneous polynomial f(x,y,z)=0."
        :parameters "(poly vars)"
        :category "Mathematical"
        :example "(make-projective-curve '(- (* y y z) (expt x 3)) '(x y z))")
      *help-functions*)

(push (make-function-info
        :name "curve-polynomial"
        :description "Extract the defining polynomial from a curve."
        :parameters "(curve)"
        :category "Mathematical"
        :example "(curve-polynomial my-curve)")
      *help-functions*)

(push (make-function-info
        :name "curve-variables"
        :description "Extract the variables from a curve definition."
        :parameters "(curve)"
        :category "Mathematical"
        :example "(curve-variables my-curve)")
      *help-functions*)

(push (make-function-info
        :name "homogenize-polynomial"
        :description "Homogenize a polynomial in x,y by introducing z to make all terms degree d."
        :parameters "(poly var-x var-y var-z degree)"
        :category "Mathematical"
        :example "(homogenize-polynomial '(+ x 1) 'x 'y 'z 2)")
      *help-functions*)

(push (make-function-info
        :name "make-elliptic-curve"
        :description "Create an elliptic curve in Weierstrass form: y^2 = x^3 + ax + b."
        :parameters "(a b)"
        :category "Mathematical"
        :example "(make-elliptic-curve -1 0)")
      *help-functions*)

(push (make-function-info
        :name "elliptic-curve-discriminant"
        :description "Calculate the discriminant of an elliptic curve y^2 = x^3 + ax + b."
        :parameters "(a b)"
        :category "Mathematical"
        :example "(elliptic-curve-discriminant -1 0)")
      *help-functions*)

(push (make-function-info
        :name "elliptic-curve-j-invariant"
        :description "Calculate the j-invariant of an elliptic curve y^2 = x^3 + ax + b."
        :parameters "(a b)"
        :category "Mathematical"
        :example "(elliptic-curve-j-invariant -1 0)")
      *help-functions*)

(push (make-function-info
        :name "elliptic-point-on-curve-p"
        :description "Check if a point (x, y) lies on the elliptic curve y^2 = x^3 + ax + b."
        :parameters "(x y a b)"
        :category "Mathematical"
        :example "(elliptic-point-on-curve-p 0 0 -1 0)")
      *help-functions*)

(push (make-function-info
        :name "elliptic-curve-add"
        :description "Add two points on an elliptic curve using the group law."
        :parameters "(p1 p2 a b)"
        :category "Mathematical"
        :example "(elliptic-curve-add '(0 . 0) '(1 . 0) -1 0)")
      *help-functions*)

(push (make-function-info
        :name "elliptic-curve-scalar-mult"
        :description "Scalar multiplication n*P on elliptic curve using double-and-add algorithm."
        :parameters "(n p a b)"
        :category "Mathematical"
        :example "(elliptic-curve-scalar-mult 3 '(1 . 0) -1 0)")
      *help-functions*)

(push (make-function-info
        :name "bezout-number"
        :description "Calculate the Bezout number (intersection count) for curves of given degrees."
        :parameters "(deg1 deg2)"
        :category "Mathematical"
        :example "(bezout-number 2 3)")
      *help-functions*)

(push (make-function-info
        :name "intersection-multiplicity-at-origin"
        :description "Estimate the intersection multiplicity of two curves at the origin."
        :parameters "(poly1 poly2)"
        :category "Mathematical"
        :example "(intersection-multiplicity-at-origin '(* x y) '(+ x y))")
      *help-functions*)

(push (make-function-info
        :name "find-minimum-degree"
        :description "Find the minimum total degree of any term in a polynomial."
        :parameters "(poly)"
        :category "Mathematical"
        :example "(find-minimum-degree '(+ (* x y) (expt x 3)))")
      *help-functions*)

(push (make-function-info
        :name "genus-smooth-plane-curve"
        :description "Calculate the genus of a smooth plane curve: g = (d-1)(d-2)/2."
        :parameters "(degree)"
        :category "Mathematical"
        :example "(genus-smooth-plane-curve 3)")
      *help-functions*)

(push (make-function-info
        :name "euler-characteristic-surface"
        :description "Calculate the Euler characteristic of a closed orientable surface: chi = 2 - 2g."
        :parameters "(genus)"
        :category "Mathematical"
        :example "(euler-characteristic-surface 1)")
      *help-functions*)

(push (make-function-info
        :name "arithmetic-genus"
        :description "Calculate the arithmetic genus of a hypersurface of degree d in P^n."
        :parameters "(degree dimension)"
        :category "Mathematical"
        :example "(arithmetic-genus 3 2)")
      *help-functions*)

(push (make-function-info
        :name "make-rational-curve"
        :description "Create a rational parametric curve with x(t) and y(t) expressions."
        :parameters "(x-param y-param param-var)"
        :category "Mathematical"
        :example "(make-rational-curve '(cos t) '(sin t) 't)")
      *help-functions*)

(push (make-function-info
        :name "evaluate-rational-curve"
        :description "Evaluate a rational parametric curve at parameter value t."
        :parameters "(curve t-val)"
        :category "Mathematical"
        :example "(evaluate-rational-curve (circle-rational-param) 0.5)")
      *help-functions*)

(push (make-function-info
        :name "circle-rational-param"
        :description "Return the rational parameterization of the unit circle."
        :parameters "()"
        :category "Mathematical"
        :example "(circle-rational-param)")
      *help-functions*)

(push (make-function-info
        :name "is-singular-point"
        :description "Check if (x-val, y-val) is a singular point of the curve f(x,y)=0."
        :parameters "(poly x-val y-val var-x var-y)"
        :category "Mathematical"
        :example "(is-singular-point '(- (expt y 2) (expt x 3)) 0 0 'x 'y)")
      *help-functions*)

(push (make-function-info
        :name "count-nodes-and-cusps"
        :description "Analyze a polynomial for ordinary double points (nodes) and cusps."
        :parameters "(poly)"
        :category "Mathematical"
        :example "(count-nodes-and-cusps '(- (expt y 2) (expt x 3)))")
      *help-functions*)

(push (make-function-info
        :name "milnor-number"
        :description "Return the Milnor number for common singularity types (A_n, D_n, E_6, E_7, E_8)."
        :parameters "(singularity-type)"
        :category "Mathematical"
        :example "(milnor-number 'cusp)")
      *help-functions*)

(push (make-function-info
        :name "affine-to-projective"
        :description "Convert affine coordinates (x,y) to projective coordinates [x:y:1]."
        :parameters "(x y)"
        :category "Mathematical"
        :example "(affine-to-projective 2 3)")
      *help-functions*)

(push (make-function-info
        :name "projective-to-affine"
        :description "Convert projective coordinates [x:y:z] to affine (x/z, y/z). Returns nil if z=0."
        :parameters "(coords)"
        :category "Mathematical"
        :example "(projective-to-affine '(2 4 2))")
      *help-functions*)

(push (make-function-info
        :name "projective-line-through-points"
        :description "Find the projective line [a:b:c] through two points in P^2."
        :parameters "(p1 p2)"
        :category "Mathematical"
        :example "(projective-line-through-points '(1 0 1) '(0 1 1))")
      *help-functions*)

(push (make-function-info
        :name "projective-intersection"
        :description "Find the intersection point of two projective lines."
        :parameters "(line1 line2)"
        :category "Mathematical"
        :example "(projective-intersection '(1 0 0) '(0 1 0))")
      *help-functions*)

(push (make-function-info
        :name "cross-ratio"
        :description "Calculate the cross-ratio of four collinear points in projective space."
        :parameters "(p1 p2 p3 p4)"
        :category "Mathematical"
        :example "(cross-ratio 0 1 2 3)")
      *help-functions*)

(push (make-function-info
        :name "hilbert-polynomial-curve"
        :description "Return the Hilbert polynomial function of a plane curve of given degree."
        :parameters "(degree)"
        :category "Mathematical"
        :example "(funcall (hilbert-polynomial-curve 3) 5)")
      *help-functions*)

(push (make-function-info
        :name "dimension-linear-system"
        :description "Estimate dimension of linear system |D| using Riemann-Roch theorem."
        :parameters "(degree genus num-points)"
        :category "Mathematical"
        :example "(dimension-linear-system 5 1 0)")
      *help-functions*)
