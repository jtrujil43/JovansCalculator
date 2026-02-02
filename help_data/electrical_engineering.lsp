;; help_data/electrical_engineering.lsp

(push (make-function-info
        :name "calculate-capacitance"
        :description "Calculate the capacitance of a parallel plate capacitor given area, dielectric constant, and thickness."
        :parameters "(area k thickness)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance 1e-4 4.5 1e-6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-capacitor-area"
        :description "Calculate the area of a capacitor given its capacitance, dielectric constant, and thickness."
        :parameters "(capacitance k thickness)"
        :category "Electrical Engineering"
        :example "(calculate-capacitor-area 1e-12 4.5 1e-6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-capacitance-series"
        :description "Calculate the total capacitance for two capacitors in series."
        :parameters "(area1 area2 k1 k2 thickness1 thickness2)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance-series 1e-4 2e-4 3.9 4.5 1e-6 2e-6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-capacitance-parallel"
        :description "Calculate the total capacitance for two capacitors in parallel."
        :parameters "(area1 area2 k1 k2 thickness1 thickness2)"
        :category "Electrical Engineering"
        :example "(calculate-capacitance-parallel 1e-4 2e-4 3.9 4.5 1e-6 2e-6)")
      *help-functions*)

(push (make-function-info
        :name "calculate-capacitor-thickness"
        :description "Calculate the thickness of a parallel plate capacitor based on capacitance."
        :parameters "(capacitance k area)"
        :category "Electrical Engineering"
        :example "(calculate-capacitor-thickness 1e-12 3.9 1e-4)")
      *help-functions*)

(push (make-function-info
        :name "calculate-dielectric-constant"
        :description "Calculate the dielectric constant of a capacitor material."
        :parameters "(capacitance thickness area)"
        :category "Electrical Engineering"
        :example "(calculate-dielectric-constant 1e-12 1e-6 1e-4)")
      *help-functions*)

(push (make-function-info
        :name "paschen-breakdown-voltage"
        :description "Calculate breakdown voltage using Paschen's law for gas discharge."
        :parameters "(pressure gap)"
        :category "Electrical Engineering"
        :example "(paschen-breakdown-voltage 101.325 1e-3)")
      *help-functions*)

(push (make-function-info
        :name "diode-current"
        :description "Calculate diode current using iterative solution of Shockley diode equation."
        :parameters "(v is n vt rs)"
        :category "Electrical Engineering"
        :example "(diode-current 0.7 1.0e-12 1.5 25.85e-3 10)")
      *help-functions*)

(push (make-function-info
        :name "tungsten-probe-max-current"
        :description "Calculate maximum current for tungsten probe based on diameter."
        :parameters "(diameter)"
        :category "Electrical Engineering"
        :example "(tungsten-probe-max-current 25e-6)")
      *help-functions*)

(push (make-function-info
        :name "tungsten-max-power"
        :description "Calculate maximum power for tungsten probe considering thermal limits."
        :parameters "(length diameter t-ambient t-max)"
        :category "Electrical Engineering"
        :example "(tungsten-max-power 1e-3 25e-6 300 2000)")
      *help-functions*)

(push (make-function-info
        :name "tungsten-current-limit-geo"
        :description "Calculate current limit based on tungsten probe geometry and power constraints."
        :parameters "(length diameter pmax)"
        :category "Electrical Engineering"
        :example "(tungsten-current-limit-geo 1e-3 25e-6 0.1)")
      *help-functions*)

(push (make-function-info
        :name "copper-bulk-resistivity"
        :description "Calculate copper bulk resistivity as a function of temperature."
        :parameters "(temperature)"
        :category "Electrical Engineering"
        :example "(copper-bulk-resistivity 300)")
      *help-functions*)

(push (make-function-info
        :name "copper-film-thickness"
        :description "Calculate copper film thickness from sheet resistance measurement."
        :parameters "(sheet-resistance)"
        :category "Electrical Engineering"
        :example "(copper-film-thickness 0.1)")
      *help-functions*)

(push (make-function-info
        :name "watts-to-dbm"
        :description "Convert power from Watts to dBm."
        :parameters "(power-watts)"
        :category "Electrical Engineering"
        :example "(watts-to-dbm 0.001)")
      *help-functions*)

(push (make-function-info
        :name "dbm-to-watts"
        :description "Convert power from dBm to Watts."
        :parameters "(power-dbm)"
        :category "Electrical Engineering"
        :example "(dbm-to-watts 0)")
      *help-functions*)

(push (make-function-info
        :name "reflection-coefficient"
        :description "Calculate reflection coefficient Gamma = (ZL - Z0)/(ZL + Z0)."
        :parameters "(zload z0)"
        :category "Electrical Engineering"
        :example "(reflection-coefficient 75 50)")
      *help-functions*)

(push (make-function-info
        :name "vswr-from-reflection"
        :description "Calculate VSWR from reflection coefficient magnitude."
        :parameters "(gamma-magnitude)"
        :category "Electrical Engineering"
        :example "(vswr-from-reflection 0.2)")
      *help-functions*)

(push (make-function-info
        :name "return-loss"
        :description "Calculate return loss in dB from reflection coefficient magnitude."
        :parameters "(gamma-magnitude)"
        :category "Electrical Engineering"
        :example "(return-loss 0.1)")
      *help-functions*)

(push (make-function-info
        :name "characteristic-impedance"
        :description "Calculate characteristic impedance Z0 = sqrt(L/C) for transmission line."
        :parameters "(inductance-per-length capacitance-per-length)"
        :category "Electrical Engineering"
        :example "(characteristic-impedance 2.5e-7 1e-10)")
      *help-functions*)

(push (make-function-info
        :name "cable-loss"
        :description "Calculate total cable loss in dB."
        :parameters "(loss-per-length length-meters)"
        :category "Electrical Engineering"
        :example "(cable-loss 0.2 10)")
      *help-functions*)

(push (make-function-info
        :name "quarter-wave-transformer-impedance"
        :description "Calculate impedance of quarter-wave transformer for impedance matching."
        :parameters "(z1 z2)"
        :category "Electrical Engineering"
        :example "(quarter-wave-transformer-impedance 50 75)")
      *help-functions*)

(push (make-function-info
        :name "noise-figure-db"
        :description "Calculate noise figure in dB from signal and noise levels."
        :parameters "(signal-in signal-out noise-in noise-out)"
        :category "Electrical Engineering"
        :example "(noise-figure-db 1.0 10.0 0.01 0.05)")
      *help-functions*)

(push (make-function-info
        :name "friis-noise-formula"
        :description "Calculate total noise figure of cascaded amplifiers using Friis formula."
        :parameters "(nf1-db nf2-db gain1-db)"
        :category "Electrical Engineering"
        :example "(friis-noise-formula 3.0 6.0 20.0)")
      *help-functions*)

(push (make-function-info
        :name "resonant-frequency-lc"
        :description "Calculate resonant frequency for LC circuit: f = 1/(2*pi*sqrt(LC))."
        :parameters "(inductance capacitance)"
        :category "Electrical Engineering"
        :example "(resonant-frequency-lc 1e-6 1e-9)")
      *help-functions*)

(push (make-function-info
        :name "free-space-path-loss"
        :description "Calculate free space path loss in dB for RF link analysis."
        :parameters "(distance-km frequency-mhz)"
        :category "Electrical Engineering"
        :example "(free-space-path-loss 1.0 1000)")
      *help-functions*)

(push (make-function-info
        :name "effective-radiated-power"
        :description "Calculate effective radiated power (ERP) in dBm."
        :parameters "(transmitter-power-dbm antenna-gain-dbi cable-loss-db)"
        :category "Electrical Engineering"
        :example "(effective-radiated-power 30 6 2)")
      *help-functions*)

(push (make-function-info
        :name "link-budget"
        :description "Calculate received power in RF link budget analysis."
        :parameters "(tx-power-dbm tx-gain-dbi rx-gain-dbi path-loss-db cable-losses-db)"
        :category "Electrical Engineering"
        :example "(link-budget 30 6 6 100 3)")
      *help-functions*)

(push (make-function-info
        :name "dipole-length"
        :description "Calculate half-wave dipole antenna length in meters."
        :parameters "(frequency-mhz)"
        :category "Electrical Engineering"
        :example "(dipole-length 100)")
      *help-functions*)

(push (make-function-info
        :name "tdr-distance-to-fault"
        :description "Calculate distance to fault from time domain reflectometry measurement."
        :parameters "(time-ns velocity-factor)"
        :category "Electrical Engineering"
        :example "(tdr-distance-to-fault 100 0.66)")
      *help-functions*)
