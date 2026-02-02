;; help_data/quantum_physics.lsp

(push (make-function-info
        :name "calculate-bohr-radius"
        :description "Calculate the Bohr radius for a hydrogen-like atom."
        :parameters "(n z)"
        :category "Quantum Physics"
        :example "(calculate-bohr-radius 1 1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-energy-level"
        :description "Calculate the energy level of a hydrogen-like atom."
        :parameters "(n z)"
        :category "Quantum Physics"
        :example "(calculate-energy-level 1 1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-photon-energy"
        :description "Calculate the energy of a photon given its wavelength."
        :parameters "(lambda)"
        :category "Quantum Physics"
        :example "(calculate-photon-energy 500e-9)")
      *help-functions*)

(push (make-function-info
        :name "calculate-photon-wavelength"
        :description "Calculate the wavelength of a photon given its energy."
        :parameters "(energy)"
        :category "Quantum Physics"
        :example "(calculate-photon-wavelength 2.48)")
      *help-functions*)

(push (make-function-info
        :name "calculate-de-broglie-wavelength"
        :description "Calculate the de Broglie wavelength of a particle."
        :parameters "(mass velocity)"
        :category "Quantum Physics"
        :example "(calculate-de-broglie-wavelength 9.109e-31 1e6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-tunneling-probability"
        :description "Calculate the tunneling probability of a particle through a barrier."
        :parameters "(v0 e width mass)"
        :category "Quantum Physics"
        :example "(calculate-tunneling-probability 10 5 1e-10 9.109e-31)")
      *help-functions*)

(push (make-function-info
        :name "calculate-coulomb-force"
        :description "Calculate the Coulomb force between two point charges."
        :parameters "(q1 q2 r)"
        :category "Quantum Physics"
        :example "(calculate-coulomb-force 1.602e-19 -1.602e-19 5.29e-11)")
      *help-functions*)

(push (make-function-info
        :name "calculate-electric-field"
        :description "Calculate the electric field due to a point charge."
        :parameters "(q r)"
        :category "Quantum Physics"
        :example "(calculate-electric-field 1.602e-19 5.29e-11)")
      *help-functions*)

(push (make-function-info
        :name "calculate-magnetic-field"
        :description "Calculate the magnetic field due to a current-carrying wire."
        :parameters "(current distance)"
        :category "Quantum Physics"
        :example "(calculate-magnetic-field 1 0.1)")
      *help-functions*)

(push (make-function-info
        :name "calculate-lorentz-force"
        :description "Calculate the Lorentz force on a charged particle in electric and magnetic fields."
        :parameters "(q e v b)"
        :category "Quantum Physics"
        :example "(calculate-lorentz-force 1.602e-19 (list 1e5 0 0) (list 0 1e6 0) (list 0 0 0.1))")
      *help-functions*)

(push (make-function-info
        :name "calculate-compton-wavelength"
        :description "Calculate the Compton wavelength of a particle."
        :parameters "(mass)"
        :category "Quantum Physics"
        :example "(calculate-compton-wavelength 9.109e-31)")
      *help-functions*)

(push (make-function-info
        :name "calculate-rydberg-constant"
        :description "Calculate the Rydberg constant for a given atomic mass."
        :parameters "(atomic-mass)"
        :category "Quantum Physics"
        :example "(calculate-rydberg-constant 1.00794)")
      *help-functions*)

(push (make-function-info
        :name "calculate-fine-structure-constant"
        :description "Calculate the fine-structure constant."
        :parameters "()"
        :category "Quantum Physics"
        :example "(calculate-fine-structure-constant)")
      *help-functions*)

(push (make-function-info
        :name "calculate-planck-length"
        :description "Calculate the Planck length."
        :parameters "()"
        :category "Quantum Physics"
        :example "(calculate-planck-length)")
      *help-functions*)

(push (make-function-info
        :name "calculate-planck-mass"
        :description "Calculate the Planck mass."
        :parameters "()"
        :category "Quantum Physics"
        :example "(calculate-planck-mass)")
      *help-functions*)

(push (make-function-info
        :name "calculate-planck-time"
        :description "Calculate the Planck time."
        :parameters "()"
        :category "Quantum Physics"
        :example "(calculate-planck-time)")
      *help-functions*)

(push (make-function-info
        :name "calculate-planck-temperature"
        :description "Calculate the Planck temperature."
        :parameters "()"
        :category "Quantum Physics"
        :example "(calculate-planck-temperature)")
      *help-functions*)

(push (make-function-info
        :name "calculate-schwarzschild-radius"
        :description "Calculate the Schwarzschild radius of a black hole."
        :parameters "(mass)"
        :category "Quantum Physics"
        :example "(calculate-schwarzschild-radius 1.989e30)")
      *help-functions*)

(push (make-function-info
        :name "calculate-hawking-temperature"
        :description "Calculate the Hawking temperature of a black hole."
        :parameters "(mass)"
        :category "Quantum Physics"
        :example "(calculate-hawking-temperature 1.989e30)")
      *help-functions*)

(push (make-function-info
        :name "calculate-gravitational-force"
        :description "Calculate the gravitational force between two masses."
        :parameters "(m1 m2 r)"
        :category "Quantum Physics"
        :example "(calculate-gravitational-force 5.972e24 1.989e30 1.496e11)")
      *help-functions*)

(push (make-function-info
        :name "calculate-gravitational-potential-energy"
        :description "Calculate the gravitational potential energy of two masses."
        :parameters "(m1 m2 r)"
        :category "Quantum Physics"
        :example "(calculate-gravitational-potential-energy 5.972e24 1.989e30 1.496e11)")
      *help-functions*)

(push (make-function-info
        :name "calculate-escape-velocity"
        :description "Calculate the escape velocity from a celestial body."
        :parameters "(mass radius)"
        :category "Quantum Physics"
        :example "(calculate-escape-velocity 5.972e24 6.371e6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-orbital-velocity"
        :description "Calculate the orbital velocity of a satellite."
        :parameters "(mass radius altitude)"
        :category "Quantum Physics"
        :example "(calculate-orbital-velocity 5.972e24 6.371e6 400e3)")
      *help-functions*)

(push (make-function-info
        :name "calculate-time-dilation"
        :description "Calculate the time dilation for a given velocity."
        :parameters "(velocity)"
        :category "Quantum Physics"
        :example "(calculate-time-dilation 0.99)")
      *help-functions*)

(push (make-function-info
        :name "calculate-length-contraction"
        :description "Calculate the length contraction for a given velocity."
        :parameters "(length velocity)"
        :category "Quantum Physics"
        :example "(calculate-length-contraction 1 0.99)")
      *help-functions*)

(push (make-function-info
        :name "calculate-relativistic-mass"
        :description "Calculate the relativistic mass for a given velocity."
        :parameters "(mass velocity)"
        :category "Quantum Physics"
        :example "(calculate-relativistic-mass 1 0.99)")
      *help-functions*)

(push (make-function-info
        :name "calculate-relativistic-kinetic-energy"
        :description "Calculate the relativistic kinetic energy for a given velocity."
        :parameters "(mass velocity)"
        :category "Quantum Physics"
        :example "(calculate-relativistic-kinetic-energy 1 0.99)")
      *help-functions*)

(push (make-function-info
        :name "calculate-mass-energy-equivalence"
        :description "Calculate the energy equivalent of a given mass."
        :parameters "(mass)"
        :category "Quantum Physics"
        :example "(calculate-mass-energy-equivalence 1)")
      *help-functions*)

;; Additional Quantum Mechanics Functions
(push (make-function-info
        :name "hydrogen-ionization-energy"
        :description "Calculate ionization energy from hydrogen level n."
        :parameters "(n)"
        :category "Quantum Physics"
        :example "(hydrogen-ionization-energy 3)")
      *help-functions*)

(push (make-function-info
        :name "bohr-radius"
        :description "Calculate Bohr radius for nth orbital in hydrogen atom."
        :parameters "(n)"
        :category "Quantum Physics"
        :example "(bohr-radius 2)")
      *help-functions*)

(push (make-function-info
        :name "orbital-velocity"
        :description "Calculate orbital velocity of electron in nth Bohr orbit."
        :parameters "(n)"
        :category "Quantum Physics"
        :example "(orbital-velocity 1)")
      *help-functions*)

(push (make-function-info
        :name "quantum-harmonic-oscillator-energy"
        :description "Calculate energy levels of quantum harmonic oscillator."
        :parameters "(n)"
        :category "Quantum Physics"
        :example "(quantum-harmonic-oscillator-energy 0)")
      *help-functions*)

(push (make-function-info
        :name "particle-in-box-energy"
        :description "Calculate energy levels for particle in 1D infinite square well."
        :parameters "(n length mass)"
        :category "Quantum Physics"
        :example "(particle-in-box-energy 1 1e-9 9.109e-31)")
      *help-functions*)

(push (make-function-info
        :name "tunnel-probability"
        :description "Calculate quantum tunneling probability through rectangular barrier."
        :parameters "(barrier-width barrier-height particle-energy mass)"
        :category "Quantum Physics"
        :example "(tunnel-probability 1e-10 5e-19 1e-19 9.109e-31)")
      *help-functions*)

(push (make-function-info
        :name "wavefunction-probability"
        :description "Calculate probability density |psi|^2 from wavefunction amplitude."
        :parameters "(amplitude)"
        :category "Quantum Physics"
        :example "(wavefunction-probability #C(0.7071 0.7071))")
      *help-functions*)

(push (make-function-info
        :name "normalize-wavefunction"
        :description "Normalize a list of wavefunction amplitudes."
        :parameters "(amplitudes)"
        :category "Quantum Physics"
        :example "(normalize-wavefunction '(#C(1 0) #C(1 1) #C(0 1)))")
      *help-functions*)

(push (make-function-info
        :name "expectation-value"
        :description "Calculate expectation value <psi|O|psi> of observable."
        :parameters "(observable-matrix wavefunction)"
        :category "Quantum Physics"
        :example "(expectation-value my-operator my-state)")
      *help-functions*)

(push (make-function-info
        :name "uncertainty-principle"
        :description "Check if uncertainty principle Delta_x * Delta_p >= hbar/2 is satisfied."
        :parameters "(delta-x delta-p)"
        :category "Quantum Physics"
        :example "(uncertainty-principle 1e-10 1e-24)")
      *help-functions*)

(push (make-function-info
        :name "compton-wavelength"
        :description "Calculate Compton wavelength lambda_c = h/(mc) for a particle."
        :parameters "(mass)"
        :category "Quantum Physics"
        :example "(compton-wavelength 9.109e-31)")
      *help-functions*)

(push (make-function-info
        :name "compton-scattering-wavelength"
        :description "Calculate wavelength after Compton scattering at angle theta."
        :parameters "(initial-wavelength theta)"
        :category "Quantum Physics"
        :example "(compton-scattering-wavelength 1e-12 1.5708)")
      *help-functions*)

(push (make-function-info
        :name "blackbody-energy-density"
        :description "Calculate energy density for blackbody radiation at given frequency."
        :parameters "(temperature frequency)"
        :category "Quantum Physics"
        :example "(blackbody-energy-density 300 5e14)")
      *help-functions*)

(push (make-function-info
        :name "wien-displacement-law"
        :description "Calculate peak wavelength for blackbody at given temperature."
        :parameters "(temperature)"
        :category "Quantum Physics"
        :example "(wien-displacement-law 5778)")
      *help-functions*)

(push (make-function-info
        :name "stefan-boltzmann-law"
        :description "Calculate total radiated power per unit area using Stefan-Boltzmann law."
        :parameters "(temperature)"
        :category "Quantum Physics"
        :example "(stefan-boltzmann-law 300)")
      *help-functions*)

(push (make-function-info
        :name "zeeman-energy"
        :description "Calculate energy shift in magnetic field (Zeeman effect)."
        :parameters "(magnetic-field ms g-factor)"
        :category "Quantum Physics"
        :example "(zeeman-energy 1.0 0.5 2.0)")
      *help-functions*)

;; Braid Statistics Functions
(push (make-function-info
        :name "pauli-matrices"
        :description "Return the three Pauli matrices as a list."
        :parameters "()"
        :category "Quantum Physics"
        :example "(pauli-matrices)")
      *help-functions*)

(push (make-function-info
        :name "braiding-matrix"
        :description "Generate braiding matrix for non-Abelian statistics."
        :parameters "(sigma)"
        :category "Quantum Physics"
        :example "(braiding-matrix 1)")
      *help-functions*)

(push (make-function-info
        :name "simulate-braiding"
        :description "Simulate braiding operations in non-Abelian systems."
        :parameters "()"
        :category "Quantum Physics"
        :example "(simulate-braiding)")
      *help-functions*)
