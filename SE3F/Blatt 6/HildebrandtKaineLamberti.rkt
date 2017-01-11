#lang racket

;Aufgabe 1
#|
kopfstueck: linear, nicht Baum, nicht geschachtelt, direkt
Ruft nur sich selbst einmal direkt auf, ohne andere Rekursionen zu betrachten

endstueck: linear, nicht Baum, nicht geschachtelt, direkt
Siehe kopfstueck

merge: nicht linear, Baum, nicht geschachtelt, direkt
Nicht linear sondern Baum, da 2 Aufrufe von merge vorkommen.
Sonst wie kopfstueck

merge-sort: nicht linear, Baum, geschachtelt, indirekt
Nicht linear sondern Baum, da 2 Aufrufe von merge-sort vorkommen.
Geschachtelt, da für die merge-sort Aufrufe vorher andere Rekursionen nötig sind.
merge-sort enthält auch indirekte Rekursion, da hier andere Rekursionen aufgerufen werden.
|#


;Aufgabe 2
(require 2htdp/image)

;blue sky background
(define frame (empty-scene 450 300 (color 1 1 120)))

;transparent scene to cover the whole background to work with place-image later
(define transparent-scene (rectangle 450 300 "solid" (color 0 0 0 0)))

;creates a scenery for our picture
(define scenery (underlay
                 (place-image (ellipse 1200 95 "solid" (color 235 235 235)) 300 270 transparent-scene)
                 (place-image (ellipse 300 150 "solid" (color 40 240 40)) 150 300 transparent-scene)
                 (place-image (ellipse 300 150 "solid" (color 40 240 40)) 300 300 transparent-scene)))

;creates a star with white outline
(define outlined-star (underlay
                       (star 17 "solid" (color 255 250 255 100))
                       (star 10 "solid" "yellow")))
           
;creates a present with the given colors
(define (present color1 color2 color3) 
  (above/align "center"
               (beside
                (rotate 135 (ellipse 15 5 "outline" "gold"))
                (flip-horizontal
                 (rotate 135 (ellipse 15 5 "outline" "gold"))))
               (underlay
                (underlay (rectangle 40 35 "solid" (color color1 color2 color3))
                          (rectangle 3 35 "solid" "gold"))
                (rectangle 40 3 "solid" "gold"))))

;creates a bauble for the tree. small ellipse used for light glow effect
(define (baubles color1 color2 color3)
  (above/align "center" 
               (ellipse 5 2 "solid" "gold")
               (underlay/xy
                (ellipse 20 20 "solid" (color color1 color2 color3))
                5 5
                (ellipse 5 5 "solid" "white"))))

;creates a christmas tree with overlayed triangles
;also sets the above mentioned baubles in place
(define christmas-tree (underlay/xy
                        (underlay/xy
                         (underlay/xy
                          (underlay/xy
                           (underlay/xy
                            (underlay/xy
                             (above/align "center"
                                          (overlay/xy
                                           (overlay/xy
                                            (overlay/xy
                                             (overlay/xy
                                              (overlay/xy
                                               (rectangle 1 1 "solid" (color 0 0 0 0))
                                               40 2
                                               (radial-star 6 6 30 "solid" "yellow"))
                                              30 30
                                              (isosceles-triangle 60 70 "solid" "darkgreen"))
                                             20 50
                                             (isosceles-triangle 80 70 "solid" "darkgreen"))
                                            10 70
                                            (isosceles-triangle 100 70 "solid" "darkgreen"))
                                           0 90
                                           (isosceles-triangle 120 70 "solid" "darkgreen"))
                                          (rectangle 30 40 "solid" "brown"))
                             40 100
                             (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155))))
                            60 70
                            (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155))))
                           70 120
                           (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155))))
                          90 150
                          (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155))))
                         20 160
                         (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155))))
                        45 135
                        (baubles (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155)))))
                                               

;uses tree-recursion to set up the above mentioned presents in a stack with random colors
(define (present-stack ebenen)
  (above/align "center"
               (present (+ 100 (random 155)) (+ 100 (random 155)) (+ 100 (random 155)))
               (if (= ebenen 1)
                   (rectangle 1 1 "solid" (color 0 0 0 0))
                   (beside/align "center"
                                 (present-stack (- ebenen 1))
                                 (present-stack (- ebenen 1))))))

;creates a starlit sky with the above mentioned star function
(define (starlit-sky star-amount scene)
  (if (= star-amount 1)
      (place-image outlined-star (+ (random 450) 25) (+ 30 (random 120)) scene)
      (underlay (place-image (rotate (+ 1 (random 359)) (scale (/ (+ (random 99) 1) 100) outlined-star)) (+ (random 450) 25) (+ 30 (random 120)) scene) (starlit-sky (- star-amount 1) scene))))
   

;put together all modules of the picture
(define create-picture (underlay
                        frame
                        scenery
                        (starlit-sky 20 transparent-scene)
                        (place-image christmas-tree 125 145 transparent-scene)
                        (place-image (present-stack 2) 300 240 transparent-scene)
                        ))

;prints the full picture
(print create-picture)