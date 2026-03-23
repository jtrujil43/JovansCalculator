;; my-chemistry.lsp
;; Chemical formula's for Jovan's Calculator
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core
;; Arizona State University
;; Created: 2/2/2026

;; Physical constants
(defconstant avogadro-number 6.02214076e23)  ; Avogadro's number (mol^-1)
(defconstant gas-constant 8.314462618)       ; Universal gas constant (J/(mol*K))
(defconstant gas-constant-atm 0.08206)       ; Gas constant in L*atm/(mol*K)
(defconstant faraday-constant 96485.33212)   ; Faraday constant (C/mol)
(defconstant atomic-mass-unit 1.66053906660e-27) ; Atomic mass unit (kg)
(defconstant planck-constant-chem 6.62607015e-34) ; Planck constant (J*s)

;; Thermodynamics and Gas Laws

(defun ideal-gas-law (pressure volume temperature moles)
  "Calculate one missing parameter from PV = nRT."
  (cond
    ((null pressure) (/ (* moles gas-constant-atm temperature) volume))
    ((null volume) (/ (* moles gas-constant-atm temperature) pressure))
    ((null temperature) (/ (* pressure volume) (* moles gas-constant-atm)))
    ((null moles) (/ (* pressure volume) (* gas-constant-atm temperature)))
    (t (list :P pressure :V volume :n moles :T temperature))))

(defun boyles-law (p1 v1 p2 v2)
  "Calculate missing parameter using Boyle's Law: P1*V1 = P2*V2."
  (cond
    ((null p2) (/ (* p1 v1) v2))
    ((null v2) (/ (* p1 v1) p2))
    ((null p1) (/ (* p2 v2) v1))
    ((null v1) (/ (* p2 v2) p1))
    (t (* p1 v1))))

(defun charles-law (v1 t1 v2 t2)
  "Calculate missing parameter using Charles' Law: V1/T1 = V2/T2."
  (cond
    ((null v2) (/ (* v1 t2) t1))
    ((null t2) (/ (* v2 t1) v1))
    ((null v1) (/ (* v2 t1) t2))
    ((null t1) (/ (* v1 t2) v2))
    (t (/ v1 t1))))

(defun combined-gas-law (p1 v1 t1 p2 v2 t2)
  "Calculate missing parameter using combined gas law: (P1*V1)/T1 = (P2*V2)/T2."
  (cond
    ((null p2) (/ (* p1 v1 t2) (* v2 t1)))
    ((null v2) (/ (* p1 v1 t2) (* p2 t1)))
    ((null t2) (/ (* p2 v2 t1) (* p1 v1)))
    ((null p1) (/ (* p2 v2 t1) (* v1 t2)))
    ((null v1) (/ (* p2 v2 t1) (* p1 t2)))
    ((null t1) (/ (* p1 v1) (* p2 v2 t2)))
    (t (/ (* p1 v1) t1))))

;; Solution Chemistry

(defun molarity (moles volume-liters)
  "Calculate molarity (M) = moles of solute / liters of solution."
  (/ moles volume-liters))

(defun molality (moles mass-solvent-kg)
  "Calculate molality (m) = moles of solute / kg of solvent."
  (/ moles mass-solvent-kg))

(defun mole-fraction (moles-solute moles-solvent)
  "Calculate mole fraction of solute."
  (/ moles-solute (+ moles-solute moles-solvent)))

(defun dilution-equation (c1 v1 c2 v2)
  "Calculate missing parameter using C1*V1 = C2*V2."
  (cond
    ((null c2) (/ (* c1 v1) v2))
    ((null v2) (/ (* c1 v1) c2))
    ((null c1) (/ (* c2 v2) v1))
    ((null v1) (/ (* c2 v2) c1))
    (t (* c1 v1))))

(defun mass-to-moles (mass molecular-weight)
  "Convert mass (g) to moles using molecular weight."
  (/ mass molecular-weight))

(defun moles-to-mass (moles molecular-weight)
  "Convert moles to mass (g) using molecular weight."
  (* moles molecular-weight))

;; Equilibrium Chemistry

(defun equilibrium-constant (products reactants)
  "Calculate equilibrium constant Keq = [products]/[reactants]."
  (/ (apply #'* products) (apply #'* reactants)))

(defun henderson-hasselbalch (pka conjugate-base-conc weak-acid-conc)
  "Calculate pH using Henderson-Hasselbalch equation."
  (+ pka (log (/ conjugate-base-conc weak-acid-conc) 10)))

(defun ph-from-hydrogen-ion (hydrogen-ion-conc)
  "Calculate pH from hydrogen ion concentration."
  (- (log hydrogen-ion-conc 10)))

(defun hydrogen-ion-from-ph (ph)
  "Calculate hydrogen ion concentration from pH."
  (expt 10 (- ph)))

(defun poh-from-hydroxide-ion (hydroxide-ion-conc)
  "Calculate pOH from hydroxide ion concentration."
  (- (log hydroxide-ion-conc 10)))

(defun ph-poh-relation (ph-or-poh &optional (water-temp 25))
  "Calculate pH from pOH or vice versa using pH + pOH = 14 (at 25°C)."
  (- 14 ph-or-poh))

;; Kinetics

(defun first-order-kinetics (initial-conc rate-constant time)
  "Calculate concentration after time t for first-order reaction."
  (* initial-conc (exp (- (* rate-constant time)))))

(defun half-life-first-order (rate-constant)
  "Calculate half-life for first-order reaction."
  (/ (log 2) rate-constant))

(defun arrhenius-equation (pre-exponential activation-energy temperature)
  "Calculate rate constant using Arrhenius equation."
  (* pre-exponential (exp (/ (- activation-energy) (* gas-constant temperature)))))

;; Thermochemistry

(defun gibbs-free-energy (enthalpy entropy temperature)
  "Calculate Gibbs free energy: ΔG = ΔH - TΔS."
  (- enthalpy (* temperature entropy)))

(defun equilibrium-from-gibbs (gibbs-energy temperature)
  "Calculate equilibrium constant from Gibbs free energy."
  (exp (/ (- gibbs-energy) (* gas-constant temperature))))

(defun heat-capacity-temperature (heat-capacity mass delta-temp)
  "Calculate heat transfer using q = mcΔT."
  (* mass heat-capacity delta-temp))

(defun enthalpy-combustion (moles-fuel enthalpy-per-mole)
  "Calculate total enthalpy of combustion."
  (* moles-fuel enthalpy-per-mole))

;; Electrochemistry

(defun nernst-equation (standard-potential electron-count reaction-quotient temperature)
  "Calculate cell potential using Nernst equation."
  (- standard-potential (/ (* gas-constant temperature (log reaction-quotient))
                          (* electron-count faraday-constant))))

(defun faradays-law (current time electron-count)
  "Calculate moles of substance produced by electrolysis."
  (/ (* current time) (* electron-count faraday-constant)))

(defun cell-potential (cathode-potential anode-potential)
  "Calculate standard cell potential."
  (- cathode-potential anode-potential))

;; Atomic and Molecular

(defun molecular-weight (atomic-weights atom-counts)
  "Calculate molecular weight from atomic weights and atom counts."
  (apply #'+ (mapcar #'* atomic-weights atom-counts)))

(defun empirical-formula-mass (element-masses)
  "Calculate empirical formula mass."
  (apply #'+ element-masses))

(defun percent-composition (element-mass total-mass)
  "Calculate percent composition of an element in a compound."
  (* (/ element-mass total-mass) 100))

(defun density-gas (molecular-weight pressure temperature)
  "Calculate gas density using ideal gas law."
  (/ (* molecular-weight pressure) (* gas-constant-atm temperature)))

;; Spectroscopy and Energy

(defun photon-energy-chemistry (wavelength-nm)
  "Calculate photon energy in eV from wavelength in nanometers."
  (let ((wavelength-m (* wavelength-nm 1e-9))
        (c-speed 2.998e8)
        (h-planck 6.626e-34)
        (eV-conversion 1.602e-19))
    (/ (* h-planck c-speed) (* wavelength-m eV-conversion))))

(defun beer-lambert-law (molar-absorptivity path-length concentration)
  "Calculate absorbance using Beer-Lambert law: A = εlc."
  (* molar-absorptivity path-length concentration))

(defun concentration-from-absorbance (absorbance molar-absorptivity path-length)
  "Calculate concentration from absorbance measurement."
  (/ absorbance (* molar-absorptivity path-length)))

;; Crystallography

(defun bragg-law (n wavelength d-spacing theta)
  "Calculate missing parameter from Bragg's law: nλ = 2d sinθ."
  (cond
    ((null wavelength) (/ (* 2 d-spacing (sin theta)) n))
    ((null d-spacing) (/ (* n wavelength) (* 2 (sin theta))))
    ((null theta) (asin (/ (* n wavelength) (* 2 d-spacing))))
    ((null n) (/ (* 2 d-spacing (sin theta)) wavelength))
    (t (* 2 d-spacing (sin theta)))))

;; Example usage:
;; (ideal-gas-law nil 22.4 273.15 1.0)  ; Calculate pressure for STP conditions
;; (molarity 0.5 2.0)                   ; 0.25 M solution
;; (henderson-hasselbalch 4.76 0.1 0.1)  ; pH of acetate buffer
;; (half-life-first-order 0.693)        ; t1/2 = 1.0 time units

;;; ============================================================
;;; ELECTRON ORBITAL 3D POINT CLOUD VISUALIZATION
;;; ============================================================
;;; Plots hydrogen-like electron orbitals as 3D point clouds
;;; using the full quantum mechanical wavefunctions with
;;; principal quantum number n, orbital quantum number l,
;;; and magnetic quantum number m.

;; Bohr radius in angstroms for visualization
(defconstant bohr-radius-angstrom 0.529177)

(defun factorial (n)
  "Compute n! for non-negative integer n."
  (if (<= n 1) 1
    (let ((result 1))
      (dotimes (i n result)
        (setf result (* result (1+ i)))))))

(defun associated-laguerre (n alpha x)
  "Compute the associated Laguerre polynomial L_n^alpha(x)
   using the recurrence relation."
  (cond
    ((= n 0) 1.0)
    ((= n 1) (- (+ 1.0 alpha) x))
    (t (let ((l0 1.0)
             (l1 (- (+ 1.0 alpha) x))
             (lk 0.0))
         (do ((k 2 (1+ k)))
             ((> k n) lk)
           (setf lk (/ (- (* (+ (* 2 (1- k)) alpha 1 (- x)) l1)
                           (* (+ (1- k) alpha) l0))
                        k))
           (setf l0 l1)
           (setf l1 lk))))))

(defun associated-legendre (l m x)
  "Compute the associated Legendre polynomial P_l^m(x) for m >= 0.
   Uses the recurrence relation for numerical stability."
  (let ((m (abs m)))
    (cond
      ((> m l) 0.0)
      (t
       ;; Start with P_m^m
       (let ((pmm 1.0))
         (when (> m 0)
           (let ((somx2 (sqrt (- 1.0 (* x x)))))
             (let ((fact 1.0))
               (dotimes (i m)
                 (setf pmm (* pmm (- fact) somx2))
                 (setf fact (+ fact 2.0))))))
         (if (= l m)
             pmm
           ;; Compute P_{m+1}^m
           (let ((pmm1 (* x (+ (* 2.0 m) 1.0) pmm)))
             (if (= l (1+ m))
                 pmm1
               ;; Use recurrence for higher l
               (let ((pll 0.0))
                 (do ((ll (+ m 2) (1+ ll)))
                     ((> ll l) pll)
                   (setf pll (/ (- (* (- (* 2.0 ll) 1.0) x pmm1)
                                   (* (+ ll m -1.0) pmm))
                                (- ll m)))
                   (setf pmm pmm1)
                   (setf pmm1 pll)))))))))))

(defun spherical-harmonic-real (l m theta phi)
  "Compute the real-valued spherical harmonic Y_l^m(theta, phi).
   Returns the real part for m > 0, imaginary part for m < 0, 
   and the standard Y_l^0 for m = 0.
   theta is polar angle from z-axis, phi is azimuthal angle."
  (let* ((abs-m (abs m))
         ;; Normalization factor
         (norm (sqrt (* (/ (+ (* 2.0 l) 1.0) (* 4.0 pi))
                        (/ (float (factorial (- l abs-m)))
                           (float (factorial (+ l abs-m)))))))
         ;; Associated Legendre polynomial
         (plm (associated-legendre l abs-m (cos theta))))
    (cond
      ((> m 0) (* norm plm (sqrt 2.0) (cos (* m phi))))
      ((< m 0) (* norm plm (sqrt 2.0) (sin (* abs-m phi))))
      (t (* norm plm)))))

(defun radial-wavefunction (n l r)
  "Compute the radial wavefunction R_nl(r) for hydrogen-like atom.
   r is in units of Bohr radii (a0).
   R_nl(r) = N * (2r/n)^l * exp(-r/n) * L_{n-l-1}^{2l+1}(2r/n)
   where N is the normalization constant."
  (let* ((rho (/ (* 2.0 r) n))
         ;; Normalization
         (norm (sqrt (* (/ 8.0 (* n n n))
                        (/ (float (factorial (- n l 1)))
                           (* 2.0 n (float (expt (factorial (+ n l)) 3)))))))
         ;; Note: correct normalization for hydrogen radial function
         (norm2 (sqrt (* (expt (/ 2.0 n) 3)
                         (/ (float (factorial (- n l 1)))
                            (* 2.0 n (float (expt (factorial (+ n l)) 3)))))))
         ;; Associated Laguerre polynomial
         (laguerre (associated-laguerre (- n l 1) (+ (* 2 l) 1) rho)))
    ;; R_nl = norm * rho^l * exp(-rho/2) * L
    (* norm2 (expt rho l) (exp (/ (- rho) 2.0)) laguerre)))

(defun hydrogen-wavefunction-squared (n l m r theta phi)
  "Compute |psi_nlm(r, theta, phi)|^2 for a hydrogen atom.
   r in units of Bohr radii, theta and phi in radians.
   Returns the probability density."
  (let* ((radial (radial-wavefunction n l r))
         (angular (spherical-harmonic-real l m theta phi)))
    (* radial radial angular angular)))

(defun orbital-max-radius (n)
  "Estimate a reasonable maximum radius for sampling orbital n (in Bohr radii).
   Uses roughly 4*n^2 Bohr radii to capture most of the probability density."
  (* 4.0 n n))

(defun estimate-max-density (n l m &optional (n-samples 5000))
  "Estimate the maximum probability density for orbital (n,l,m)
   by sampling random points and finding the maximum."
  (let ((max-density 0.0)
        (r-max (orbital-max-radius n)))
    (dotimes (i n-samples max-density)
      (let* ((r (* (random 1.0) r-max))
             (theta (* (random 1.0) pi))
             (phi (* (random 1.0) 2.0 pi))
             (density (* (hydrogen-wavefunction-squared n l m r theta phi)
                         r r (sin theta))))
        (when (> density max-density)
          (setf max-density density))))))

(defun generate-orbital-points (n l m &optional (num-points 2000))
  "Generate 3D point cloud for hydrogen orbital (n, l, m) using rejection sampling.
   Returns three lists (xs ys zs) of Cartesian coordinates in Bohr radii.
   n = principal quantum number (1, 2, 3, ...)
   l = orbital angular momentum quantum number (0 to n-1)
       l=0: s orbital, l=1: p orbital, l=2: d orbital, l=3: f orbital
   m = magnetic quantum number (-l to +l)
       determines orientation of the orbital"
  ;; Validate quantum numbers
  (when (< n 1)
    (error "Principal quantum number n must be >= 1, got ~a" n))
  (when (or (< l 0) (>= l n))
    (error "Orbital quantum number l must be 0 <= l < n, got l=~a for n=~a" l n))
  (when (or (< m (- l)) (> m l))
    (error "Magnetic quantum number m must be -l <= m <= l, got m=~a for l=~a" m l))
  (let* ((r-max (orbital-max-radius n))
         ;; Estimate max density for rejection sampling envelope
         (max-density (* 1.2 (estimate-max-density n l m 10000)))
         (xs '()) (ys '()) (zs '())
         (accepted 0)
         (max-attempts (* num-points 500)))
    ;; Safety: if max-density is 0, bump it
    (when (< max-density 1e-30)
      (setf max-density 1e-10))
    (do ((attempt 0 (1+ attempt)))
        ((or (>= accepted num-points) (>= attempt max-attempts)))
      ;; Sample uniformly in spherical coordinates with r^2 sin(theta) weighting
      (let* ((r (* (expt (random 1.0) (/ 1.0 3.0)) r-max))
             (cos-theta (- (* 2.0 (random 1.0)) 1.0))
             (theta (acos cos-theta))
             (phi (* (random 1.0) 2.0 pi))
             ;; Probability density weighted by volume element
             (density (* (hydrogen-wavefunction-squared n l m r theta phi)
                         r r))
             ;; Rejection test
             (threshold (* (random 1.0) max-density)))
        (when (< threshold density)
          ;; Convert to Cartesian coordinates
          (let* ((sin-theta (sin theta))
                 (x (* r sin-theta (cos phi)))
                 (y (* r sin-theta (sin phi)))
                 (z (* r cos-theta)))
            (push x xs)
            (push y ys)
            (push z zs)
            (incf accepted)))))
    (list (reverse xs) (reverse ys) (reverse zs))))

(defun orbital-label (n l m)
  "Generate a human-readable label for an orbital given quantum numbers."
  (let ((subshell-names '("s" "p" "d" "f" "g" "h" "i")))
    (format nil "~a~a (m=~a)" n (nth l subshell-names) m)))

(defun plot-electron-orbital (n l m &optional (num-points 2000))
  "Plot an electron orbital as a 3D point cloud using XLisp-Stat's spin-plot.
   n = principal quantum number (1, 2, 3, ...)
   l = angular momentum quantum number (0 to n-1)
       0=s, 1=p, 2=d, 3=f
   m = magnetic quantum number (-l to +l)
       determines spatial orientation
   num-points = number of points to generate (default 2000)

   Examples:
     (plot-electron-orbital 1 0 0)        ; 1s orbital (spherical)
     (plot-electron-orbital 2 0 0)        ; 2s orbital (spherical with node)
     (plot-electron-orbital 2 1 0)        ; 2p_z orbital (dumbbell along z)
     (plot-electron-orbital 2 1 1)        ; 2p_x orbital (dumbbell along x)
     (plot-electron-orbital 2 1 -1)       ; 2p_y orbital (dumbbell along y)
     (plot-electron-orbital 3 2 0)        ; 3d_z2 orbital
     (plot-electron-orbital 3 2 1)        ; 3d_xz orbital
     (plot-electron-orbital 3 2 -1)       ; 3d_yz orbital
     (plot-electron-orbital 3 2 2)        ; 3d_(x2-y2) orbital
     (plot-electron-orbital 3 2 -2)       ; 3d_xy orbital
     (plot-electron-orbital 4 3 0)        ; 4f orbital"
  (format t "~%Generating ~a orbital with ~a points...~%" (orbital-label n l m) num-points)
  (let* ((points (generate-orbital-points n l m num-points))
         (xs (first points))
         (ys (second points))
         (zs (third points))
         (actual-pts (length xs))
         (label (format nil "Electron Orbital ~a" (orbital-label n l m))))
    (format t "Generated ~a points for ~a orbital~%" actual-pts (orbital-label n l m))
    (format t "Quantum numbers: n=~a, l=~a, m=~a~%" n l m)
    (let ((plot (spin-plot (list xs ys zs) :title label)))
      (send plot :variable-label '(0 1 2) (list "x (a0)" "y (a0)" "z (a0)"))
      plot)))