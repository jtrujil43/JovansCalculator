# Jovan's Calculator

A comprehensive scientific calculator running on XLISP-STAT 3.52.18 and 3.52.23 on WSL-Ubuntu and several vintage systems.

**Author:** Jovan Trujillo  
**Affiliation:** Advanced Electronics and Photonics Core, Arizona State University  
**Created:** February 2, 2026

## Getting Started

Load the calculator environment in XLISP-STAT:
```lisp
(load "my-environment.lsp")
```

Access the help system:
```lisp
(help)                      ; Show all functions
(help-function <index>)     ; Get details for a specific function
(help-category "name")      ; Show functions in a category
(help-search "keyword")     ; Search for functions
(list-categories)           ; Show categories with counts
```

---

## Function Reference

### Chemistry (28 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `beer-lambert-law` | `(molar-absorptivity path-length concentration)` | Calculate absorbance using Beer-Lambert law: A = epsilon*l*c. |
| `boyles-law` | `(p1 v1 p2 v2)` | Calculate missing parameter using Boyle's Law: P1*V1 = P2*V2. |
| `bragg-law` | `(n wavelength d-spacing theta)` | Calculate missing parameter from Bragg's law: n*lambda = 2d*sin(theta). |
| `calculate-arrhenius-rate` | `(pre-exponential-factor activation-energy temperature)` | Calculate the rate constant of a reaction using the Arrhenius equation. |
| `calculate-boiling-point-elevation` | `(kb molality)` | Calculate the boiling point elevation of a solution. |
| `calculate-freezing-point-depression` | `(kf molality)` | Calculate the freezing point depression of a solution. |
| `calculate-gibbs-free-energy` | `(delta-h delta-s temperature)` | Calculate the change in Gibbs free energy for a reaction. |
| `calculate-half-life-first-order` | `(rate-constant)` | Calculate the half-life of a first-order reaction. |
| `calculate-henderson-hasselbalch` | `(pka base-concentration acid-concentration)` | Calculate pH using the Henderson-Hasselbalch equation for buffer solutions. |
| `calculate-ideal-gas-law` | `(p v n t)` | Calculate pressure, volume, moles, or temperature using the ideal gas law (PV=nRT). |
| `calculate-molarity` | `(moles-solute volume-liters)` | Calculate the molarity of a solution. |
| `calculate-nernst-equation` | `(standard-potential temperature moles-electrons reaction-quotient)` | Calculate the cell potential under non-standard conditions using the Nernst equation. |
| `calculate-ph` | `(h-plus-concentration)` | Calculate the pH of a solution from the hydrogen ion concentration. |
| `calculate-poh` | `(oh-minus-concentration)` | Calculate the pOH of a solution from the hydroxide ion concentration. |
| `charles-law` | `(v1 t1 v2 t2)` | Calculate missing parameter using Charles' Law: V1/T1 = V2/T2. |
| `combined-gas-law` | `(p1 v1 t1 p2 v2 t2)` | Calculate missing parameter using combined gas law. |
| `dilution-equation` | `(c1 v1 c2 v2)` | Calculate missing parameter using C1*V1 = C2*V2. |
| `first-order-kinetics` | `(initial-conc rate-constant time)` | Calculate concentration after time t for first-order reaction. |
| `gibbs-free-energy` | `(enthalpy entropy temperature)` | Calculate Gibbs free energy: DeltaG = DeltaH - T*DeltaS. |
| `half-life-first-order` | `(rate-constant)` | Calculate half-life for first-order reaction. |
| `henderson-hasselbalch` | `(pka conjugate-base-conc weak-acid-conc)` | Calculate pH using Henderson-Hasselbalch equation. |
| `ideal-gas-law` | `(pressure volume temperature moles)` | Calculate missing parameter from ideal gas law PV = nRT. |
| `mass-to-moles` | `(mass molecular-weight)` | Convert mass (g) to moles using molecular weight. |
| `molality` | `(moles mass-solvent-kg)` | Calculate molality (m) = moles of solute / kg of solvent. |
| `molarity` | `(moles volume-liters)` | Calculate molarity (M) = moles of solute / liters of solution. |
| `mole-fraction` | `(moles-solute moles-solvent)` | Calculate mole fraction of solute. |
| `nernst-equation` | `(standard-potential electron-count reaction-quotient temperature)` | Calculate cell potential using Nernst equation. |
| `ph-from-hydrogen-ion` | `(hydrogen-ion-conc)` | Calculate pH from hydrogen ion concentration. |

### Electrical Engineering (29 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `cable-loss` | `(loss-per-length length-meters)` | Calculate total cable loss in dB. |
| `calculate-capacitance` | `(area k thickness)` | Calculate the capacitance of a parallel plate capacitor given area, dielectric constant, and thickness. |
| `calculate-capacitance-parallel` | `(area1 area2 k1 k2 thickness1 thickness2)` | Calculate the total capacitance for two capacitors in parallel. |
| `calculate-capacitance-series` | `(area1 area2 k1 k2 thickness1 thickness2)` | Calculate the total capacitance for two capacitors in series. |
| `calculate-capacitor-area` | `(capacitance k thickness)` | Calculate the area of a capacitor given its capacitance, dielectric constant, and thickness. |
| `calculate-capacitor-thickness` | `(capacitance k area)` | Calculate the thickness of a parallel plate capacitor based on capacitance. |
| `calculate-dielectric-constant` | `(capacitance thickness area)` | Calculate the dielectric constant of a capacitor material. |
| `characteristic-impedance` | `(inductance-per-length capacitance-per-length)` | Calculate characteristic impedance Z0 = sqrt(L/C) for transmission line. |
| `copper-bulk-resistivity` | `(temperature)` | Calculate copper bulk resistivity as a function of temperature. |
| `copper-film-thickness` | `(sheet-resistance)` | Calculate copper film thickness from sheet resistance measurement. |
| `dbm-to-watts` | `(power-dbm)` | Convert power from dBm to Watts. |
| `diode-current` | `(v is n vt rs)` | Calculate diode current using iterative solution of Shockley diode equation. |
| `dipole-length` | `(frequency-mhz)` | Calculate half-wave dipole antenna length in meters. |
| `effective-radiated-power` | `(transmitter-power-dbm antenna-gain-dbi cable-loss-db)` | Calculate effective radiated power (ERP) in dBm. |
| `free-space-path-loss` | `(distance-km frequency-mhz)` | Calculate free space path loss in dB for RF link analysis. |
| `friis-noise-formula` | `(nf1-db nf2-db gain1-db)` | Calculate total noise figure of cascaded amplifiers using Friis formula. |
| `link-budget` | `(tx-power-dbm tx-gain-dbi rx-gain-dbi path-loss-db cable-losses-db)` | Calculate received power in RF link budget analysis. |
| `noise-figure-db` | `(signal-in signal-out noise-in noise-out)` | Calculate noise figure in dB from signal and noise levels. |
| `paschen-breakdown-voltage` | `(pressure gap)` | Calculate breakdown voltage using Paschen's law for gas discharge. |
| `quarter-wave-transformer-impedance` | `(z1 z2)` | Calculate impedance of quarter-wave transformer for impedance matching. |
| `reflection-coefficient` | `(zload z0)` | Calculate reflection coefficient Gamma = (ZL - Z0)/(ZL + Z0). |
| `resonant-frequency-lc` | `(inductance capacitance)` | Calculate resonant frequency for LC circuit: f = 1/(2*pi*sqrt(LC)). |
| `return-loss` | `(gamma-magnitude)` | Calculate return loss in dB from reflection coefficient magnitude. |
| `tdr-distance-to-fault` | `(time-ns velocity-factor)` | Calculate distance to fault from time domain reflectometry measurement. |
| `tungsten-current-limit-geo` | `(length diameter pmax)` | Calculate current limit based on tungsten probe geometry and power constraints. |
| `tungsten-max-power` | `(length diameter t-ambient t-max)` | Calculate maximum power for tungsten probe considering thermal limits. |
| `tungsten-probe-max-current` | `(diameter)` | Calculate maximum current for tungsten probe based on diameter. |
| `vswr-from-reflection` | `(gamma-magnitude)` | Calculate VSWR from reflection coefficient magnitude. |
| `watts-to-dbm` | `(power-watts)` | Convert power from Watts to dBm. |

### Mathematical (7 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `derivative-step-by-step` | `(expr var)` | Show step-by-step derivative calculation with explanations and infix output. |
| `group-terms` | `(expr)` | Group like terms in an expression and combine their coefficients. |
| `infix-notation` | `(expr)` | Convert Lisp prefix expressions to readable infix notation string. |
| `latex-notation` | `(expr)` | Convert Lisp expressions to LaTeX mathematical notation for typesetting. |
| `pretty-print-expression` | `(expr)` | Pretty print a mathematical expression in infix notation to console. |
| `simplify` | `(expr)` | Simplify mathematical expressions by removing zero terms and combining constants. |
| `symbolic-derivative` | `(expr var)` | Calculate the symbolic derivative of a polynomial expression with respect to a variable. |

### Matrix Operations (2 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `display-matrix-subset` | `(start-i end-i start-j end-j my-matrix)` | Display a subset of matrix elements within specified ranges. |
| `make-matrix` | `(n m my-list)` | Create a matrix with specified dimensions and data. |

### Quantum Physics (47 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `blackbody-energy-density` | `(temperature frequency)` | Calculate energy density for blackbody radiation at given frequency. |
| `bohr-radius` | `(n)` | Calculate Bohr radius for nth orbital in hydrogen atom. |
| `braiding-matrix` | `(sigma)` | Generate braiding matrix for non-Abelian statistics. |
| `calculate-bohr-radius` | `(n z)` | Calculate the Bohr radius for a hydrogen-like atom. |
| `calculate-compton-wavelength` | `(mass)` | Calculate the Compton wavelength of a particle. |
| `calculate-coulomb-force` | `(q1 q2 r)` | Calculate the Coulomb force between two point charges. |
| `calculate-de-broglie-wavelength` | `(mass velocity)` | Calculate the de Broglie wavelength of a particle. |
| `calculate-electric-field` | `(q r)` | Calculate the electric field due to a point charge. |
| `calculate-energy-level` | `(n z)` | Calculate the energy level of a hydrogen-like atom. |
| `calculate-escape-velocity` | `(mass radius)` | Calculate the escape velocity from a celestial body. |
| `calculate-fine-structure-constant` | `()` | Calculate the fine-structure constant. |
| `calculate-gravitational-force` | `(m1 m2 r)` | Calculate the gravitational force between two masses. |
| `calculate-gravitational-potential-energy` | `(m1 m2 r)` | Calculate the gravitational potential energy of two masses. |
| `calculate-hawking-temperature` | `(mass)` | Calculate the Hawking temperature of a black hole. |
| `calculate-length-contraction` | `(length velocity)` | Calculate the length contraction for a given velocity. |
| `calculate-lorentz-force` | `(q e v b)` | Calculate the Lorentz force on a charged particle in electric and magnetic fields. |
| `calculate-magnetic-field` | `(current distance)` | Calculate the magnetic field due to a current-carrying wire. |
| `calculate-mass-energy-equivalence` | `(mass)` | Calculate the energy equivalent of a given mass. |
| `calculate-orbital-velocity` | `(mass radius altitude)` | Calculate the orbital velocity of a satellite. |
| `calculate-photon-energy` | `(lambda)` | Calculate the energy of a photon given its wavelength. |
| `calculate-photon-wavelength` | `(energy)` | Calculate the wavelength of a photon given its energy. |
| `calculate-planck-length` | `()` | Calculate the Planck length. |
| `calculate-planck-mass` | `()` | Calculate the Planck mass. |
| `calculate-planck-temperature` | `()` | Calculate the Planck temperature. |
| `calculate-planck-time` | `()` | Calculate the Planck time. |
| `calculate-relativistic-kinetic-energy` | `(mass velocity)` | Calculate the relativistic kinetic energy for a given velocity. |
| `calculate-relativistic-mass` | `(mass velocity)` | Calculate the relativistic mass for a given velocity. |
| `calculate-rydberg-constant` | `(atomic-mass)` | Calculate the Rydberg constant for a given atomic mass. |
| `calculate-schwarzschild-radius` | `(mass)` | Calculate the Schwarzschild radius of a black hole. |
| `calculate-time-dilation` | `(velocity)` | Calculate the time dilation for a given velocity. |
| `calculate-tunneling-probability` | `(v0 e width mass)` | Calculate the tunneling probability of a particle through a barrier. |
| `compton-scattering-wavelength` | `(initial-wavelength theta)` | Calculate wavelength after Compton scattering at angle theta. |
| `compton-wavelength` | `(mass)` | Calculate Compton wavelength lambda_c = h/(mc) for a particle. |
| `expectation-value` | `(observable-matrix wavefunction)` | Calculate expectation value <psi\|O\|psi> of observable. |
| `hydrogen-ionization-energy` | `(n)` | Calculate ionization energy from hydrogen level n. |
| `normalize-wavefunction` | `(amplitudes)` | Normalize a list of wavefunction amplitudes. |
| `orbital-velocity` | `(n)` | Calculate orbital velocity of electron in nth Bohr orbit. |
| `particle-in-box-energy` | `(n length mass)` | Calculate energy levels for particle in 1D infinite square well. |
| `pauli-matrices` | `()` | Return the three Pauli matrices as a list. |
| `quantum-harmonic-oscillator-energy` | `(n)` | Calculate energy levels of quantum harmonic oscillator. |
| `simulate-braiding` | `()` | Simulate braiding operations in non-Abelian systems. |
| `stefan-boltzmann-law` | `(temperature)` | Calculate total radiated power per unit area using Stefan-Boltzmann law. |
| `tunnel-probability` | `(barrier-width barrier-height particle-energy mass)` | Calculate quantum tunneling probability through rectangular barrier. |
| `uncertainty-principle` | `(delta-x delta-p)` | Check if uncertainty principle Delta_x * Delta_p >= hbar/2 is satisfied. |
| `wavefunction-probability` | `(amplitude)` | Calculate probability density \|psi\|^2 from wavefunction amplitude. |
| `wien-displacement-law` | `(temperature)` | Calculate peak wavelength for blackbody at given temperature. |
| `zeeman-energy` | `(magnetic-field ms g-factor)` | Calculate energy shift in magnetic field (Zeeman effect). |

### Utilities (24 functions)

| Function | Parameters | Description |
|----------|------------|-------------|
| `convert-chars-to-integer-codes` | `(input-file output-file)` | Convert characters in a file to their ASCII integer codes. |
| `delete-file` | `(file-path)` | Delete a file. |
| `file-exists` | `(file-path)` | Check if a file exists. |
| `generate-uuid` | `()` | Generate a random UUID. |
| `get-current-time` | `()` | Get the current time as a string. |
| `get-env-var` | `(var-name)` | Get the value of an environment variable. |
| `join-string` | `(lst delimiter)` | Join a list of strings with a delimiter. |
| `list-to-string` | `(lst)` | Convert a list of characters to a string. |
| `print-two-col-table` | `(fun start end &optional (step 1) (label "f(x)"))` | Print a formatted two-column table with optional label. |
| `read-file-lines` | `(file-path)` | Read a file into a list of strings. |
| `set-env-var` | `(var-name value)` | Set the value of an environment variable. |
| `sleep` | `(seconds)` | Pause execution for a number of seconds. |
| `split-string` | `(str delimiter)` | Split a string by a delimiter. |
| `string-contains` | `(str sub)` | Check if a string contains a substring. |
| `string-downcase` | `(str)` | Convert a string to lowercase. |
| `string-ends-with` | `(str sub)` | Check if a string ends with a substring. |
| `string-replace` | `(str old new)` | Replace all occurrences of a substring with another substring. |
| `string-reverse` | `(str)` | Reverse a string. |
| `string-starts-with` | `(str sub)` | Check if a string starts with a substring. |
| `string-to-list` | `(str)` | Convert a string to a list of characters. |
| `string-upcase` | `(str)` | Convert a string to uppercase. |
| `trim-string` | `(str)` | Trim whitespace from the beginning and end of a string. |
| `two-col-table` | `(fun start end &optional (step 1))` | Generate a two-column table of function values. |
| `write-file-lines` | `(file-path lines)` | Write a list of strings to a file. |

---

## Help System Management

The calculator includes an interactive help system with the following management functions:

| Function | Description |
|----------|-------------|
| `(add-help-function)` | Interactively add a new function to the help system |
| `(edit-help-function "name")` | Edit an existing function's documentation |
| `(remove-help-function "name")` | Remove a function from the help system |
| `(save-help-file)` | Save changes to disk |
| `(list-categories)` | Show all categories with function counts |
| `(list-categories-only)` | Show just category names |

---

## File Structure

```
JovansCalculator/
├── my-environment.lsp      # Main loader
├── my-math.lsp             # Mathematical functions
├── my-matrix.lsp           # Matrix operations
├── my-electrical.lsp       # Electrical engineering functions
├── my-quantum.lsp          # Quantum physics functions
├── my-chemistry.lsp        # Chemistry functions
├── nonAbelian-Braid-Statistics.lsp  # Topological quantum computing
├── help.lsp                # Help system
├── help_data/              # Help data files (split for XLISP-STAT compatibility)
│   ├── mathematical.lsp
│   ├── matrix_operations.lsp
│   ├── electrical_engineering.lsp
│   ├── quantum_physics.lsp
│   ├── chemistry.lsp
│   └── utilities.lsp
└── README.md
```

---

## License

Copyright © 2026 Jovan Trujillo, Arizona State University
