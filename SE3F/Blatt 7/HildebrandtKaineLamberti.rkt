#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;Aufgabe 1
;allgemein rekursiv
(define (produkt n f)
  (if (empty? n)
      '()
      (cons (* f (car n)) (produkt (cdr n) f))))

;endrekursiv
(define (produkt-E n f)
  (produkt-E-Helper n f '()))

;endrekursiv helper
(define (produkt-E-Helper n f akku)
  (if (empty? n)
      akku
      (produkt-E-Helper (cdr n)
                        f
                        (append akku (list (* f (car n)))))))

;Funktion höherer Ordnung
(define (produkt-FHO n f)
  (map (curry * f) n))


;Aufgabe 2.1
#|
Kodierung der Sieben-Segment Anzeige:
Da die Anzeige aus sieben Strichen besteht, muss man für
jeden möglichen Zustand sieben Werte speichern. Es bietet
sich an, diese sieben Werte in Listen zu speichern. "1"
repräsentiert an, "0" repräsentiert aus. Die Reihenfolge
der Segmentwerte in der Liste ist bestimmt mit:
von oben nach unten, von links nach rechts.
|#
(define null '(1 1 1 0 1 1 1))
(define eins '(0 0 1 0 0 1 0))
(define zwei '(1 0 1 1 1 0 1))
(define drei '(1 0 1 1 0 1 1))
(define vier '(0 1 1 1 0 1 0))
(define fünf '(1 1 0 1 0 1 1))
(define sechs '(1 1 0 1 1 1 1))
(define sieben '(1 0 1 0 0 1 0))
(define acht '(1 1 1 1 1 1 1))
(define neun '(1 1 1 1 0 1 1))

;Liste aller Zustände in einer Abfolge:
(define 7segment-Zustände
  (list null eins zwei drei vier
        fünf sechs sieben acht neun))

;Aufgabe 2.2
;Baut eine Sieben-Segment Anzeige mit gegebenem Zustand
(define (7segment zustand)
  (underlay/xy
   (underlay/xy
    (underlay/xy
     (underlay/xy
      (underlay/xy
       (underlay/xy
        (underlay/xy
         (rectangle 100 200 "solid" "black")
         10 5
         (rectangle 80 10 "solid" (zustandEval (list-ref zustand 0))))
        0 15
        (rectangle 10 80 "solid" (zustandEval (list-ref zustand 1))))
       90 15
       (rectangle 10 80 "solid" (zustandEval (list-ref zustand 2))))
      10 95
      (rectangle 80 10 "solid" (zustandEval (list-ref zustand 3))))
     0 105
     (rectangle 10 80 "solid" (zustandEval (list-ref zustand 4))))
    90 105
    (rectangle 10 80 "solid" (zustandEval (list-ref zustand 5))))
   10 185
   (rectangle 80 10 "solid" (zustandEval (list-ref zustand 6)))))

;Hilfsfunktion: Wählt die Farbe eines Segments mit gegebener Zahl
(define (zustandEval n)
  (if (= n 0)
      "DimGray"
      "Red"))

;Aufgabe 2.3
;Baut eine Sieben-Segment Anzeige anhand der gegebenen Zeiteinheit
(define (zeige-7segment t)
  (if (> t 280)
      (zeige-7segment (- t 280))
      (7segment (cond
                  [(< t 28) (list-ref 7segment-Zustände 0)]
                  [(< t 56) (list-ref 7segment-Zustände 1)]
                  [(< t 84) (list-ref 7segment-Zustände 2)]
                  [(< t 112) (list-ref 7segment-Zustände 3)]
                  [(< t 140) (list-ref 7segment-Zustände 4)]
                  [(< t 168) (list-ref 7segment-Zustände 5)]
                  [(< t 196) (list-ref 7segment-Zustände 6)]
                  [(< t 224) (list-ref 7segment-Zustände 7)]
                  [(< t 252) (list-ref 7segment-Zustände 8)]
                  [else (list-ref 7segment-Zustände 9)]))))

(animate zeige-7segment)

