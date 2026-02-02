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