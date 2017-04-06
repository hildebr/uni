#lang racket

;1.1
(define spiel #(0 0 0 0 0 9 0 7 0
                  0 0 0 0 8 2 0 5 0
                  3 2 7 0 0 0 0 4 0
                  0 1 6 0 4 0 0 0 0
                  0 5 0 0 0 0 3 0 0
                  0 0 0 0 9 0 7 0 0
                  0 0 0 6 0 0 0 0 5
                  8 0 2 0 0 0 0 0 0
                  0 0 4 2 0 0 0 0 8))

(define spiel-geloest #(1 2 3 5 4 7 6 8 9
                          4 5 6 2 9 8 1 3 7
                          7 8 9 3 6 1 2 4 5
                          5 4 7 1 2 3 8 9 6
                          2 9 8 4 5 6 3 7 1
                          3 6 1 7 8 9 4 5 2
                          6 1 4 8 7 5 9 2 3
                          8 3 5 9 1 2 7 6 4
                          9 7 2 6 3 4 5 1 8))

;1.1.1
(define (xy->index x y)
  (+ x (* y 9)))

;1.1.2
(define (zeile->indizes x)
  (map (curry + (* 9 x)) '(0 1 2 3 4 5 6 7 8)))


(define (spalte->indizes x)
  (map (curry + x) '(0 9 18 27 36 45 54 63 72)))

(define (quadrant->indizes x)
  (if (> x 2)
      (if (> x 5)
          (quadrant-helper x 36)
          (quadrant-helper x 18))
      (quadrant-helper x 0)))

(define (quadrant-helper x y)
  (map (curry + (* 3 x) y) '(0 1 2 9 10 11 18 19 20)))

;1.1.3
(define (spiel->eintraege spiel liste)
  (map (curry (lambda (x)
                (vector-ref spiel x)))
       liste))

;1.1.4
(define (spiel-geloest? spiel)
  (and (spiel-konsistent? spiel)
       (= 0 (vector-count (curry = 0) spiel))))

(define (spiel-konsistent? spiel)
  (konsistent-helper spiel 0))

(define (konsistent-helper spiel zahl)
  (if (< zahl 9)
      (if (and (liste-konsistent? (spiel->eintraege spiel (zeile->indizes zahl)))
               (liste-konsistent? (spiel->eintraege spiel (spalte->indizes zahl)))
               (liste-konsistent? (spiel->eintraege spiel (quadrant->indizes zahl))))
          (konsistent-helper spiel (+ zahl 1))
          #f)
      #t))

(define (liste-konsistent? liste)
  (and
   (not (check-duplicates (filter (curryr > 0) liste)))
   (andmap (curryr < 10) liste)))