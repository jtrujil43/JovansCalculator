;; Simple test version of help.lsp

(defvar *help-functions* nil)

(defstruct function-info
  name
  description
  parameters
  category
  example)

(defun initialize-help-system-test ()
  "Test version with just one function."
  (setf *help-functions*
    (list
      (make-function-info
        :name "test-function"
        :description "A simple test function."
        :parameters "(x)"
        :category "Test"
        :example "(test-function 42)")
      )))

(initialize-help-system-test)
(format t "Test help system loaded with ~A function(s)~%" (length *help-functions*))