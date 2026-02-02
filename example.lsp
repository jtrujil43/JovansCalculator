(def x (list 1 1.2 1.5 2 2.9 3 3.9 4.9 6 9 10 3.2 4.5 6 13 12 16 17 18 19 20 21 13.4 22 22.1 23.4 11.8 19.6 12.6 30)) 
(def y (+ 1 (^ x 2)(* .5 (normal-rand 30))))

(def firstrm (regression-model x y)) 
;; (def c (histogram (send firstrm :cooks-distances))) 
;; (def l (histogram (send firstrm :leverages))) 
;;(send c :Cook's ) 
;;(send l :) 
;;(setf w (plot-points x y))

