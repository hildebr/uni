#lang racket

;Aufgabe 1
#|
Nr. Ergebnis         -> Erklärung
1.  8                -> (- 6 7) => -1, (min 5 -1) => -1, (max -1 8) => 8
2.  '(+ (- 11 13) 17)-> Anführungszeichen stoppt Auswertung
3.  'Jahre           -> cadr gibt den Head vom Tail der Eingabeliste
4.  '()              -> cddr nimmt den Tail vom Tail der Eingabeliste,
                        der Tail von '((das Christuskind)) ist leer
5.  '(Auf die Erde nieder) -> Wenn der 2. cons-Parameter eine Liste ist,
                              erhält man eine Liste mit den Parametern
6.  '(Wo . wir)      -> Wenn der 2. cons-Parameter keine Liste ist,
                        erhält man ein Pair mit den Parametern
7.  #t               -> Inhaltsvergleich von 2 identischen Listen
8.  #f               -> Vergleicht, ob das selbe Objekt referenziert wird
|#

;Aufgabe 2.1
#|
Erweiterte Backus-Naur-Form für Notmeldungen:
Terminale sind immer Strings
upper case Nichtterminale für Nachrichtenübergreifende Syntax
lower case Nichtterminale für nutzerabhängige Infos

buchstabe    = "A" | "B" | ... | "Z";
wort         = buchstabe, { buchstabe };
ziffer       = "0" | "1" | ... | "9";
zahl         = ziffer, { ziffer };

MAYDAY       = "M", "A", "Y", "D", "A", "Y";
DE           = "H", "I", "E", "R", " ", "I", "S", "T" |
               "D", "E", "L", "T", "A", " ", "E", "C", "H", "O";
schiffname   = wort;
buchstabiert = wort, { wort };
rufzeichen   = wort, wort, wort, wort;


ÜBERSCHRIFT  = MAYDAY, MAYDAY, MAYDAY, DE, schiffname, schiffname,
               schiffname, rufzeichen, MAYDAY, schiffname,
               buchstabiert, rufzeichen;
position     = wort, { wort , zahl };
notfallart   = wort, { wort , zahl };
sonstiges    = wort, { wort , zahl };
peilzeichen  = "-", "-";
unterschrift = schiffname, rufzeichen;

NOTNACHRICHT = ÜBERSCHRIFT, position, notfallproblem,
               peilzeichen, unterschrift, "O", "V", "E", "R";
|#

;Aufgabe 2.2
;generates the full emergency message
;expects all parameters to be uppercase string
(define (emergencySignal shipname callsign position problem)
  (string-append (generateHeader shipname callsign) "~n"
                 (generatePosition position) "~n"
                 problem "~n"
                 "-- ~n"
                 (generateSignature shipname callsign) "~n"
                 "OVER~n~n"))

;generates the header for emergency signals
(define (generateHeader shipname callsign)
  (let [(CALLSIGN (translateText callsign))]
  (string-append "MAYDAY MAYDAY MAYDAY ~n"  DE "~n" shipname " "
                 shipname " " shipname " " CALLSIGN "~nMAYDAY "
                 shipname " " (translateText shipname) "~n" CALLSIGN)))

;generates a random delta echo string
(define DE
  (if (= 0 (random 2))
      "DELTA ECHO"
      "HIER IST"))

;generates the position string
(define (generatePosition position)
  (string-append "NOTFALLPOSITION " position))

;generate the signature string
(define (generateSignature shipname callsign)
  (string-append shipname " " (translateText callsign)))

;last weeks spelling alphabet definitions
;unchanged assoc list
(define spellingLetter
  '(("A" . "ALPHA")("B" . "BRAVO")("C" . "CHARLIE")
    ("D" . "DELTA")("E" . "ECHO") ("X" . "X-RAY")
    ("F". "FOXTROTT") ("Y". "YANKEE")("G" ."GOLF")
    ("Z". "ZULU")("H". "HOTEL") ("0". "NADAZERO")
    ("I". "INDIA") ("1". "UNAONE")("J". "JULIETT")
    ("2". "BISSOTWO")("K" ."KILO") ("3". "TERRATHREE")
    ("L". "LIMA") ("4". "KARTEFOUR")("M". "MIKE")
    ("5". "PENTAFIVE")("N" ."NOVEMBER") ("6". "SOXISIX")
    ("O". "OSCAR") ("7". "SETTESEVEN")("P" ."PAPA")
    ("8". "OKTOEIGHT")("Q". "QUEBEC") ("9". "NOVENINE")
    ("R". "ROMEO") ("," ."DECIMAL")("S". "SIERRA")
    ("." . "STOP") ("T" . "TANGO") ("U" . "UNIFORM")
    ("V" . "VIKTOR") ("W" . "WHISKEY")))

;changed to deal with unexpected input
(define (findLetter letter)
  (let [(assocResult (assoc (make-string 1 letter) spellingLetter))]
    (if (equal? #f assocResult)
        (string letter)
        (cdr assocResult))))

;changed to output strings instead of lists
(define (translateText stringText)
  (let [(charList (string->list stringText))]
    (if (empty? charList)
        ""
        (if (= 1 (length charList))
            (findLetter (car charList))
            (string-append (findLetter (car charList)) " "
                           (translateText (substring stringText 1)))))))

;Aufgabe 2.3
;Seaside emergency
(printf(emergencySignal "SEASIDE" "SSDE"
                 "UNGEFÄHR 10 SM NORDÖSTLICH LEUCHTTURM KIEL"
                 "NOTFALLZEIT 1000 UTC SCHWERER WASSEREINBRUCH WIR SINKEN KEINE VERLETZTEN VIER MANN GEHEN IN DIE RETTUNGSINSEL SCHNELLE HILFE ERFORDERLICH"))

;Amira emergency
(printf(emergencySignal "AMIRA" "AMRY"
                 "57°46'N, 006°31'E"
                 "NOTFALLZEIT 0640 UTC, IN SCHWERER SEE GEKENTERT, 9 MANN AN BORD, SCHIFFLÄNGE 15M, GRÜNER RUMPF"))

;Aufgabe 3.1
#|
Innere Reduktion reduziert die Terme von innen nach außen,
äußere Reduktion reduziert die Terme von außen nach innen.

Innere Reduktion:
    (hoch4 (* 3 (+ 1 (hoch4 2))))
        ->(hoch4 (* 3 (+ 1 (* 2 2 2 2)))):(hoch4)
        ->(hoch4 (* 3 (+ 1 16)))         :(*)
        ->(hoch4 (* 3 17))               :(+)
        ->(hoch4 51)                     :(*)
        ->(* 51 51 51 51)                :(hoch4)
        -> 6765201                       :(*)

Äußere Reduktion:
    (hoch4 (* 3 (+ 1 (hoch4 2))))
        ->(* (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))
             (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))) :(hoch4)

        ->(* (* 3 (+ 1 (* 2 2 2 2))) (* 3 (+ 1 (hoch4 2)))
             (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))) :(hoch4)

        ->(* (* 3 (+ 1 16)))         (* 3 (+ 1 (hoch4 2)))
             (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))) :(*)

        ->(* (* 3 17))               (* 3 (+ 1 (hoch4 2)))
             (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))) :(+)

        ->(*  51                     (* 3 (+ 1 (hoch4 2)))
             (* 3 (+ 1 (hoch4 2)))   (* 3 (+ 1 (hoch4 2)))) :(*)

        Das gleiche für die anderen 3 Terme...

        ->(* 51 51 51 51)
        ->6765201             :(*)
|#

;Aufgabe 3.2
#|
Normale Funktionen: innere Reduktion
Spezialformen: äußere Reduktion
|#

;Aufgabe 3.3
(define (new-if condition? then-clause else-clause)
  (cond ( condition? then-clause )
        ( else else-clause )))

(define (faculty product counter max-count)
  (new-if (> counter max-count)
          product
          ( faculty (* counter product )
                    (+ counter 1)
                    max-count)))
#|
(faculty 1 1 5) sorgt für eine Endlosschleife, da bei einer
normalen Funktion wie new-if innere Reduktion benutzt wird.
Durch die innere Reduktion werden die rekursiven Aufrufe
ausgeführt, bevor die condition?-Abfrage evaluiert wird.
|#