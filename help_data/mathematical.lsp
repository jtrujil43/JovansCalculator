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
