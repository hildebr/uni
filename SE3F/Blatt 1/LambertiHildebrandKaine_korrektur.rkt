#lang racket

;; MB: Bite Aufgabennummer mit angeben und
;; sprechende Parameternamen verwenden.
;; Gesamt: 16/25

; Lars Lamberti 6799519, Alexander Hildebrandt 6688865, Lina Kaine 6499396

; Pi als Rückgabewert
(define pi
  (* 2 (asin 1.0)))

;; MB: 1.1. 4/4
;; Konvention für die Benennung für Konversionsfunktionen:
;; von->zu
; Bogenmaß in Gradzahlen (radians -> degrees)
(define (RadToDeg  x)
  (* x (/ 360 (* 2 pi))))

; Gradzahlen in Bogenmaß (degrees -> radians)
(define (DegToRad x)
  (* x (/ (* 2 pi) 360)))

;; MB: 1.3. 1/1 
; Nautische Meilen in Kilometer
(define (nm->km x)
  (* x 1.852))

;; MB: 2.1. 6/11
;; sin und cos erwarten Angaben in Radians
;; Das Ergebnis der Formel ist cos(dg), es muss noch der acos
;; davon genommen werden, um dg zu erhalten
;; Sprechende Variablennamen benutzen!
;; Testberechnungen fehlen.

; Berechnung der Großkreisentfernung d  von zwei Orten,  a,b = Ort A, x,y = Ort B
(define (Großkreis a b x y)
  (+ (* (sin a) (sin x))
     (* (cos a) (cos x)
        (cos (- b y)))))

; Berechnung der Entfernung zwischen zwei Orten in nautischen Meilen auf Basis des Großkreises
(define (Entfernung a b x y)
  (* (RadToDeg (Großkreis a b x y)) 60))

; Umrechnung der Entfernung in Kilometer (negative Werte manuell eingegeben)
(define (distanzAB a b x y)
  (nm->km (Entfernung a b x y)))
  
;; MB: 2.3. 5/6
;; Es gibt cond. ;)
; Berechnung der Himmelsrichtung einer gegebenen Gradzahl
(define (degreeToCardinal degree)
  (if (and (<= 0 degree) (< degree 22.5))
      "N"
      (if (and (<= 22.5 degree) (< degree 45))
          "NNE"
          (if (and (<= 45 degree) (< degree 67.5))
              "NE"
              (if (and (<= 67.5 degree) (< degree 90)) ;; MB: bei 90° ist ESE?
                  "E"
                  (if (and (<= 90 degree) (< degree 112.5))
                      "ESE"
                      (if (and (<= 112.5 degree) (< degree 135))
                          "SE"
                          (if (and (<= 135 degree) (< degree 157.5))
                              "SES"
                              (if (and (<= 157.5 degree) (< degree 180))
                                  "S"
                                  (if (and (<= 180 degree) (< degree 202.5))
                                      "SSW"
                                      (if (and (<= 202.5 degree) (< degree 225))
                                          "SW"
                                          (if (and (<= 225 degree) (< degree 247.5))
                                              "WSW"
                                              (if (and (<= 247.5 degree) (< degree 270))
                                                  "W"
                                                  (if (and (<= 270 degree) (< degree 292.5))
                                                      "WNW"
                                                      (if (and (<= 292.5 degree) (< degree 315))
                                                          "NW"
                                                          (if (and (<= 315 degree) (< degree 337.5))
                                                              "NWN"
                                                              (if (and (<= 337.5 degree) (<= degree 360))
                                                                  "NW"
                                                                  "WRONG VALUE")))))))))))))))))

; Berechnung des Grades einer gegebenen Himmelsrichtung
(define (cardinalToDegree cardinal)
  (if (equal? cardinal "N")
      0
      (if (equal? cardinal "NNE")
          22.5
          (if (equal? cardinal "NE")
              45
              (if (equal? cardinal "ENE")
                  67.5
                  (if (equal? cardinal "E")
                      90
                      (if (equal? cardinal "ESE")
                          112.5
                          (if (equal? cardinal "SE")
                              135
                              (if (equal? cardinal "SES")
                                  157.5
                                  (if (equal? cardinal "S")
                                      180
                                      (if (equal? cardinal "SSW")
                                          202.5
                                          (if (equal? cardinal "SW")
                                              225
                                              (if (equal? cardinal "WSW")
                                                  247.5
                                                  (if (equal? cardinal "W")
                                                      270
                                                      (if (equal? cardinal "WNW")
                                                          292.5
                                                          (if (equal? cardinal "NW")
                                                              315
                                                              (if (equal? cardinal "NNW")
                                                                  337.5
                                                                  "WRONG VALUE"
                                                                  )))))))))))))))))




