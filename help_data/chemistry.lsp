;; help_data/chemistry.lsp

(push (make-function-info
        :name "calculate-ideal-gas-law"
        :description "Calculate pressure, volume, moles, or temperature using the ideal gas law (PV=nRT)."
        :parameters "(p v n t)"
        :category "Chemistry"
        :example "(calculate-ideal-gas-law 101325 0.0224 nil 273.15)")
      *help-functions*)

(push (make-function-info
        :name "calculate-molarity"
        :description "Calculate the molarity of a solution."
        :parameters "(moles-solute volume-liters)"
        :category "Chemistry"
        :example "(calculate-molarity 0.5 1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-ph"
        :description "Calculate the pH of a solution from the hydrogen ion concentration."
        :parameters "(h-plus-concentration)"
        :category "Chemistry"
        :example "(calculate-ph 1e-7)")
      *help-functions*)

(push (make-function-info
        :name "calculate-poh"
        :description "Calculate the pOH of a solution from the hydroxide ion concentration."
        :parameters "(oh-minus-concentration)"
        :category "Chemistry"
        :example "(calculate-poh 1e-7)")
      *help-functions*)

(push (make-function-info
        :name "calculate-henderson-hasselbalch"
        :description "Calculate pH using the Henderson-Hasselbalch equation for buffer solutions."
        :parameters "(pka base-concentration acid-concentration)"
        :category "Chemistry"
        :example "(calculate-henderson-hasselbalch 4.76 0.1 0.1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-arrhenius-rate"
        :description "Calculate the rate constant of a reaction using the Arrhenius equation."
        :parameters "(pre-exponential-factor activation-energy temperature)"
        :category "Chemistry"
        :example "(calculate-arrhenius-rate 1e13 83140 300)")
      *help-functions*)

(push (make-function-info
        :name "calculate-gibbs-free-energy"
        :description "Calculate the change in Gibbs free energy for a reaction."
        :parameters "(delta-h delta-s temperature)"
        :category "Chemistry"
        :example "(calculate-gibbs-free-energy -92200 -198.7 298)")
      *help-functions*)

(push (make-function-info
        :name "calculate-nernst-equation"
        :description "Calculate the cell potential under non-standard conditions using the Nernst equation."
        :parameters "(standard-potential temperature moles-electrons reaction-quotient)"
        :category "Chemistry"
        :example "(calculate-nernst-equation 1.10 298 2 0.5)")
      *help-functions*)

(push (make-function-info
        :name "calculate-half-life-first-order"
        :description "Calculate the half-life of a first-order reaction."
        :parameters "(rate-constant)"
        :category "Chemistry"
        :example "(calculate-half-life-first-order 0.005)")
      *help-functions*)

(push (make-function-info
        :name "calculate-boiling-point-elevation"
        :description "Calculate the boiling point elevation of a solution."
        :parameters "(kb molality)"
        :category "Chemistry"
        :example "(calculate-boiling-point-elevation 0.512 1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-freezing-point-depression"
        :description "Calculate the freezing point depression of a solution."
        :parameters "(kf molality)"
        :category "Chemistry"
        :example "(calculate-freezing-point-depression 1.86 1)")
      *help-functions*)

;; Additional Chemistry Functions
(push (make-function-info
        :name "ideal-gas-law"
        :description "Calculate missing parameter from ideal gas law PV = nRT."
        :parameters "(pressure volume temperature moles)"
        :category "Chemistry"
        :example "(ideal-gas-law nil 22.4 273.15 1.0)")
      *help-functions*)

(push (make-function-info
        :name "boyles-law"
        :description "Calculate missing parameter using Boyle's Law: P1*V1 = P2*V2."
        :parameters "(p1 v1 p2 v2)"
        :category "Chemistry"
        :example "(boyles-law 1.0 10.0 2.0 nil)")
      *help-functions*)

(push (make-function-info
        :name "charles-law"
        :description "Calculate missing parameter using Charles' Law: V1/T1 = V2/T2."
        :parameters "(v1 t1 v2 t2)"
        :category "Chemistry"
        :example "(charles-law 10.0 300 nil 600)")
      *help-functions*)

(push (make-function-info
        :name "combined-gas-law"
        :description "Calculate missing parameter using combined gas law."
        :parameters "(p1 v1 t1 p2 v2 t2)"
        :category "Chemistry"
        :example "(combined-gas-law 1.0 10.0 300 2.0 nil 600)")
      *help-functions*)

(push (make-function-info
        :name "molarity"
        :description "Calculate molarity (M) = moles of solute / liters of solution."
        :parameters "(moles volume-liters)"
        :category "Chemistry"
        :example "(molarity 0.5 2.0)")
      *help-functions*)

(push (make-function-info
        :name "molality"
        :description "Calculate molality (m) = moles of solute / kg of solvent."
        :parameters "(moles mass-solvent-kg)"
        :category "Chemistry"
        :example "(molality 0.1 1.0)")
      *help-functions*)

(push (make-function-info
        :name "mole-fraction"
        :description "Calculate mole fraction of solute."
        :parameters "(moles-solute moles-solvent)"
        :category "Chemistry"
        :example "(mole-fraction 0.2 1.8)")
      *help-functions*)

(push (make-function-info
        :name "dilution-equation"
        :description "Calculate missing parameter using C1*V1 = C2*V2."
        :parameters "(c1 v1 c2 v2)"
        :category "Chemistry"
        :example "(dilution-equation 1.0 100 nil 500)")
      *help-functions*)

(push (make-function-info
        :name "mass-to-moles"
        :description "Convert mass (g) to moles using molecular weight."
        :parameters "(mass molecular-weight)"
        :category "Chemistry"
        :example "(mass-to-moles 18.0 18.015)")
      *help-functions*)

(push (make-function-info
        :name "henderson-hasselbalch"
        :description "Calculate pH using Henderson-Hasselbalch equation."
        :parameters "(pka conjugate-base-conc weak-acid-conc)"
        :category "Chemistry"
        :example "(henderson-hasselbalch 4.76 0.1 0.1)")
      *help-functions*)

(push (make-function-info
        :name "ph-from-hydrogen-ion"
        :description "Calculate pH from hydrogen ion concentration."
        :parameters "(hydrogen-ion-conc)"
        :category "Chemistry"
        :example "(ph-from-hydrogen-ion 1e-7)")
      *help-functions*)

(push (make-function-info
        :name "first-order-kinetics"
        :description "Calculate concentration after time t for first-order reaction."
        :parameters "(initial-conc rate-constant time)"
        :category "Chemistry"
        :example "(first-order-kinetics 1.0 0.693 1.0)")
      *help-functions*)

(push (make-function-info
        :name "half-life-first-order"
        :description "Calculate half-life for first-order reaction."
        :parameters "(rate-constant)"
        :category "Chemistry"
        :example "(half-life-first-order 0.693)")
      *help-functions*)

(push (make-function-info
        :name "gibbs-free-energy"
        :description "Calculate Gibbs free energy: DeltaG = DeltaH - T*DeltaS."
        :parameters "(enthalpy entropy temperature)"
        :category "Chemistry"
        :example "(gibbs-free-energy -100000 -50 298)")
      *help-functions*)

(push (make-function-info
        :name "nernst-equation"
        :description "Calculate cell potential using Nernst equation."
        :parameters "(standard-potential electron-count reaction-quotient temperature)"
        :category "Chemistry"
        :example "(nernst-equation 1.1 2 0.1 298)")
      *help-functions*)

(push (make-function-info
        :name "beer-lambert-law"
        :description "Calculate absorbance using Beer-Lambert law: A = epsilon*l*c."
        :parameters "(molar-absorptivity path-length concentration)"
        :category "Chemistry"
        :example "(beer-lambert-law 1000 1.0 0.001)")
      *help-functions*)

(push (make-function-info
        :name "bragg-law"
        :description "Calculate missing parameter from Bragg's law: n*lambda = 2d*sin(theta)."
        :parameters "(n wavelength d-spacing theta)"
        :category "Chemistry"
        :example "(bragg-law 1 nil 2.5e-10 0.5236)")
      *help-functions*)

;;; Electron Orbital Visualization

(push (make-function-info
        :name "associated-laguerre"
        :description "Compute the associated Laguerre polynomial L_n^alpha(x) using recurrence."
        :parameters "(n alpha x)"
        :category "Chemistry"
        :example "(associated-laguerre 2 1 1.0)")
      *help-functions*)

(push (make-function-info
        :name "associated-legendre"
        :description "Compute the associated Legendre polynomial P_l^m(x) for m >= 0."
        :parameters "(l m x)"
        :category "Chemistry"
        :example "(associated-legendre 2 1 0.5)")
      *help-functions*)

(push (make-function-info
        :name "spherical-harmonic-real"
        :description "Compute real-valued spherical harmonic Y_l^m(theta, phi) for orbital visualization."
        :parameters "(l m theta phi)"
        :category "Chemistry"
        :example "(spherical-harmonic-real 1 0 0.5 0.0)")
      *help-functions*)

(push (make-function-info
        :name "radial-wavefunction"
        :description "Compute the radial wavefunction R_nl(r) for a hydrogen-like atom in Bohr radii."
        :parameters "(n l r)"
        :category "Chemistry"
        :example "(radial-wavefunction 2 1 1.0)")
      *help-functions*)

(push (make-function-info
        :name "hydrogen-wavefunction-squared"
        :description "Compute |psi_nlm|^2 probability density for a hydrogen atom at (r, theta, phi)."
        :parameters "(n l m r theta phi)"
        :category "Chemistry"
        :example "(hydrogen-wavefunction-squared 1 0 0 1.0 0.5 0.0)")
      *help-functions*)

(push (make-function-info
        :name "generate-orbital-points"
        :description "Generate 3D point cloud for hydrogen orbital (n,l,m) via rejection sampling. Returns (xs ys zs)."
        :parameters "(n l m &optional num-points)"
        :category "Chemistry"
        :example "(generate-orbital-points 2 1 0 500)")
      *help-functions*)

(push (make-function-info
        :name "orbital-label"
        :description "Generate a human-readable label (e.g. '2p (m=0)') for an orbital."
        :parameters "(n l m)"
        :category "Chemistry"
        :example "(orbital-label 3 2 0)")
      *help-functions*)

(push (make-function-info
        :name "plot-electron-orbital"
        :description "Plot an electron orbital as a 3D spin-plot point cloud. Supports s,p,d,f orbitals with any valid orientation."
        :parameters "(n l m &optional num-points)"
        :category "Chemistry"
        :example "(plot-electron-orbital 2 1 0)")
      *help-functions*)
