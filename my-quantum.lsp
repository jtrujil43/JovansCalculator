

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

;; Additional Quantum Mechanics Functions

;; Physical constants
(defconstant planck-constant 6.62607015e-34)  ; Planck's constant (J⋅s)
(defconstant reduced-planck 1.054571817e-34)  ; ħ = h/2π
(defconstant electron-mass 9.1093837015e-31)  ; Electron mass (kg)
(defconstant elementary-charge 1.602176634e-19) ; Elementary charge (C)
(defconstant c-light 299792458)                ; Speed of light (m/s)
(defconstant boltzmann-k 1.380649e-23)         ; Boltzmann constant (J/K)

(defun de-broglie-wavelength (momentum)
  "Calculate de Broglie wavelength given momentum."
  (/ planck-constant momentum))

(defun particle-wavelength (mass velocity)
  "Calculate de Broglie wavelength given mass and velocity."
  (/ planck-constant (* mass velocity)))

(defun photon-energy (frequency)
  "Calculate photon energy given frequency."
  (* planck-constant frequency))

(defun photon-energy-wavelength (wavelength)
  "Calculate photon energy given wavelength."
  (/ (* planck-constant c-light) wavelength))

(defun energy-frequency-relation (energy)
  "Calculate frequency from energy using E = hf."
  (/ energy planck-constant))

(defun momentum-wavelength-relation (wavelength)
  "Calculate momentum from wavelength using p = h/λ."
  (/ planck-constant wavelength))

(defun hydrogen-energy-level (n)
  "Calculate energy of hydrogen atom at principal quantum number n."
  (let ((rydberg-energy 13.6)) ; eV
    (/ (- rydberg-energy) (* n n))))

(defun hydrogen-ionization-energy (n)
  "Calculate ionization energy from level n."
  (abs (hydrogen-energy-level n)))

(defun bohr-radius (n)
  "Calculate Bohr radius for nth orbital."
  (let ((a0 5.29177210903e-11)) ; Bohr radius in meters
    (* a0 n n)))

(defun orbital-velocity (n)
  "Calculate orbital velocity of electron in nth Bohr orbit."
  (let ((alpha 7.2973525693e-3)) ; Fine structure constant
    (/ (* alpha c-light) n)))

(defun quantum-harmonic-oscillator-energy (n)
  "Calculate energy levels of quantum harmonic oscillator."
  (let ((hbar reduced-planck)
        (omega 1)) ; Angular frequency (set to 1 for normalized case)
    (* hbar omega (+ n 0.5))))

(defun particle-in-box-energy (n length mass)
  "Calculate energy levels for particle in 1D infinite square well."
  (/ (* n n planck-constant planck-constant)
     (* 8 mass length length)))

(defun tunnel-probability (barrier-width barrier-height particle-energy mass)
  "Calculate quantum tunneling probability (rectangular barrier)."
  (let* ((hbar reduced-planck)
         (k (sqrt (/ (* 2 mass (- barrier-height particle-energy))
                     (* hbar hbar))))
         (transmission (/ 1 (+ 1 (/ (* barrier-height barrier-height 
                                       (sin (* k barrier-width))
                                       (sin (* k barrier-width)))
                                   (* 4 particle-energy 
                                      (- barrier-height particle-energy)))))))
    (if (> particle-energy barrier-height)
        1.0  ; Classical case
        transmission)))

(defun wavefunction-probability (amplitude)
  "Calculate probability density |ψ|² from wavefunction amplitude."
  (let ((real-part (realpart amplitude))
        (imag-part (imagpart amplitude)))
    (+ (* real-part real-part) (* imag-part imag-part))))

(defun normalize-wavefunction (amplitudes)
  "Normalize a list of wavefunction amplitudes."
  (let ((norm-squared (apply #'+ (mapcar #'wavefunction-probability amplitudes))))
    (let ((norm (sqrt norm-squared)))
      (mapcar (lambda (amp) (/ amp norm)) amplitudes))))

(defun expectation-value (observable-matrix wavefunction)
  "Calculate expectation value ⟨ψ|Ô|ψ⟩."
  (let* ((psi-conj (mapcar #'conjugate wavefunction))
         (o-psi (matrix-vector-multiply observable-matrix wavefunction)))
    (apply #'+ (mapcar (lambda (conj val) (* conj val)) psi-conj o-psi))))

(defun matrix-vector-multiply (matrix vector)
  "Multiply a matrix by a vector (helper function)."
  (let ((result '()))
    (dotimes (i (array-dimension matrix 0) (reverse result))
      (let ((sum 0))
        (dotimes (j (array-dimension matrix 1))
          (incf sum (* (aref matrix i j) (nth j vector))))
        (push sum result)))))

(defun uncertainty-principle (delta-x delta-p)
  "Check if uncertainty principle ΔxΔp ≥ ħ/2 is satisfied."
  (let ((minimum-uncertainty (/ reduced-planck 2)))
    (values (>= (* delta-x delta-p) minimum-uncertainty)
            (* delta-x delta-p)
            minimum-uncertainty)))

(defun compton-wavelength (mass)
  "Calculate Compton wavelength λc = h/(mc)."
  (/ planck-constant (* mass c-light)))

(defun compton-scattering-wavelength (initial-wavelength theta)
  "Calculate wavelength after Compton scattering at angle theta."
  (let ((lambda-c (compton-wavelength electron-mass)))
    (+ initial-wavelength (* lambda-c (- 1 (cos theta))))))

(defun blackbody-energy-density (temperature frequency)
  "Calculate energy density for blackbody radiation at given frequency."
  (let* ((hf (* planck-constant frequency))
         (kT (* boltzmann-k temperature))
         (exponential (exp (/ hf kT))))
    (/ (* 8 pi planck-constant frequency frequency frequency)
       (* c-light c-light c-light (- exponential 1)))))

(defun wien-displacement-law (temperature)
  "Calculate peak wavelength for blackbody at given temperature."
  (let ((wien-constant 2.897771955e-3)) ; Wien displacement constant (m⋅K)
    (/ wien-constant temperature)))

(defun stefan-boltzmann-law (temperature)
  "Calculate total radiated power per unit area using Stefan-Boltzmann law."
  (let ((stefan-boltzmann-constant 5.670374419e-8)) ; W⋅m⁻²⋅K⁻⁴
    (* stefan-boltzmann-constant (expt temperature 4))))

(defun spin-eigenvalue (s ms)
  "Calculate spin eigenvalue for given spin quantum numbers."
  (* reduced-planck ms (sqrt (+ (* s s) s))))

(defun zeeman-energy (magnetic-field ms g-factor)
  "Calculate energy shift in magnetic field (Zeeman effect)."
  (let ((bohr-magneton 9.2740100783e-24)) ; Bohr magneton (J/T)
    (* (- g-factor) bohr-magneton magnetic-field ms)))

;; Example usage:
;; (de-broglie-wavelength 1e-24)  ; wavelength for momentum = 1e-24 kg⋅m/s
;; (hydrogen-energy-level 2)      ; energy of n=2 hydrogen level
;; (tunnel-probability 1e-10 5e-19 1e-19 electron-mass)  ; tunneling probability
