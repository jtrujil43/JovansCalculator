;; help-minimal.lsp
;; Minimal version to test basic structure

(defvar *help-functions* nil)

(defstruct function-info
  name
  description
  parameters
  category
  example)

;; Initialize with just first few functions
(defun initialize-help-system ()
  "Initialize the help system with all available functions."
  (setf *help-functions*
    (list
      ;; Mathematical Functions
      (make-function-info
        :name "symbolic-derivative"
        :description "Calculate the symbolic derivative of a polynomial expression with respect to a variable."
        :parameters "(expr var)"
        :category "Mathematical"
        :example "(symbolic-derivative '(* 3 (expt x 2)) 'x)")
      
      (make-function-info
        :name "simplify"
        :description "Simplify mathematical expressions by removing zero terms and combining constants."
        :parameters "(expr)"
        :category "Mathematical"
        :example "(simplify '(+ (* 0 x) (* 1 y)))")
      )))

(initialize-help-system)
(format t "Minimal help system loaded with ~A function(s)~%" (length *help-functions*))