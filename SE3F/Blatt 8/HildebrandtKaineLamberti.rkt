#lang racket

;Aufgabe 1
;.1
#|
Eine Funktion höherer Ordnung ist eine spezielle Funktion,
die selbst eine Funktion als Parameter erhält oder eine
Funktion zurückgibt.
|#

;.2
#|
(a) Ja, foldr ist eine vorgefertigte Funktion höherer Ordnung.
(b) Nein, da das Parameter eine Zahl und die Rückgabe ein Symbol ist.
(c) Ja, da der erste Parameter "f" eine Funktion ist.
(d) Ja, da der einzige Parameter "f" eine Funktion ist.
|#

;.3
#|
Der Aufruf ((masala / 1) 3) gibt eine Funktion zurück (lambda; im Körper
definiert). Das lambda ist allerdings noch nicht vollständig, es fehlt
noch der Wert für den Parameter arg2. Dieser Wert wird dann auf genau die
selbe Art an masala übergeben, wie man es auch mit einem normalen lambda
ohne Wrapper macht. Zu beachten ist hierbei, dass der Wert "3" im Aufruf
eigentlich ausßerhalb des Funktions-Scopes steht, aber dennoch zugegriffen
werden kann. Die "3" wird dann erst nach Definition an arg2 gebunden. Das
Binden finder also quasi "von außen" statt.
|#

;.4
(define (flip f)
  (lambda (x y) (f y x)))
#|
(a) Rückgabe: 162
   |Von rechts nach links werden allen Listen-Elemente mal 3 und mal
   |dem Ergebnis der letzten Iteration gerechnet.
(b) Rückgabe: '((3 . 1) (2 . 2) (1 . 3))
   |Die gegebenen Listen werden mit cons zu Paaren verbunden. Durch
   |flip werden die Elemente der 2. Liste zu  den 1. Elementen in 
   |der Rückgabeliste.
(c) Rückgabe: '((a b) () (()))
   |filter soritert alle Listenelemente aus, die selbst keine Liste
   |sind. Im Beispiel sind alle Elemente außer "1" eine Liste.
(d) Rückgabe: '(-5505.0 -100.0 0 273.15)
   |Jedes Listenelement wird von 32 abgezogen und danach noch durch 
   |1.8 dividiert. Die Ergebnisse sind dann nacheinander in der Liste.
|#

;Aufgabe 2
(define liste '(-5 -3 -2 -1 0 1 2 3 5 13 20))

;.1
(define (absoluteValues xs)
  (map abs xs))

;.2
(define (dividable13 xs)
  (filter (lambda (x)
            (if (= 0 (modulo x 13))
                          #t
                          #f))
          xs))

;.3
(define (sumUpEven&Greater3 xs)
  (foldr (lambda (x result)
           (if (> x 3)
               (+ x result)
               result))
         0
         (filter even? xs)))