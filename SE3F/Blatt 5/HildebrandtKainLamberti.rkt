#lang racket

(require se3-bib/butterfly-module)

;Aufgabe 1
#|
Analyse/Entwurf:
Die vier Typen von Merkmale werden in jeweils einer einfachen Liste
gespeichert. Da diese Merkmale nicht auf irgendetwas abgebildet werden
müssen, braucht man hier keine assoc-Liste oder ähnliches.

Die Hauptmethode braucht 8 Parameter, um die Merkmale von beiden Eltern
entgegen nehmen zu können. Für jedes Merkmal muss dann bestimmt werden,
welche rezessiven Merkmale für dieses Merkmal überhaupt möglich sind.
Eine Hilfsfunktion gibt dann alle möglichen Merkmale als eine Liste aus
und daraufhin muss man zufällig ein Merkmal aus der Liste nehmen und dem
jeweiligen Elternteil zuweisen. Mit den 16 Parametern für dominante und
rezessive Gene kann nun eine andere Funktion zur Kinderzeugung starten.

Eine Funktion muss nun aus allen Parametern eines Elternteils wählen,
welches von ihnen an das zu erzeugende Kind geht. Nachdem ein zu erzeugendes
Kind je 4 Merkmale von jedem Elternteil bekommen hat, muss schlussendlich
nur noch jeweils das Merkmal zur Darstellung des Kindes gewählt werden,
das dominanter ist. Der letzte Schritt ist dann der rekursive Aufruf der
Funktion, um so viele Schmetterlinge zu erzeugen, wie es vom Nutzer
verlangt wird. Für die Anzahl der Rekursionsaufrufe muss deshalb noch an
der Hauptmethode ein neuntes Parameter als Integer übergeben werden.
|#

;Implementation
;main method. creates random recessive traits and then invokes a helper
(define (make-children patternM patternF wingsM wingsF
                       antennaM antennaF colorM colorF amount)
  (let [(recPatternM (car (shuffle (findRecessiveTraits patternM))))
        (recPatternF (car (shuffle (findRecessiveTraits patternF))))
        (recWingsM   (car (shuffle (findRecessiveTraits wingsM))))
        (recWingsF   (car (shuffle (findRecessiveTraits wingsF))))
        (recAntennaM (car (shuffle (findRecessiveTraits antennaM))))
        (recAntennaF (car (shuffle (findRecessiveTraits antennaF))))
        (recColorM   (car (shuffle (findRecessiveTraits colorM))))
        (recColorF   (car (shuffle (findRecessiveTraits colorF))))
        ]
    (make-children-helper patternM patternF wingsM wingsF
                          antennaM antennaF colorM colorF
                          recPatternM recPatternF recWingsM recWingsF
                          recAntennaM recAntennaF recColorM recColorF
                          amount)
    )
  )

;recursive helper to create a child after reading the dominant traits
(define (make-children-helper patternM patternF wingsM wingsF
                              antennaM antennaF colorM colorF
                              recPatternM recPatternF recWingsM recWingsF
                              recAntennaM recAntennaF recColorM recColorF
                              amount)
  (letrec [(patternNumberM (random 2)) (wingsNumberM (random 2))
                                     (antennaNumberM (random 2)) (colorNumberM (random 2))
                                     (patternNumberF (random 2)) (wingsNumberF (random 2))
                                     (antennaNumberF (random 2)) (colorNumberF (random 2))
                                     (dominantPattern (findDominantTrait
                                                       (if (= 0 patternNumberM)
                                                           patternM
                                                           recPatternM)
                                                       (if (= 0 patternNumberF)
                                                           patternF
                                                           recPatternF)))
                                     (dominantWings (findDominantTrait
                                                     (if (= 0 wingsNumberM)
                                                         wingsM
                                                         recWingsM)
                                                     (if (= 0 wingsNumberF)
                                                         wingsF
                                                         recWingsF)))
                                     (dominantAntenna (findDominantTrait
                                                       (if (= 0 antennaNumberM)
                                                           antennaM
                                                           recAntennaM)
                                                       (if (= 0 antennaNumberF)
                                                           antennaF
                                                           recAntennaF)))
                                     (dominantColor (findDominantTrait
                                                     (if (= 0 colorNumberM)
                                                         colorM
                                                         recColorM)
                                                     (if (= 0 colorNumberF)
                                                         colorF
                                                         recColorF)))]
    (print (show-butterfly dominantColor dominantPattern
                           dominantAntenna dominantWings))
    (if (= amount 1)
        (printf "\n")
        (make-children-helper patternM patternF wingsM wingsF
                              antennaM antennaF colorM colorF
                              recPatternM recPatternF recWingsM recWingsF
                              recAntennaM recAntennaF recColorM recColorF
                              (- amount 1)))))
  
  
;returns a list of possible recessive traits for a given trait 
(define (findRecessiveTraits trait)
  (let [(patternMember (member trait patternTraits))
        (wingsMember   (member trait wingsTraits))
        (antennaMember (member trait antennaTraits))
        (colorMember   (member trait colorTraits))]
    (cond [patternMember patternMember]
          [wingsMember   wingsMember]
          [antennaMember antennaMember]
          [colorMember   colorMember]
          ))
  )

;returns the dominant trait from the two given traits
(define (findDominantTrait trait1 trait2)
  (cond [(member trait1 patternTraits)
         (if (> (index-of trait1 patternTraits)
                (index-of trait2 patternTraits))
             trait2
             trait1)]
        [(member trait1 wingsTraits)
         (if (> (index-of trait1 wingsTraits)
                (index-of trait2 wingsTraits))
             trait2
             trait1)]
        [(member trait1 antennaTraits)
         (if (> (index-of trait1 antennaTraits)
                (index-of trait2 antennaTraits))
             trait2
             trait1)]
        [(member trait1 colorTraits)
         (if (> (index-of trait1 colorTraits)
                (index-of trait2 colorTraits))
             trait2
             trait1)]))

;list of patterns in dominance order
(define patternTraits
  (list 'star 'dots 'stripes))

;list of wings in dominance order
(define wingsTraits
  (list 'rhomb 'ellipse 'hexagon))

;list of antennas in dominance order
(define antennaTraits
  (list 'curved 'curly 'straight))

;list of colors in dominance order
(define colorTraits
  (list 'green 'red 'blue 'yellow))

;find index of ele in list lst
(define (index-of ele lst)
  (let loop ((lst lst)
             (idx 0))
    (cond ((empty? lst) #f)
          ((equal? (first lst) ele) idx)
          (else (loop (rest lst) (add1 idx))))))

;test with the most recessive genes
;reasoning: the function has to display the same butterfly in every way to validate the main function
(make-children 'stripes 'stripes 'hexagon 'hexagon 'straight 'straight 'yellow 'yellow 6)
;test with the most recessive genes except for color
;reasoning: the function has to display the same butterfly in every way except for the color to validate the main function
(make-children 'stripes 'stripes 'hexagon 'hexagon 'straight 'straight 'red 'blue 6)
;test with the most dominant genes
;reasoning: the function has to display all kinds of butterflies to  validate the main function
(make-children 'star 'dots 'rhomb 'ellipse 'curved 'curly 'green 'red 6)
;test with the most dominant genes again
;reasoning: this invokation should display different kinds of butterflies in comparision to the last invokation to validate the main function
(make-children 'star 'dots 'rhomb 'ellipse 'curved 'curly 'green 'red 6)
