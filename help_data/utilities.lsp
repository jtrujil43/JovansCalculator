;; help_data/utilities.lsp

(push (make-function-info
        :name "string-to-list"
        :description "Convert a string to a list of characters."
        :parameters "(str)"
        :category "Utilities"
        :example "(string-to-list \"hello\")")
      *help-functions*)

(push (make-function-info
        :name "list-to-string"
        :description "Convert a list of characters to a string."
        :parameters "(lst)"
        :category "Utilities"
        :example "(list-to-string '(\"h\" \"e\" \"l\" \"l\" \"o\"))")
      *help-functions*)

(push (make-function-info
        :name "split-string"
        :description "Split a string by a delimiter."
        :parameters "(str delimiter)"
        :category "Utilities"
        :example "(split-string \"a,b,c\" \",\")")
      *help-functions*)

(push (make-function-info
        :name "join-string"
        :description "Join a list of strings with a delimiter."
        :parameters "(lst delimiter)"
        :category "Utilities"
        :example "(join-string '(\"a\" \"b\" \"c\") \",\")")
      *help-functions*)

(push (make-function-info
        :name "trim-string"
        :description "Trim whitespace from the beginning and end of a string."
        :parameters "(str)"
        :category "Utilities"
        :example "(trim-string \"  hello  \")")
      *help-functions*)

(push (make-function-info
        :name "string-upcase"
        :description "Convert a string to uppercase."
        :parameters "(str)"
        :category "Utilities"
        :example "(string-upcase \"hello\")")
      *help-functions*)

(push (make-function-info
        :name "string-downcase"
        :description "Convert a string to lowercase."
        :parameters "(str)"
        :category "Utilities"
        :example "(string-downcase \"HELLO\")")
      *help-functions*)

(push (make-function-info
        :name "string-reverse"
        :description "Reverse a string."
        :parameters "(str)"
        :category "Utilities"
        :example "(string-reverse \"hello\")")
      *help-functions*)

(push (make-function-info
        :name "string-replace"
        :description "Replace all occurrences of a substring with another substring."
        :parameters "(str old new)"
        :category "Utilities"
        :example "(string-replace \"hello world\" \"world\" \"lisp\")")
      *help-functions*)

(push (make-function-info
        :name "string-contains"
        :description "Check if a string contains a substring."
        :parameters "(str sub)"
        :category "Utilities"
        :example "(string-contains \"hello world\" \"world\")")
      *help-functions*)

(push (make-function-info
        :name "string-starts-with"
        :description "Check if a string starts with a substring."
        :parameters "(str sub)"
        :category "Utilities"
        :example "(string-starts-with \"hello world\" \"hello\")")
      *help-functions*)

(push (make-function-info
        :name "string-ends-with"
        :description "Check if a string ends with a substring."
        :parameters "(str sub)"
        :category "Utilities"
        :example "(string-ends-with \"hello world\" \"world\")")
      *help-functions*)

(push (make-function-info
        :name "get-current-time"
        :description "Get the current time as a string."
        :parameters "()"
        :category "Utilities"
        :example "(get-current-time)")
      *help-functions*)

(push (make-function-info
        :name "sleep"
        :description "Pause execution for a number of seconds."
        :parameters "(seconds)"
        :category "Utilities"
        :example "(sleep 1)")
      *help-functions*)

(push (make-function-info
        :name "generate-uuid"
        :description "Generate a random UUID."
        :parameters "()"
        :category "Utilities"
        :example "(generate-uuid)")
      *help-functions*)

(push (make-function-info
        :name "get-env-var"
        :description "Get the value of an environment variable."
        :parameters "(var-name)"
        :category "Utilities"
        :example "(get-env-var \"HOME\")")
      *help-functions*)

(push (make-function-info
        :name "set-env-var"
        :description "Set the value of an environment variable."
        :parameters "(var-name value)"
        :category "Utilities"
        :example "(set-env-var \"MY_VAR\" \"my_value\")")
      *help-functions*)

(push (make-function-info
        :name "delete-file"
        :description "Delete a file."
        :parameters "(file-path)"
        :category "Utilities"
        :example "(delete-file \"/path/to/file\")")
      *help-functions*)

(push (make-function-info
        :name "file-exists"
        :description "Check if a file exists."
        :parameters "(file-path)"
        :category "Utilities"
        :example "(file-exists \"/path/to/file\")")
      *help-functions*)

(push (make-function-info
        :name "read-file-lines"
        :description "Read a file into a list of strings."
        :parameters "(file-path)"
        :category "Utilities"
        :example "(read-file-lines \"/path/to/file\")")
      *help-functions*)

(push (make-function-info
        :name "write-file-lines"
        :description "Write a list of strings to a file."
        :parameters "(file-path lines)"
        :category "Utilities"
        :example "(write-file-lines \"/path/to/file\" '(\"line 1\" \"line 2\"))")
      *help-functions*)

;; Additional Utility Functions
(push (make-function-info
        :name "convert-chars-to-integer-codes"
        :description "Convert characters in a file to their ASCII integer codes."
        :parameters "(input-file output-file)"
        :category "Utilities"
        :example "(convert-chars-to-integer-codes \"input.txt\" \"output.txt\")")
      *help-functions*)

(push (make-function-info
        :name "two-col-table"
        :description "Generate a two-column table of function values."
        :parameters "(fun start end &optional (step 1))"
        :category "Utilities"
        :example "(two-col-table #'sin 0 3.14159 0.1)")
      *help-functions*)

(push (make-function-info
        :name "print-two-col-table"
        :description "Print a formatted two-column table with optional label."
        :parameters "(fun start end &optional (step 1) (label \"f(x)\"))"
        :category "Utilities"
        :example "(print-two-col-table #'cos 0 6.28 0.2 \"cosine\")")
      *help-functions*)
