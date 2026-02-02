;; my-electrical.lsp
;; Current location: /home/jovan/devel/Xlisp_code/my-electrical.lsp
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core 
;; Arizona State University
;; 4/2/2025
;; Rev 1.1
;; Changelog:
;; Rev 1.0 - Added dielectric constant calculations. 
;; Rev 1.1 - Added tungsten needle max current calculations for DC and pulsed. 
;; Rev 1.2 - Added calculation for copper film thickness based on sheet resistivity measurement. 

(defconstant epsilon_0 8.854E-12)
(defconstant copper_bulk_resistivity 1.7E-8) ;; Ohm-m

(defun calculate-capacitor-area (capacitance k thickness)
"Calculate the area of a capacitor"
(let* ((area (/ (capacitance thickness) (epsilon_0 k))))
area))

(defun calculate-capacitance (area k thickness)
"Calculate the capacitance of a single capacitor"
(let* (( capacitance (/ (* area epsilon_0 k) thickness)))
capacitance))

(defun calculate-capacitance-series (area1 area2 k1 k2 thickness1 thickness2)
"Calculate the total capacitance for two capacitors in series"
(let* ((capacitance1 (/ (* area1 epsilon_0 k1) thickness1))
       (capacitance2 (/ (* area2 epsilon_0 k2) thickness2))
       (capacitance (/ 1 (+ (/ 1 capacitance1) (/ 1 capacitance2)))))
capacitance))

(defun calculate-capacitance-parallel (area1 area2 k2 k2 thickness1 thickness2)
"Calculate the total capacitance for two capacitors in parallel"
(let* ((capacitance1 (/ (* area1 epsilon_0 k1) thickness1))
       (capacitance2 (/ (* area2 epsilon_0 k2) thickness2))
       (capacitance (+ capacitance1 capacitance2)))
capacitance))

(defun calculate-capacitor-thickness (capacitance k area)
"Calculate the thickness of a parallel plate capacitor based on capacitance."
(let* ((thickness (/ (* area epsilon_0 k) capacitance)))
thickness))

(defun calculate-dielectric-constant (capacitance thickness area)
  "Calculate the dielectric constant of a capacitor"
  (let* ((epsilon_0 8.854e-12) ; Permittivity of free space
	 (dielectric-constant (/ (* capacitance thickness)
				 (* area epsilon_0))))
    dielectric-constant))

(defun calculate-dielectric-constant-capseries (capacitance thickness area1 area2)
  "calculate the dielectric constant of a capacitor from two capacitors in series."
  (let* ((epsilon_0 8.854e-12) ; Permittivity of free space
	 (dielectric-constant (* (/ (* capacitance thickness)
				 epsilon_0) (/ (+ area1 area2) (* area1 area2)))))
	 dielectric-constant))

(defun paschen-breakdown-voltage (pressure gap)
"Breakdown voltage calculation using Paschen's law"
;; pressure - kilo-Pascals, 1 atm = 101.325 kPa
;; gap      - probe needle gap in meters
(let* ((gamma_se 2204.21513347591)
       (A (/ 112.50 100)) ;; kPa-cm coefficient
       (B (/ 2727.50 100)) ;; V/(kPa-cm) coefficient
       (T1 (+ 1 (/ 1 gamma_se)))
       (T2 (log (log T1)))
       (T3 (log (* A pressure gap)))
       (T4 (- T3 T2))
       (T5 (* B pressure gap))
       (Vb (/ T5 T4)))
Vb))

;; (diode-current 0.7 1.0e-12 1.5 25.85e-3 10)

(defun diode-current (v is n vt rs)
  ;; Solve I = Is * (exp((V - I*Rs)/(n*Vt)) - 1)
  (let ((i 1.0e-12) ; initial guess
        (tol 1e-6)
        (max-iter 100)
        (iter 0)
        (error 1.0))
    (loop
      (when (or (>= iter max-iter) (<= error tol)) (return))
      (let* ((f (- (* is (- (exp (/ (- v (* i rs)) (* n vt))) 1)) i))
             (df (- (* is (/ rs (* n vt)) (exp (/ (- v (* i rs)) (* n vt)))) 1))
             (i-new (- i (/ f df))))
        (setf error (abs (- i-new i)))
        (setf i i-new)
        (incf iter)
        (format t "i = ~d~%" i)))
    i))  ; <-- This returns the final value of i

;; Probe Needle Max Current Calculation

(defconstant current-limit-tungsten 3.73e7) ;; Current limit of tungsten metal in A/m^2

;; tungsten-probe-max-current returns max current in amps and needs probe diameter in meters. 
(defun tungsten-probe-max-current (diameter)
  (let* ((area (* pi (expt (/ diameter 2) 2)))
	(imax (* current-limit-tungsten area)))
    (format t "Tungsten probe of ~d m diameter has a max current of ~d A~%" diameter imax)))

;; Tungsten Max Power Dissipation
(defun tungsten-max-power (length diameter t-ambient t-max)
  ;; Estimate max power dissipation via conduction
  (let* (
         (k 173) ; thermal conductivity of tungsten in W/K
         (area (* pi (/ diameter 2) (/ diameter 2))) ; cross-sectional area
         (delta-t (- t-max t-ambient)) ; temperature difference
         (pmax (* k area (/ delta-t length)))) ; power dissipation
    pmax))

;; Example: (tungsten-max-power 0.01 0.0001 300 3695)
;; Length = 1cm
;; Diameter = 0.1mm
;; Ambient temp = 300 K
;; Max safe temp = 3695 K


;; Tungsten alternative max current calculation

(defun tungsten-current-limit-geo (length diameter pmax)
  ;; Constants
  (let* (
         (rho 5.6e-8) ; resistivity of tungsten in ohm-meters
         (area (* pi (/ diameter 2) (/ diameter 2))) ; cross-sectional area
         (resistance (/ (* rho length) area)) ; resistance from geometry
         (imax (sqrt (/ pmax resistance)))) ; current limit
    imax))

;; (tungsten-current-limit-geo 0.01 0.0001 0.5)
;; Length = 1 cm
;; Diameter = 0.1mm
;; Max power dissipation = 0.5 W

;; Probe Temperature Over Time

(defun probe-temperature-over-time (length diameter current pulse-duration cooling-duration num-pulses dt)
  ;; Constants
  (let* (
         (rho 5.6e-8) ; resistivity (Ohm)
         (c 134) ; specific heat (J/K)
         (density 19300) ; kg/m^3
         (ambient-temp 300) ; K
         (area (* pi (/ diameter 2) (/ diameter 2)))
         (volume (* area length))
         (mass (* density volume))
         (resistance (/ (* rho length) area))
         (total-time (* num-pulses (+ pulse-duration cooling-duration)))
         (steps (truncate (/ total-time dt)))
         (temperature (make-array steps :initial-element ambient-temp))
         (i 1))
    
    ;; Loop over time steps
    (loop
      (when (>= i steps) (return))
      (let* ((t (* i dt))
             (in-pulse (< (mod t (+ pulse-duration cooling-duration)) pulse-duration))
             (power (if in-pulse (* current current resistance) 0))
             (delta-temp (/ (* power dt) (* mass c)))
             (cooling (* -0.1 (- (aref temperature (- i 1)) ambient-temp) dt))
             (new-temp (+ (aref temperature (- i 1)) delta-temp cooling)))
        (setf (aref temperature i) new-temp)
        (incf i)))
    
    temperature))  ; Returns the temperature array

;; (probe-temperature-over-time 0.01 0.0001 0.5 0.01 0.02 5 0.001)
;; A 1 cm long, 0.1mm diameter tungsten probe
;; 0.5 A current pulses
;; 10 ms pulse duration, 20 ms cooling
;; 5 pulses
;; 1 ms time resolution

;; copper-bulk-resistivity

(defun copper-bulk-resistivity (temperature)
	;; Constants
	(let* ((rho0 1.68e-8) ; bulk resistivity reference at 20 C
			(T0 20) ; reference temperature in Celsius
			(alpha 0.0039); temperature coefficient of copper 
			(rho (* rho0 (+ 1 (* alpha (- temperature T0))))))
	(format t "Copper Bulk Resistivity at ~d is ~d~%" temperature rho)))

(defun copper-film-thickness (sheet-resistance)
  (let* ((thickness (/ copper_bulk_resistivity sheet-resistance)))
    (format t "Copper Film Thickness (um) is ~d~%" (* thickness 1E6))))

;;; Create a list of (x f(x)) pairs from START to END (inclusive).
;;; FUN may be a function object (e.g., #'foo or (lambda ...))
;;; or a symbol naming a function (e.g., 'foo).
(defun two-col-table (fun start end &optional (step 1))
  (when (or (eql step 0) (equal step 0.0))
    (error "STEP must be non-zero."))

  (let* ((f (if (symbolp fun) (symbol-function fun) fun))
	 ;; Build the sequence of x's:
	 ;; Use iseq for integer ranges; otherwise build a numeric range. 
	 (xs (if (and (integerp start) (integerp end) (integerp step))
		 (iseq start end step)
	       (let ((acc nil)
		     (cmp (if (> step 0) #'<= #'>=)))
		 (do ((x start (+ x step)))
		     ((not (funcall cmp x end)) (nreverse acc))
		   (push x acc))))))
    ;; Map to (x (fx)) pairs
    (mapcar (lambda (x) (list x (funcall f x))) xs)))

;;; Pretty-print a two-column table (and return the rows).
;;; LABEL lets you name the second column (defaults to "f(x)").
(defun print-two-col-table (fun start end &optional (step 1) (label "f(x)"))
  (let ((rows (two-col-table fun start end step)))
    (format t "~%  x           ~A~%  -----------------------~%" label)
    (dolist (row rows)
      ;; ~A prints generally; widths (~8A, ~12A) keep columns aligned
      (format t "  ~8A   ~12A~%" (first row) (second row)))
    rows))

;; RF Testing Functions

;; Power conversion functions
(defun watts-to-dbm (power-watts)
  "Convert power from Watts to dBm."
  (+ 10 (* 10 (log (/ power-watts 0.001) 10))))

(defun dbm-to-watts (power-dbm)
  "Convert power from dBm to Watts."
  (* 0.001 (expt 10 (/ power-dbm 10))))

(defun dbm-to-dbw (power-dbm)
  "Convert power from dBm to dBW."
  (- power-dbm 30))

(defun dbw-to-dbm (power-dbw)
  "Convert power from dBW to dBm."
  (+ power-dbw 30))

(defun power-to-voltage (power impedance)
  "Calculate voltage from power and impedance: V = sqrt(P * R)."
  (sqrt (* power impedance)))

(defun voltage-to-power (voltage impedance)
  "Calculate power from voltage and impedance: P = V²/R."
  (/ (* voltage voltage) impedance))

;; S-Parameter calculations
(defun reflection-coefficient (zload z0)
  "Calculate reflection coefficient Γ = (ZL - Z0)/(ZL + Z0)."
  (/ (- zload z0) (+ zload z0)))

(defun reflection-coefficient-magnitude (gamma)
  "Calculate magnitude of reflection coefficient from complex gamma."
  (abs gamma))

(defun vswr-from-reflection (gamma-magnitude)
  "Calculate VSWR from reflection coefficient magnitude."
  (/ (+ 1 gamma-magnitude) (- 1 gamma-magnitude)))

(defun reflection-from-vswr (vswr)
  "Calculate reflection coefficient magnitude from VSWR."
  (/ (- vswr 1) (+ vswr 1)))

(defun return-loss (gamma-magnitude)
  "Calculate return loss in dB from reflection coefficient magnitude."
  (- (* 20 (log gamma-magnitude 10))))

(defun insertion-loss-db (s21-magnitude)
  "Calculate insertion loss in dB from S21 magnitude."
  (- (* 20 (log s21-magnitude 10))))

;; Transmission line calculations
(defun characteristic-impedance (inductance-per-length capacitance-per-length)
  "Calculate characteristic impedance Z0 = sqrt(L/C)."
  (sqrt (/ inductance-per-length capacitance-per-length)))

(defun propagation-velocity (inductance-per-length capacitance-per-length)
  "Calculate propagation velocity v = 1/sqrt(LC)."
  (/ 1 (sqrt (* inductance-per-length capacitance-per-length))))

(defun electrical-length (physical-length wavelength)
  "Calculate electrical length in degrees."
  (* 360 (/ physical-length wavelength)))

(defun wavelength-in-medium (frequency velocity)
  "Calculate wavelength in medium: λ = v/f."
  (/ velocity frequency))

(defun cable-loss (loss-per-length length-meters)
  "Calculate total cable loss in dB."
  (* loss-per-length length-meters))

(defun cable-loss-with-frequency (loss-coeff frequency-mhz length-meters)
  "Calculate cable loss in dB with frequency dependence: Loss = k*sqrt(f)*L."
  (* loss-coeff (sqrt frequency-mhz) length-meters))

;; Impedance matching
(defun l-network-series-inductor (r-source r-load q-factor)
  "Calculate series inductor for L-network matching."
  (let ((x (* q-factor r-source)))
    (/ x (* 2 pi frequency))))

(defun l-network-shunt-capacitor (r-source r-load q-factor frequency)
  "Calculate shunt capacitor for L-network matching."
  (let ((x (/ r-load q-factor)))
    (/ 1 (* 2 pi frequency x))))

(defun quarter-wave-transformer-impedance (z1 z2)
  "Calculate impedance of quarter-wave transformer: Z = sqrt(Z1*Z2)."
  (sqrt (* z1 z2)))

;; Noise calculations
(defun noise-figure-db (signal-in signal-out noise-in noise-out)
  "Calculate noise figure in dB: NF = 10*log((Si/Ni)/(So/No))."
  (let ((snr-in (/ signal-in noise-in))
        (snr-out (/ signal-out noise-out)))
    (* 10 (log (/ snr-in snr-out) 10))))

(defun noise-temperature (noise-figure-db)
  "Calculate equivalent noise temperature from noise figure."
  (let ((nf-ratio (expt 10 (/ noise-figure-db 10))))
    (* 290 (- nf-ratio 1))))

(defun friis-noise-formula (nf1-db nf2-db gain1-db)
  "Calculate total noise figure of cascaded amplifiers."
  (let ((nf1 (expt 10 (/ nf1-db 10)))
        (nf2 (expt 10 (/ nf2-db 10)))
        (g1 (expt 10 (/ gain1-db 10))))
    (+ nf1 (/ (- nf2 1) g1))))

;; Filter calculations
(defun lowpass-cutoff-frequency (resistance capacitance)
  "Calculate cutoff frequency for RC lowpass filter."
  (/ 1 (* 2 pi resistance capacitance)))

(defun highpass-cutoff-frequency (resistance capacitance)
  "Calculate cutoff frequency for RC highpass filter."
  (/ 1 (* 2 pi resistance capacitance)))

(defun q-factor-rlc (resistance inductance capacitance)
  "Calculate Q factor for RLC circuit."
  (/ (sqrt (/ inductance capacitance)) resistance))

(defun resonant-frequency-lc (inductance capacitance)
  "Calculate resonant frequency: f = 1/(2π√LC)."
  (/ 1 (* 2 pi (sqrt (* inductance capacitance)))))

;; Antenna calculations
(defun free-space-path-loss (distance-km frequency-mhz)
  "Calculate free space path loss in dB."
  (+ (* 20 (log distance-km 10))
     (* 20 (log frequency-mhz 10))
     32.44))

(defun effective-radiated-power (transmitter-power-dbm antenna-gain-dbi cable-loss-db)
  "Calculate effective radiated power (ERP) in dBm."
  (+ transmitter-power-dbm antenna-gain-dbi (- cable-loss-db)))

(defun link-budget (tx-power-dbm tx-gain-dbi rx-gain-dbi path-loss-db cable-losses-db)
  "Calculate received power in link budget analysis."
  (- (+ tx-power-dbm tx-gain-dbi rx-gain-dbi) path-loss-db cable-losses-db))

(defun dipole-length (frequency-mhz)
  "Calculate half-wave dipole length in meters."
  (/ 150 frequency-mhz))

(defun antenna-aperture (gain-dbi frequency-hz)
  "Calculate effective antenna aperture in square meters."
  (let ((gain-ratio (expt 10 (/ gain-dbi 10)))
        (wavelength (/ 3e8 frequency-hz)))
    (/ (* gain-ratio wavelength wavelength) (* 4 pi))))

;; Smith Chart calculations
(defun impedance-to-admittance (z-real z-imag z0)
  "Convert impedance to admittance on Smith chart."
  (let* ((z-norm-real (/ z-real z0))
         (z-norm-imag (/ z-imag z0))
         (denominator (+ (* z-norm-real z-norm-real) (* z-norm-imag z-norm-imag))))
    (values (/ z-norm-real denominator)
            (/ (- z-norm-imag) denominator))))

(defun normalized-impedance (z-real z-imag z0)
  "Normalize impedance to characteristic impedance."
  (values (/ z-real z0) (/ z-imag z0)))

;; Time domain reflectometry
(defun tdr-distance-to-fault (time-ns velocity-factor)
  "Calculate distance to fault from TDR measurement."
  (let ((c-speed 3e8))  ; Speed of light in m/s
    (* 0.5 (* time-ns 1e-9) (* velocity-factor c-speed))))

(defun velocity-factor-coax (dielectric-constant)
  "Calculate velocity factor for coaxial cable."
  (/ 1 (sqrt dielectric-constant)))

;; Example usage:
;; (watts-to-dbm 0.001)                    ; 0 dBm
;; (vswr-from-reflection 0.1)              ; VSWR = 1.22
;; (free-space-path-loss 1.0 1000)        ; Path loss at 1 km, 1 GHz
;; (quarter-wave-transformer-impedance 50 75)  ; 61.24 ohms

