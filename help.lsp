;; help.lsp
;; Help system for Jovan's Calculator
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core
;; Arizona State University
;; Created: 2/2/2026

;; Global variable to store function help information
(defvar *help-functions* nil)

;; Structure to hold function information
(defstruct function-info
  name
  description
  parameters
  category
  example)

;; Initialize the help database
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
      
      ;; Matrix Functions
      (make-function-info
        :name "make-matrix"
        :description "Create a matrix with specified dimensions and data."
        :parameters "(n m my-list)"
        :category "Matrix Operations"
        :example "(make-matrix 2 3 '(1 2 3 4 5 6))")
      
      (make-function-info
        :name "display-matrix-subset"
        :description "Display a subset of matrix elements within specified ranges."
        :parameters "(start-i end-i start-j end-j my-matrix)"
        :category "Matrix Operations"
        :example "(display-matrix-subset 0 2 0 2 my-matrix)")
      
      ;; Electrical Engineering Functions
      (make-function-info
        :name "calculate-capacitance"
        :description "Calculate the capacitance of a parallel plate capacitor given area, dielectric constant, and thickness."
        :parameters "(area k thickness)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance 1e-4 4.5 1e-6)")
      
      (make-function-info
        :name "calculate-capacitor-area"
        :description "Calculate the area of a capacitor given its capacitance, dielectric constant, and thickness."
        :parameters "(capacitance k thickness)"
        :category "Electrical Engineering"
        :example "(calculate-capacitor-area 1e-12 4.5 1e-6)")
      
      (make-function-info
        :name "calculate-capacitance-series"
        :description "Calculate the total capacitance for two capacitors in series."
        :parameters "(area1 area2 k1 k2 thickness1 thickness2)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance-series 1e-4 2e-4 3.9 4.5 1e-6 2e-6)")
      
      (make-function-info
        :name "calculate-capacitance-parallel"
        :description "Calculate the total capacitance for two capacitors in parallel."
        :parameters "(area1 area2 k1 k2 thickness1 thickness2)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance-parallel 1e-4 2e-4 3.9 4.5 1e-6 2e-6)")
      
      (make-function-info
        :name "calculate-capacitor-thickness"
        :description "Calculate the thickness of a parallel plate capacitor based on capacitance."
        :parameters "(capacitance k area)"
        :category "Electrical Engineering"
        :example "(calculate-capacitor-thickness 1e-12 3.9 1e-4)")
      
      (make-function-info
        :name "calculate-dielectric-constant"
        :description "Calculate the dielectric constant of a capacitor material."
        :parameters "(capacitance thickness area)"
        :category "Electrical Engineering"
        :example "(calculate-dielectric-constant 1e-12 1e-6 1e-4)")
      
      (make-function-info
        :name "paschen-breakdown-voltage"
        :description "Calculate breakdown voltage using Paschen's law for gas discharge."
        :parameters "(pressure gap)"
        :category "Electrical Engineering"
        :example "(paschen-breakdown-voltage 101.325 1e-3)")
      
      (make-function-info
        :name "diode-current"
        :description "Calculate diode current using iterative solution of Shockley diode equation."
        :parameters "(v is n vt rs)"
        :category "Electrical Engineering"
        :example "(diode-current 0.7 1.0e-12 1.5 25.85e-3 10)")
      
      (make-function-info
        :name "tungsten-probe-max-current"
        :description "Calculate maximum current for tungsten probe based on diameter."
        :parameters "(diameter)"
        :category "Electrical Engineering"
        :example "(tungsten-probe-max-current 25e-6)")
      
      (make-function-info
        :name "tungsten-max-power"
        :description "Calculate maximum power for tungsten probe considering thermal limits."
        :parameters "(length diameter t-ambient t-max)"
        :category "Electrical Engineering"
        :example "(tungsten-max-power 1e-3 25e-6 300 2000)")
      
      (make-function-info
        :name "tungsten-current-limit-geo"
        :description "Calculate current limit based on tungsten probe geometry and power constraints."
        :parameters "(length diameter pmax)"
        :category "Electrical Engineering"
        :example "(tungsten-current-limit-geo 1e-3 25e-6 0.1)")
      
      (make-function-info
        :name "copper-bulk-resistivity"
        :description "Calculate copper bulk resistivity as a function of temperature."
        :parameters "(temperature)"
        :category "Electrical Engineering"
        :example "(copper-bulk-resistivity 300)")
      
      (make-function-info
        :name "copper-film-thickness"
        :description "Calculate copper film thickness from sheet resistance measurement."
        :parameters "(sheet-resistance)"
        :category "Electrical Engineering"
        :example "(copper-film-thickness 0.1)")
      
      ;; Quantum Physics Functions
      (make-function-info
        :name "make-complex"
        :description "Create a complex number from real and imaginary parts."
        :parameters "(a b)"
        :category "Quantum Physics"
        :example "(make-complex 3 4)")
      
      (make-function-info
        :name "paschen-wavelength"
        :description "Calculate wavelength for the Paschen series in hydrogen spectra (nanometers)."
        :parameters "(n)"
        :category "Quantum Physics"
        :example "(paschen-wavelength 4)")
      
      (make-function-info
        :name "create-qubit"
        :description "Create a qubit with given complex amplitudes alpha and beta (normalized)."
        :parameters "(alpha beta)"
        :category "Quantum Physics"
        :example "(create-qubit #C(0.7071 0) #C(0.7071 0))")
      
      (make-function-info
        :name "display-qubit"
        :description "Display the quantum state of a qubit."
        :parameters "(q)"
        :category "Quantum Physics"
        :example "(display-qubit my-qubit)")
      
      (make-function-info
        :name "pauli-x"
        :description "Apply the Pauli-X (NOT) operation to a qubit."
        :parameters "(input-qubit)"
        :category "Quantum Physics"
        :example "(pauli-x my-qubit)")
      
      (make-function-info
        :name "superpose"
        :description "Create a superposition state from a qubit with new amplitudes."
        :parameters "(input-qubit alpha beta)"
        :category "Quantum Physics"
        :example "(superpose my-qubit #C(0.6 0) #C(0.8 0))")
      
      (make-function-info
        :name "phase-shift"
        :description "Apply a phase shift to a qubit's quantum state."
        :parameters "(input-qubit phi)"
        :category "Quantum Physics"
        :example "(phase-shift my-qubit 1.5708)")
      
      ;; Braid Statistics Functions
      (make-function-info
        :name "pauli-matrices"
        :description "Return the three Pauli matrices as a list."
        :parameters "()"
        :category "Quantum Physics"
        :example "(pauli-matrices)")
      
      (make-function-info
        :name "braiding-matrix"
        :description "Generate braiding matrix for non-Abelian statistics."
        :parameters "(sigma)"
        :category "Quantum Physics"
        :example "(braiding-matrix 1)")
      
      (make-function-info
        :name "simulate-braiding"
        :description "Simulate braiding operations in non-Abelian systems."
        :parameters "()"
        :category "Quantum Physics"
        :example "(simulate-braiding)")
      
      ;; Utility Functions
      (make-function-info
        :name "convert-chars-to-integer-codes"
        :description "Convert characters in a file to their ASCII integer codes."
        :parameters "(input-file output-file)"
        :category "Utilities"
        :example "(convert-chars-to-integer-codes \"input.txt\" \"output.txt\")")
      
      (make-function-info
        :name "two-col-table"
        :description "Generate a two-column table of function values."
        :parameters "(fun start end &optional (step 1))"
        :category "Utilities"
        :example "(two-col-table #'sin 0 3.14159 0.1)")
      
      (make-function-info
        :name "print-two-col-table"
        :description "Print a formatted two-column table with optional label."
        :parameters "(fun start end &optional (step 1) (label \"f(x)\"))"
        :category "Utilities"
        :example "(print-two-col-table #'cos 0 6.28 0.2 \"cosine\")")
      )))

;; Main help function - display all available functions
(defun help ()
  "Display all available functions organized by category with index numbers."
  (unless *help-functions*
    (initialize-help-system))
  
  (format t "~%============================================~%")
  (format t "    JOVAN'S CALCULATOR - HELP SYSTEM~%")
  (format t "============================================~%")
  (format t "Available Functions (type 'help-function <index>' for details):~%~%")
  
  (let ((categories '())
        (index 1))
    
    ;; Group functions by category
    (dolist (func *help-functions*)
      (let ((cat (function-info-category func)))
        (unless (assoc cat categories :test #'string=)
          (push (cons cat '()) categories))))
    
    ;; Add functions to their categories
    (dolist (func *help-functions*)
      (let ((cat (function-info-category func)))
        (setf (cdr (assoc cat categories :test #'string=))
              (append (cdr (assoc cat categories :test #'string=)) (list func)))))
    
    ;; Display by category
    (dolist (category (reverse categories))
      (format t "~A:~%" (car category))
      (dolist (func (cdr category))
        (format t "  ~2d. ~A~%" index (function-info-name func))
        (incf index))
      (format t "~%"))
    
    (format t "Usage: (help-function <index>)  - Get detailed help for function~%")
    (format t "       (help)                   - Show this help menu~%")
    (format t "       (help-category \"name\")   - Show functions in a category~%")
    (format t "============================================~%")))

;; Get detailed help for a specific function by index
(defun help-function (index)
  "Display detailed help for a function specified by index number."
  (unless *help-functions*
    (initialize-help-system))
  
  (if (and (numberp index) (> index 0) (<= index (length *help-functions*)))
    (let ((func (nth (1- index) *help-functions*)))
      (format t "~%============================================~%")
      (format t "Function: ~A~%" (function-info-name func))
      (format t "============================================~%")
      (format t "Category: ~A~%" (function-info-category func))
      (format t "Parameters: ~A~%" (function-info-parameters func))
      (format t "Description: ~A~%" (function-info-description func))
      (format t "Example: ~A~%" (function-info-example func))
      (format t "============================================~%"))
    (format t "Invalid function index. Use 'help' to see available functions.~%")))

;; Show functions in a specific category
(defun help-category (category-name)
  "Display all functions in a specific category."
  (unless *help-functions*
    (initialize-help-system))
  
  (format t "~%Functions in category '~A':~%" category-name)
  (format t "============================================~%")
  
  (let ((index 1)
        (found nil))
    (dolist (func *help-functions*)
      (when (string= (function-info-category func) category-name)
        (format t "~2d. ~A - ~A~%" 
                index 
                (function-info-name func)
                (function-info-description func))
        (setf found t))
      (incf index))
    
    (unless found
      (format t "No functions found in category '~A'.~%" category-name))
    (format t "============================================~%")))

;; Quick search function
(defun help-search (keyword)
  "Search for functions containing a keyword in their name or description."
  (unless *help-functions*
    (initialize-help-system))
  
  (format t "~%Search results for '~A':~%" keyword)
  (format t "============================================~%")
  
  (let ((index 1)
        (found nil))
    (dolist (func *help-functions*)
      (when (or (search keyword (function-info-name func) :test #'char-equal)
                (search keyword (function-info-description func) :test #'char-equal))
        (format t "~2d. ~A - ~A~%" 
                index 
                (function-info-name func)
                (function-info-description func))
        (setf found t))
      (incf index))
    
    (unless found
      (format t "No functions found matching '~A'.~%" keyword))
    (format t "============================================~%")))

;; Initialize the help system when this file is loaded
(initialize-help-system)

;; Display a welcome message
(format t "~%Help system loaded successfully!~%")
(format t "Type (help) to see all available functions.~%")