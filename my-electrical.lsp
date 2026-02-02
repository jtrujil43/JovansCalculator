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


