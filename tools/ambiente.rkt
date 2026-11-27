#lang racket/base
;; The environment model of SICP 3.2, in dots: a frame (squared: what eval reads) and a procedure
;; object, the two circles of code and environment (round: what apply uses). For the eval/apply post.
;; racket tools/ambiente.rkt   (writes static/img/ambiente-light.svg and ambiente-dark.svg)
;; ponytail: the engine is found in the avit-io checkout beside this one; vendor it if that moves.

(require racket/math (file "../../avit-io/tools/puntini.rkt"))

(define H 320) (define W 640)                               ; drawn in units of the height: x ∈ [0, 2]
(define (px x) (exact-round (* x H)))

(define frame-ink 0.16) (define stroke 0.012)
(define painter
  (over (rect 0.12 0.22 0.74 0.80 frame-ink)                                       ; the frame, a light grain
        (segment '(0.12 . 0.22) '(0.74 . 0.22) stroke) (segment '(0.74 . 0.22) '(0.74 . 0.80) stroke)
        (segment '(0.74 . 0.80) '(0.12 . 0.80) stroke) (segment '(0.12 . 0.80) '(0.12 . 0.22) stroke)
        (sphere 1.24 0.50 0.085) (sphere 1.42 0.50 0.085)                          ; the procedure object
        (disc 1.24 0.50 0.014) (disc 1.42 0.50 0.014)
        (segment '(0.50 . 0.635) '(1.155 . 0.52) stroke) (disc 0.50 0.635 0.014)    ; f points to it
        (segment '(1.24 . 0.50) '(1.24 . 0.78) stroke)                             ; its code
        (segment '(1.42 . 0.50) '(1.42 . 0.12) stroke)                             ; its environment
        (segment '(1.42 . 0.12) '(0.60 . 0.12) stroke) (segment '(0.60 . 0.12) '(0.60 . 0.22) stroke)))

(define dots (stipple (λ (u v) (painter (* 2 u) v)) W H #:n 900000 #:seed 1985 #:spacing 1.7 #:spread 7))

(define (labels ink)
  (string-append
   (format "<g fill=\"~a\" font-family=\"'IBM Plex Mono', ui-monospace, monospace\" font-size=\"17\">\n" ink)
   (format "<text x=\"~a\" y=\"~a\">x: 3</text>\n" (px 0.20) (px 0.44))
   (format "<text x=\"~a\" y=\"~a\">f:</text>\n" (px 0.20) (px 0.66))
   (format "<text x=\"~a\" y=\"~a\" text-anchor=\"middle\">(λ (y) (* x y))</text>\n" (px 1.24) (px 0.90))
   (format "<text x=\"~a\" y=\"~a\" font-size=\"13\" letter-spacing=\"2\">E1</text>\n" (px 0.14) (px 0.19))
   "</g>\n"))

(for ([theme (list ocra-light ocra-dark)] [file '("static/img/ambiente-light.svg" "static/img/ambiente-dark.svg")])
  (with-output-to-file file #:exists 'truncate
    (λ () (display (svg dots W H #:theme theme #:r 1.05 #:background (λ (paper) "")
                        #:label "the environment model: a frame E1 with x and f, f pointing to a procedure object"
                        #:extra labels)))))
