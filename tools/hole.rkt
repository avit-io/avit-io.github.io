#lang racket/base
;; The home page picture: the black hole of the GitHub profile banner (avit-io/tools/banner.rkt),
;; without the name, centred, drawn by stippling. The dots are the light: black on the light page,
;; white on the dark one. No background, so the page shows through. Same seed, same dots, both files.
;; racket tools/hole.rkt   (from the repo root: writes static/img/hole-light.svg and hole-dark.svg)

(require racket/math)

(define W 1200) (define H 330)
(define cx 600) (define cy 165) (define R 62)                ; the black hole and its shadow radius
(define tilt 0.2)                                            ; how much of the disk's face we see

;; brightness ∈ [0, 1] at a point of the canvas
(define (brightness x y)
  (define u (/ (- x cx) R)) (define v (/ (- y cy) R))
  (define rho (sqrt (+ (sqr u) (sqr v))))
  (define side (- 1 (* 0.25 (/ u (max rho 1e-9)))))          ; Doppler, mild: the side coming towards us is brighter
  ;; the thin disk, seen almost edge-on: in front of the shadow, across it
  (define rd (sqrt (+ (sqr u) (sqr (/ v tilt)))))
  (define disk
    (if (and (< 1.25 rd 3.8) (or (> v 0) (> rho 1.05)))
        (* 0.9 (expt (/ 1.25 rd) 0.8) (- 1 (* 0.25 (/ u rd))) (min 1 (* 3 (- 3.8 rd))))
        0))
  ;; the far side of the disk, bent by gravity: a thick arc over the shadow, thin at its sides,
  ;; and a fainter, thinner one under it; then the photon ring, hugging the shadow
  (define s (abs (/ v (max rho 1e-9))))                      ; 1 above and below, 0 at the sides
  (define arc
    (cond [(<= rho 1) 0]
          [(< v 0) (* 0.8 (exp (- (sqr (/ (- rho 1.3) (+ 0.06 (* 0.32 s)))))))]
          [else (* 0.4 (exp (- (sqr (/ (- rho 1.12) (+ 0.04 (* 0.08 s)))))))]))
  (define ring (* 0.95 (exp (- (sqr (/ (- rho 1.04) 0.05))))))
  (define stars (if (> rho 1) 0.00003 0))                    ; a few, scattered
  (max 0 (min 1 (+ stars (* side (max arc ring)) disk))))

;; Stippling: candidates in random order, kept with probability brightness, never too close.
(define cell 12)
(define (stipple n)
  (random-seed 1916)                                         ; Schwarzschild's solution
  (define grid (make-hash))
  (define (key x y) (cons (quotient (exact-floor x) cell) (quotient (exact-floor y) cell)))
  (define (near? x y spacing)
    (for*/or ([i (in-range -1 2)] [j (in-range -1 2)])
      (define k (key x y))
      (for/or ([p (hash-ref grid (cons (+ (car k) i) (+ (cdr k) j)) '())])
        (< (+ (sqr (- x (car p))) (sqr (- y (cdr p)))) (sqr spacing)))))
  (for/fold ([dots '()]) ([_ n])
    (define x (* W (random))) (define y (* H (random)))
    (define b (brightness x y))
    (cond [(and (< (random) (expt b 0.8)) (not (near? x y (+ 2.1 (* 9 (expt (- 1 b) 1.5))))))
           (hash-update! grid (key x y) (λ (l) (cons (cons x y) l)) '())
           (cons (cons x y) dots)]
          [else dots])))

(define dots (reverse (stipple 1500000)))

(define (picture file ink)
  (with-output-to-file file #:exists 'truncate
    (λ ()
      (printf "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 ~a ~a\" role=\"img\" aria-label=\"a black hole and its accretion disk, in dots\">\n" W H)
      (printf "<g fill=\"~a\">\n" ink)
      (for ([p dots])
        (printf "<circle cx=\"~a\" cy=\"~a\" r=\"1.3\"/>\n" (/ (round (* 10 (car p))) 10) (/ (round (* 10 (cdr p))) 10)))
      (printf "</g>\n</svg>\n"))))

(picture "static/img/hole-light.svg" "#111")
(picture "static/img/hole-dark.svg" "#eee")
