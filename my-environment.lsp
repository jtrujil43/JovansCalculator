;; Current location: /home/jovan/devel/Xlisp_code/JovansCalculator/my-environment.lsp
;; init.lsp loaded from /home/jovan/.emacs.d/init.lsp
;; Jovan Trujillo
;; Advanced Electronics and Photonics Core
;; Arizona State University
;; 9/25/2025
;; Rev 1.0
;; Changelog:
;; Rev 1.0 - Just getting my feet wet here for easy capacitance calculations.
;; Rev 1.1 - Adding loads of other list files for formula's separated by categories like electrical, quantum, math, etc.
;; Rev 1.2 - Moved this copy to the local WSL-Ubuntu home drive since it seems it didn't like the long path in the OneDrive copy. 

(defun convert-chars-to-integer-codes (input-file output-file)
  "Reads INPUT-FILE, converts each character to its integer ASCII code,
   and writes the codes to OUTPUT-FILE, one per line."
  (with-open-file (in-stream input-file :direction :input :element-type 'character)
    (with-open-file (out-stream output-file :direction :output :element-type 'character
                                :if-exists :supersede :if-does-not-exist :create)
      (do ((char (read-char in-stream nil) (read-char in-stream nil)))
          ((null char))  ; Exit when end of file is reached
        (let ((code (char-int char)))
         ;; (write-line (prin1-to-string code) out-stream))))))
	  (format out-stream "~A - ~A~%" code char))))))

;; Load files relative to this file's location
(let ((base-dir (make-pathname :directory (pathname-directory *load-pathname*))))
  (load (merge-pathnames "my-math.lsp" base-dir))
  (load (merge-pathnames "my-matrix.lsp" base-dir))
  (load (merge-pathnames "my-electrical.lsp" base-dir))
  (load (merge-pathnames "my-quantum.lsp" base-dir))
  (load (merge-pathnames "my-chemistry.lsp" base-dir))
  (load (merge-pathnames "nonAbelian-Braid-Statistics.lsp" base-dir))
  (load (merge-pathnames "help.lsp" base-dir)))
