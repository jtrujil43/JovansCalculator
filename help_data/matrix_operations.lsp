;; help_data/matrix_operations.lsp

(push (make-function-info
        :name "make-matrix"
        :description "Create a matrix with specified dimensions and data."
        :parameters "(n m my-list)"
        :category "Matrix Operations"
        :example "(make-matrix 2 3 '(1 2 3 4 5 6))")
      *help-functions*)

(push (make-function-info
        :name "display-matrix-subset"
        :description "Display a subset of matrix elements within specified ranges."
        :parameters "(start-i end-i start-j end-j my-matrix)"
        :category "Matrix Operations"
        :example "(display-matrix-subset 0 2 0 2 my-matrix)")
      *help-functions*)
