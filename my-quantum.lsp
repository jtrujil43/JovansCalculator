

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

;; Additional physical constants
(defconstant gravitational-constant 6.67430e-11) ; G in m³/(kg⋅s²)
(defconstant permittivity-vacuum 8.8541878128e-12) ; ε₀ in F/m
(defconstant permeability-vacuum 1.25663706212e-6) ; μ₀ in H/m

;; ============================================================
;; Functions for hydrogen-like atoms (with atomic number Z)
;; ============================================================

(defun calculate-bohr-radius (n z)
  "Calculate the Bohr radius for a hydrogen-like atom with atomic number z."
  (let ((a0 5.29177210903e-11)) ; Bohr radius in meters
    (/ (* a0 n n) z)))

(defun calculate-energy-level (n z)
  "Calculate the energy level of a hydrogen-like atom (in eV)."
  (let ((rydberg-energy 13.6)) ; eV
    (/ (* (- rydberg-energy) z z) (* n n))))

;; ============================================================
;; Photon calculations
;; ============================================================

(defun calculate-photon-energy (wavelength)
  "Calculate the energy of a photon given its wavelength (in meters). Returns energy in Joules."
  (/ (* planck-constant c-light) wavelength))

(defun calculate-photon-wavelength (energy)
  "Calculate the wavelength of a photon given its energy (in Joules). Returns wavelength in meters."
  (/ (* planck-constant c-light) energy))

(defun calculate-de-broglie-wavelength (mass velocity)
  "Calculate the de Broglie wavelength of a particle given mass and velocity."
  (/ planck-constant (* mass velocity)))

;; ============================================================
;; Tunneling probability (alternative formulation)
;; ============================================================

(defun calculate-tunneling-probability (v0 e width mass)
  "Calculate the tunneling probability of a particle through a barrier.
   v0 = barrier height (Joules), e = particle energy (Joules), 
   width = barrier width (meters), mass = particle mass (kg)."
  (if (>= e v0)
      1.0  ; Classical case - particle has enough energy
      (let* ((kappa (sqrt (/ (* 2 mass (- v0 e)) (* reduced-planck reduced-planck))))
             (exponent (* -2 kappa width)))
        (exp exponent))))

;; ============================================================
;; Electromagnetic functions
;; ============================================================

(defun calculate-coulomb-force (q1 q2 r)
  "Calculate the Coulomb force between two point charges.
   q1, q2 = charges (Coulombs), r = distance (meters). Returns force in Newtons."
  (let ((k (/ 1 (* 4 pi permittivity-vacuum))))
    (/ (* k q1 q2) (* r r))))

(defun calculate-electric-field (q r)
  "Calculate the electric field due to a point charge.
   q = charge (Coulombs), r = distance (meters). Returns field in V/m."
  (let ((k (/ 1 (* 4 pi permittivity-vacuum))))
    (/ (* k q) (* r r))))

(defun calculate-magnetic-field (current distance)
  "Calculate the magnetic field due to a long current-carrying wire.
   current = current (Amperes), distance = distance from wire (meters). Returns field in Tesla."
  (/ (* permeability-vacuum current) (* 2 pi distance)))

(defun calculate-lorentz-force (q e-field v b-field)
  "Calculate the Lorentz force on a charged particle.
   q = charge, e-field = (Ex Ey Ez), v = (vx vy vz), b-field = (Bx By Bz).
   Returns force as (Fx Fy Fz)."
  (let* ((ex (first e-field)) (ey (second e-field)) (ez (third e-field))
         (vx (first v)) (vy (second v)) (vz (third v))
         (bx (first b-field)) (by (second b-field)) (bz (third b-field))
         ;; v × B cross product
         (cross-x (- (* vy bz) (* vz by)))
         (cross-y (- (* vz bx) (* vx bz)))
         (cross-z (- (* vx by) (* vy bx)))
         ;; F = q(E + v × B)
         (fx (* q (+ ex cross-x)))
         (fy (* q (+ ey cross-y)))
         (fz (* q (+ ez cross-z))))
    (list fx fy fz)))

(defun calculate-compton-wavelength (mass)
  "Calculate the Compton wavelength of a particle. λc = h/(mc)"
  (/ planck-constant (* mass c-light)))

;; ============================================================
;; Fundamental constants calculations
;; ============================================================

(defun calculate-rydberg-constant (atomic-mass)
  "Calculate the Rydberg constant for a given atomic mass (in atomic mass units)."
  (let* ((amu 1.66053906660e-27) ; atomic mass unit in kg
         (m-nucleus (* atomic-mass amu))
         (reduced-mass (/ (* electron-mass m-nucleus) (+ electron-mass m-nucleus)))
         (r-infinity 10973731.568160)) ; Rydberg constant for infinite mass
    (* r-infinity (/ reduced-mass electron-mass))))

(defun calculate-fine-structure-constant ()
  "Calculate the fine-structure constant α ≈ 1/137."
  (/ (* elementary-charge elementary-charge)
     (* 4 pi permittivity-vacuum reduced-planck c-light)))

(defun calculate-planck-length ()
  "Calculate the Planck length √(ℏG/c³)."
  (sqrt (/ (* reduced-planck gravitational-constant)
           (* c-light c-light c-light))))

(defun calculate-planck-mass ()
  "Calculate the Planck mass √(ℏc/G)."
  (sqrt (/ (* reduced-planck c-light) gravitational-constant)))

(defun calculate-planck-time ()
  "Calculate the Planck time √(ℏG/c⁵)."
  (sqrt (/ (* reduced-planck gravitational-constant)
           (* c-light c-light c-light c-light c-light))))

(defun calculate-planck-temperature ()
  "Calculate the Planck temperature √(ℏc⁵/(G k²))."
  (/ (calculate-planck-mass) 
     (/ boltzmann-k (* c-light c-light))))

;; ============================================================
;; Gravitational and astrophysics functions
;; ============================================================

(defun calculate-schwarzschild-radius (mass)
  "Calculate the Schwarzschild radius of a black hole. rs = 2GM/c²"
  (/ (* 2 gravitational-constant mass) (* c-light c-light)))

(defun calculate-hawking-temperature (mass)
  "Calculate the Hawking temperature of a black hole."
  (/ (* reduced-planck c-light c-light c-light)
     (* 8 pi gravitational-constant mass boltzmann-k)))

(defun calculate-gravitational-force (m1 m2 r)
  "Calculate the gravitational force between two masses.
   m1, m2 = masses (kg), r = distance (meters). Returns force in Newtons."
  (/ (* gravitational-constant m1 m2) (* r r)))

(defun calculate-gravitational-potential-energy (m1 m2 r)
  "Calculate the gravitational potential energy of two masses.
   Returns energy in Joules (negative value)."
  (- (/ (* gravitational-constant m1 m2) r)))

(defun calculate-escape-velocity (mass radius)
  "Calculate the escape velocity from a celestial body.
   mass = mass of body (kg), radius = radius (meters). Returns velocity in m/s."
  (sqrt (/ (* 2 gravitational-constant mass) radius)))

(defun calculate-orbital-velocity (mass radius altitude)
  "Calculate the orbital velocity of a satellite.
   mass = central body mass (kg), radius = body radius (m), altitude = orbit altitude (m)."
  (sqrt (/ (* gravitational-constant mass) (+ radius altitude))))

;; ============================================================
;; Special relativity functions
;; ============================================================

(defun calculate-time-dilation (velocity)
  "Calculate the time dilation factor γ for a given velocity (as fraction of c).
   velocity should be between 0 and 1 (e.g., 0.99 for 99% speed of light)."
  (/ 1 (sqrt (- 1 (* velocity velocity)))))

(defun calculate-length-contraction (length velocity)
  "Calculate the contracted length for a given proper length and velocity.
   velocity should be as fraction of c."
  (* length (sqrt (- 1 (* velocity velocity)))))

(defun calculate-relativistic-mass (mass velocity)
  "Calculate the relativistic mass for a given rest mass and velocity.
   velocity should be as fraction of c."
  (* mass (calculate-time-dilation velocity)))

(defun calculate-relativistic-kinetic-energy (mass velocity)
  "Calculate the relativistic kinetic energy for a given rest mass and velocity.
   velocity should be as fraction of c. Returns energy in Joules."
  (let ((gamma (calculate-time-dilation velocity)))
    (* mass c-light c-light (- gamma 1))))

(defun calculate-mass-energy-equivalence (mass)
  "Calculate the energy equivalent of a given mass using E = mc². Returns energy in Joules."
  (* mass c-light c-light))

;; ============================================================
;; Pauli matrices and braiding operations
;; ============================================================

(defun pauli-matrices ()
  "Return the three Pauli matrices as a list of 2x2 arrays.
   Returns (σx σy σz)."
  (let ((sigma-x (make-array '(2 2) :initial-contents '((0 1) (1 0))))
        (sigma-y (make-array '(2 2) :initial-contents 
                             (list (list #C(0 0) #C(0 -1)) 
                                   (list #C(0 1) #C(0 0)))))
        (sigma-z (make-array '(2 2) :initial-contents '((1 0) (0 -1)))))
    (list sigma-x sigma-y sigma-z)))

(defun braiding-matrix (sigma)
  "Generate braiding matrix for non-Abelian anyon statistics.
   sigma = 1, 2, or 3 selects which Pauli matrix to use.
   Returns R = exp(i π σ/4)."
  (let* ((paulis (pauli-matrices))
         (pauli-mat (nth (1- sigma) paulis))
         (phase (/ pi 4))
         (result (make-array '(2 2))))
    ;; For σ₁ (sigma-x): R = (1/√2)(I + iσx)
    ;; For σ₂ (sigma-y): R = (1/√2)(I + iσy)  
    ;; For σ₃ (sigma-z): R = (1/√2)(I + iσz)
    (let ((scale (/ 1 (sqrt 2))))
      (cond
        ((= sigma 1)
         ;; R = (1/√2)(I + iσx) = (1/√2)((1 i)(i 1))
         (setf (aref result 0 0) (make-complex scale 0))
         (setf (aref result 0 1) (make-complex 0 scale))
         (setf (aref result 1 0) (make-complex 0 scale))
         (setf (aref result 1 1) (make-complex scale 0)))
        ((= sigma 2)
         ;; R = (1/√2)(I + iσy) = (1/√2)((1 1)(-1 1))
         (setf (aref result 0 0) (make-complex scale 0))
         (setf (aref result 0 1) (make-complex scale 0))
         (setf (aref result 1 0) (make-complex (- scale) 0))
         (setf (aref result 1 1) (make-complex scale 0)))
        ((= sigma 3)
         ;; R = (1/√2)(I + iσz) = (1/√2)((1+i 0)(0 1-i))
         (setf (aref result 0 0) (make-complex scale scale))
         (setf (aref result 0 1) (make-complex 0 0))
         (setf (aref result 1 0) (make-complex 0 0))
         (setf (aref result 1 1) (make-complex scale (- scale))))))
    result))

(defun matrix-2x2-multiply (a b)
  "Multiply two 2x2 matrices."
  (let ((result (make-array '(2 2))))
    (dotimes (i 2)
      (dotimes (j 2)
        (setf (aref result i j)
              (+ (* (aref a i 0) (aref b 0 j))
                 (* (aref a i 1) (aref b 1 j))))))
    result))

(defun simulate-braiding ()
  "Simulate braiding operations in non-Abelian anyon systems.
   Demonstrates that braiding matrices do not commute (non-Abelian property)."
  (let* ((r1 (braiding-matrix 1))
         (r2 (braiding-matrix 2))
         (r1-r2 (matrix-2x2-multiply r1 r2))
         (r2-r1 (matrix-2x2-multiply r2 r1)))
    (format t "Braiding Matrix R1 (σx):~%")
    (format t "  [[~A, ~A]~%   [~A, ~A]]~%"
            (aref r1 0 0) (aref r1 0 1) (aref r1 1 0) (aref r1 1 1))
    (format t "~%Braiding Matrix R2 (σy):~%")
    (format t "  [[~A, ~A]~%   [~A, ~A]]~%"
            (aref r2 0 0) (aref r2 0 1) (aref r2 1 0) (aref r2 1 1))
    (format t "~%R1 * R2:~%")
    (format t "  [[~A, ~A]~%   [~A, ~A]]~%"
            (aref r1-r2 0 0) (aref r1-r2 0 1) (aref r1-r2 1 0) (aref r1-r2 1 1))
    (format t "~%R2 * R1:~%")
    (format t "  [[~A, ~A]~%   [~A, ~A]]~%"
            (aref r2-r1 0 0) (aref r2-r1 0 1) (aref r2-r1 1 0) (aref r2-r1 1 1))
    (format t "~%Non-Abelian property: R1*R2 ≠ R2*R1~%")
    (values r1-r2 r2-r1)))

;; Example usage:
;; (de-broglie-wavelength 1e-24)  ; wavelength for momentum = 1e-24 kg⋅m/s
;; (hydrogen-energy-level 2)      ; energy of n=2 hydrogen level
;; (tunnel-probability 1e-10 5e-19 1e-19 electron-mass)  ; tunneling probability
;; (calculate-bohr-radius 1 1)    ; Bohr radius for hydrogen ground state
;; (calculate-fine-structure-constant) ; ~1/137
;; (calculate-time-dilation 0.99)  ; time dilation at 99% speed of light
;; (simulate-braiding)            ; demonstrate non-Abelian braid statistics
