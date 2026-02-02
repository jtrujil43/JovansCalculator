;; help-core.lsp
;; Core help system without management functions

(defvar *help-functions* nil)

(defstruct function-info
  name
  description
  parameters
  category
  example)

;; Load the full function list from the original file but only core functions
(load "help-minimal.lsp")  ; This loads the structure and basic setup

;; Test with a couple more functions to see where the issue starts
(defun add-more-functions ()
  (push (make-function-info
         :name "calculate-capacitance"
         :description "Calculate the capacitance of a parallel plate capacitor."
         :parameters "(area k thickness)"
         :category "Electrical Engineering"
         :example "(calculate-capacitance 1e-4 4.5 1e-6)")
        *help-functions*))

(add-more-functions)
(format t "Core help system loaded with ~A function(s)~%" (length *help-functions*))