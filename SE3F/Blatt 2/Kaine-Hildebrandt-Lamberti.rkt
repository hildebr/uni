#lang racket

;Task 1
#|
1.X. Ausgabewert   -> Erklärung
1.1. 'Plueschi     -> miau ist definiert mit dem Rückgabewert 'Plueschi
1.2. 'Plueschi     -> katze definiert als miau. miau definiert mit dem Rückgabewert 'Plueschi
1.3. 'miau         -> tiger ist definiert mit dem Rückgabewert 'miau 
1.4. 'katze        -> quote gibt Variablen/Funktionen als Symbol zurück
1.5. 'Plueschi     -> eval nimmt tigers Wert "'miau" und berechnet dann die dazugehörige Funktion
1.6. undefined     -> versucht Plueschi zu evaluieren, aber es gibt keine Plueschi Funktion
1.7. 'miau         -> 'tiger direkt evauliert, da wir ein Symbol übergeben
1.8. 'harry        -> personA gespeichert in personC, personC dann als Rückgabewert.
                      'Sam überschreibt personA nicht bevor 'harry in personC kommt, da kein let* benutzt wird
1.9. '(miau katze) -> fängt beim dritten Tail-Element an und gibt dann die restliche Liste aus Rückgabewert
1.10. 'Plueschi    -> wertet den Tail '(miau katze) aus. Beides wird zu 'Plueschi ausgewertet und als ein einzelnes Element ausgegeben
1.11. 'Plueschi    -> miau wird zu 'Plueschi ausgewertet
1.12. 1.73.....    -> evaluiert das Ergebnis der Wurzelfunktion (eval ist hier unnötig, da die Wurzelfunktion so oder so ausgewertet wird)
1.13. 'tiger       -> evaluiert den Inhalt der Liste, also wird welcherNameGiltWo einfach ausgeführt
1.14. 'Plueschi    -> evaluiert das Ergebnis der Funktion welcherNameGiltWo, weshalb 'katze zu 'Plueschi wird
|#

;Task 2.1
;calculates the faculty of n
(define (faculty n)
  (if (> n 0)
      (* n (faculty (- n 1)))
      1))

;Task 2.2
;calculates r^n
(define (my-power r n)
  (if (> n 0)
      (if (even? n)
          (sqr (my-power r (/ n 2)))
          (* (my-power r (- n 1)) r))
      1))

;Task 2.3
;calculates the euler number
(define (eulerNumber)
  (/
   (+ 1 (bigHelperEuler 2))
   2))

;calculates all (remaining) fraction-segments for the euler number
(define (bigHelperEuler n)
  (if (< (helperEuler n) (/ 1 (my-power 10 1000)))
      0
      (+ (helperEuler n) (bigHelperEuler (+ n 1)))))

;calculates one fraction-segment for the euler number
(define (helperEuler n)
  (/ n (faculty (- n 1))))

;Task 2.4
;calculates pi. very inaccurate due to (my-power 5 6) being a very early break-condition
(define (pi)
  (*
   (- 1 (bigHelperPi 3 #t))
   4))

;calculates all (remaining) fraction-segments for pi
(define (bigHelperPi n bool)
  (if (< (helperPi n) (/ 1 (my-power 5 6)))
      0
      ;bool is used to determine whether the sign of a fraction-segment is positive or negative
      (if (and bool)
          (+ (helperPi n) (bigHelperPi (+ n 2) #f))
          (- (helperPi n) (bigHelperPi (+ n 2) #t)))))

;calculates one fraction-segment for pi
(define (helperPi n)
  (/ 1 n))

#|
Die Näherungsfolge konvergiert bei der Eulerzahl schneller,
da der Nenner der einzelnen Bruch-Elemente durch die Fakultät schneller wächst als die Nenner der Pi-Bruch-Elemente,
die in jedem Schritt nur um 2 erhöht werden.  
|#

;Task 3
;calculates the type of x
(define (type-of x)
  (cond
    [(boolean? x) "boolean"]
    [(pair? x) "pair"]
    [(list? x) "list"]
    [(symbol? x) "symbol"]
    [(number? x) "number"]
    [(char? x) "char"]
    [(string? x) "string"]
    [(vector? x) "vector"]
    [(procedure? x) "procedure"]
    [else "undefined"]))

#|
3.X. Ausgabewert -> Erklärung
3.1. number      -> berechnet das Ergebnis der Funktion zuerst und gibt dann den Typ des Ergebnisses
3.2. boolean     -> funktion (not x) gibt immer ein boolean (auch bei Zahlen als Parameter)
3.3. pair        -> die Liste besteht aus Head und Tail, also wird Pair ausgegeben
3.4. list        -> die leere Liste hat keinen Head und Tail, weil sie leer ist. Also ist list der Ausgabewert
3.5. procedure   -> (id z) gibt z zurück. Da z die sinus-Funktion ist, ist der Ausgabewert procedure
3.6. char        -> string-ref gibt einen char aus einem gegebenen String zurück, also ist der Ausgabewert immer char
3.7. procedure   -> lambda ist eine annonyme Funktion, die hier nur definiert, aber nicht aufgerufen wird.
                    Deshalb ist der Ausgabewert procedure statt der tatsächliche Typ von x
3.8. procedure   -> type-of ist eine Funktion, also gibt es den Ausgabewert procedure zurück
3.9. string      -> (type-of type-of) wird ausgeführt und gibt den String "procedure" zurück,
                    der Ausgabewert von (type-of "procedure") ist offensichtlich String
|#