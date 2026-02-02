

(defun make-complex (a b)
(complex a b))

(defun paschen-wavelength (n)
  "Calculates the wavelength for the Paschen series in nanometers."
  (let* ((rydberg-constant 10973731.6) ; Rydberg constant in m^-1
         (m 3)
         (inverse-wavelength
           (* rydberg-constant
              (- (/ 1.0 (* m m)) (/ 1.0 (* n n)))))
         (wavelength-in-meters (/ 1.0 inverse-wavelength)))
    (* wavelength-in-meters 1e9))) ; Convert from meters to nanometers

;; Example usage:
;; (format t "Paschen wavelength for n=4: ~f nm~%" (paschen-wavelength 4))
;; (format t "Paschen wavelength for n=5: ~f nm~%" (paschen-wavelength 5))

;; Define a qubit structure
(defstruct qubit
  (amplitude-zero #C(1 0))  ;; Complex amplitude for |0>
  (amplitude-one #C(0 0)))  ;; Complex amplitude for |1>

;; Function to create a new qubit
(defun create-qubit (alpha beta)
"Create a qubit with the given complex amplitudes alpha and beta."
(let ((magnitude (+ (expt (realpart alpha) 2) (expt (imagpart alpha) 2)
		    (expt (realpart beta) 2) (expt (imagpart beta) 2))))
  (if (> (abs (- magnitude 1)) 2e-5)
      (error "Amplitudes do not satisfy normalization: |alpha|^2 + |beta|^2 != 1")
    (make-qubit :amplitude-zero alpha :amplitude-one beta))))

;; Function to display a qubit's state
(defun display-qubit (q)
"Display the quantu state of a qubit."
(format t "Qubit State: alpha = ~A, beta = ~A~%"
	(qubit-amplitude-zero q)
	(qubit-amplitude-one q)))

;; Example usage:
;; (let ((my-qubit (create-qubit #C(0.7071 0) #C(0.7071 0))))
;; (display-qubit my-qubit))

(defun pauli-x (input-qubit)
  "Applies the Pauli-X operation to a qubit."
  (let ((new-amplitude-zero (qubit-amplitude-one input-qubit))
        (new-amplitude-one (qubit-amplitude-zero input-qubit)))
    (make-qubit :amplitude-zero new-amplitude-zero
                :amplitude-one new-amplitude-one)))

;; Example Pauli-X Gate usage:
;;(let ((initial-qubit (make-qubit :amplitude-zero #C(1 0) :amplitude-one #C(0 0))))
 ;; (let ((result (pauli-x initial-qubit)))
  ;;  (format t "After Pauli-X: |0>: ~A |1>: ~A~%"
   ;;         (qubit-amplitude-zero result)
    ;;        (qubit-amplitude-one result))))

(defun superpose (input-qubit alpha beta)
  "Creates a superposition of a qubit with given coefficients alpha and beta."
  (let ((new-amplitude-zero (+ (* alpha (qubit-amplitude-zero input-qubit))
                               (* beta (qubit-amplitude-one input-qubit))))
        (new-amplitude-one  (+ (* alpha (qubit-amplitude-one input-qubit))
                               (* beta (qubit-amplitude-zero input-qubit)))))
    (make-qubit :amplitude-zero new-amplitude-zero
                :amplitude-one new-amplitude-one)))

;; Example Superposition Usage: 
;;(let ((initial-qubit (make-qubit :amplitude-zero #C(1 0) :amplitude-one #C(0 0))))
 ;; (let ((alpha #C(0.707 0))  ; Coefficient for |0>, sqrt(1/2)
  ;;      (beta  #C(0.707 0))) ; Coefficient for |1>, sqrt(1/2)
   ;; (let ((superposed-qubit (superpose initial-qubit alpha beta)))
    ;;  (format t "Superposed qubit amplitudes: |0>: ~A |1>: ~A~%"
     ;;         (qubit-amplitude-zero superposed-qubit)
      ;;        (qubit-amplitude-one superposed-qubit)))))

(defun phase-shift (input-qubit phi)
  "Applies a phase shift to the |1> amplitude of a qubit with phase phi."
  (let ((new-amplitude-zero (qubit-amplitude-zero input-qubit))
        (new-amplitude-one  (* (qubit-amplitude-one input-qubit)
                               (make-complex (cos phi) (sin phi)))))
    (make-qubit :amplitude-zero new-amplitude-zero
                :amplitude-one new-amplitude-one)))

;;(let ((initial-qubit (make-qubit :amplitude-zero #C(1 0) :amplitude-one #C(0 1))))
;;  (let ((phi (pi)))  ; Phase shift by π (180 degrees)
;;    (let ((shifted-qubit (phase-shift initial-qubit phi)))
;;      (format t "After phase shift: |0>: ~A |1>: ~A~%"
;;              (qubit-amplitude-zero shifted-qubit)
;;              (qubit-amplitude-one shifted-qubit)))))


