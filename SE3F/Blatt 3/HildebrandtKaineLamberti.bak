#lang racket

(require se3-bib/flaggen-module)
;Aufgabe 1.1
#|
Erklärung: association lists sind für key-value Verbindungen gemacht,
wodurch sie sich gut für eine Abbildung von Buchstaben auf Wörter eignen.
Die Buchstaben und Wörter sind als String gespeichert, da uns eine
Darstellung als Symbol keinen großen Vorteil bringen würde. Die Datenstruktur
benutzt Pairs statt Listen, da die "cdr" Funktion auf Pairs einen
schöneren Rückgabewert hat.
|#
;contains a list of pairs for the spelling alphabet 
(define spellingLetter
  '(("A" . "Alpha")("B" . "Bravo")("C" . "Charlie")
    ("D" . "Delta")("E" . "Echo") ("X" . "X-ray")
    ("F". "Foxtrott") ("Y". "Yankee")("G" ."Golf")
    ("Z". "Zulu")("H". "Hotel") ("0". "Nadazero")
    ("I". "India") ("1". "Unaone")("J". "Juliett")
    ("2". "Bissotwo")("K" ."Kilo") ("3". "Terrathree")
    ("L". "Lima") ("4". "Kartefour")("M". "Mike")
    ("5". "Pantafive")("N" ."November") ("6". "Soxisix")
    ("O". "Oscar") ("7". "Setteseven")("P" ."Papa")
    ("8". "Oktoeight")("Q". "Quebec") ("9". "Novenine")
    ("R". "Romeo") ("," ."Decimal")("S". "Sierra")
    ("." . "Stop") ("T" . "Tango") ("U" . "Uniform")
    ("V" . "Viktor") ("W" . "Whiskey") ))

;Aufgabe 1.2.
;finds the word of the spelling alphabet for a given character
(define (findLetter letter)
  (cdr (assoc (make-string 1 letter) spellingLetter)))

;Aufgabe 1.3.
;if the given character is lower case, it is morphed to upper case
(define (upperLowerCase charA)
  (let [(intA (char->integer charA))]
  (if (and (<= 97 intA) (<= intA 122))
      (integer->char (- (char->integer charA) 32))
      charA)))

;Aufgabe 1.4.
;translates a string text into a list that contains the proper word
;from the spelling alphabet for every character in the string
(define (translateText stringText)
  (let [(charList (string->list stringText))]
    (if (= 1 (length charList))
        (list (findLetter (car charList)))
        (append (list (findLetter (car charList))) (translateText (substring stringText 1))))))

;Aufgabe 2.1.
#|
association list mit pairs aus dem selbem Grund wie oben. Die Map besteht aus
(char procedure)-Paaren, damit man beim Benutzen einer char liste weniger
Konvertierungsarbeit hat.
|#
;contains a list of pairs for the flag alphabet
(define flagLetter
  '((#\A . A) (#\B . B) (#\C . C) (#\D . D) (#\E . E) (#\F . F) (#\G . G)
    (#\H . H) (#\I . I) (#\J . J) (#\K . K) (#\L . L) (#\M . M) (#\N . N)
    (#\O . O) (#\P . P) (#\Q . Q) (#\R . R) (#\S . S) (#\T . T) (#\U . U)
    (#\V . V) (#\W . W) (#\X . X) (#\Y . Y) (#\Z . Z) (#\0 . Z0) (#\1 . Z1)
    (#\2 . Z2) (#\3 . Z3) (#\4 . Z4) (#\5 . Z5) (#\6 . Z6) (#\7 . Z7)
    (#\8 . Z8) (#\9 . Z9) (#\0 . Z0)))

;Aufgabe 2.2
;finds the flag for a given character
(define (findFlagLetter char)
  (eval (cdr (assoc char flagLetter))))

;Aufgabe 2.3.
;translates a string text to a list of flags that correspond
;to the characters of the string text
(define (translateToFlags stringText)
  (let [(charList (string->list stringText))]
    (if (= 1 (length charList))
        (list (findFlagLetter (car charList)))
        (append (list (findFlagLetter (car charList))) (translateToFlags (substring stringText 1))))))