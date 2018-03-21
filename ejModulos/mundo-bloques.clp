;;;
;;; DEFINICION DE HECHOS PARA INDICAR LOS ESTADOS OBJETIVOS DEL
;;; SISTEMA.
;;;
(deffacts estado-inicial

;       (encima-de <inferior> <superior>)

; Caracterización de las entidades
        (bloque A)
        (bloque B)
        (bloque C)
        (bloque D)
        (bloque E)
        (bloque F)

; Caracterización de las relaciones
        (encima-de A nada)
        (encima-de B A)
        (encima-de C B)
        (encima-de suelo C)
        (encima-de D nada)
        (encima-de E D)
        (encima-de F E)
        (encima-de suelo F)


; Objetivos
        (movimiento-deseado E sobre suelo)
        (movimiento-deseado C sobre E)

)

 
;;;
;;; DEFINICION DE LAS REGLAS DE MOVIMIENTO DE BLOQUES
;;;


; Regla que mueve un bloque sobre otro directamente.

(defrule mover-directamente
        (bloque ?superior)
        (bloque ?inferior)
        ?dir <- (movimiento-deseado ?superior sobre ?inferior)
        (not (movimiento-deseado ?inferior sobre ?))
        (encima-de ?superior nada)
        ?dir2 <- (encima-de ?inferior nada)
=>
        (retract ?dir)
        (retract ?dir2)
        (assert (encima-de ?inferior ?superior))
        (printout t ?superior " esta sobre " ?inferior crlf)
)


; Regla que despeja el bloque superior
;
(defrule despejar-bloque-superior
        (bloque ?x);?x es un bloque
        (bloque ?encima); ?encima es un bloque
        (movimiento-deseado ?x sobre ?); Deseamos colocalr el bloque ?x sobre algo
        (not (encima-de ?x nada)) ;no es cierto que encima de ?x haya nada
        (encima-de ?x ?encima); encima de ?x está nada
=>
        (assert (movimiento-deseado ?encima sobre suelo))
)


; Regla que despeja el bloque inferior. 
 
(defrule despejar-bloque-inferior
        (bloque ?x)
        (bloque ?encima)
        (movimiento-deseado ? sobre ?x) ;Deseamos colocar algo sobre el bloque ?x
        (not (encima-de ?x nada))
        (encima-de ?x ?encima)
=>
        (assert (movimiento-deseado ?encima sobre suelo))
)


; Regla que mueve un bloque al suelo.
(defrule mover-al-suelo
        (bloque ?x)
        (bloque ?debajo)
        ?dir2 <- (movimiento-deseado ?x sobre suelo)
        (encima-de ?x nada)
        ?dir <- (encima-de ?debajo ?x)
=>
        (assert (encima-de suelo ?x))
        (assert (encima-de ?x nada))
        (assert (encima-de ?debajo nada))
        (retract ?dir)
        (retract ?dir2)
        (printout t ?x " esta en el SUELO." crlf)
)

; Regla con menor prioridad que permite eliminar aquellos
; deseos que ya se han producido pero no han sido eliminados
; de la agenda. Se utilizará al principio, cuando puedan existir
; deseos que esten satisfechos en la misma definición de los
; hechos iniciales.
(defrule solucion-duplicaciones
        (declare (salience -100))
        ?dir <- (movimiento-deseado ?x sobre ?y)
        (encima-de ?y ?x)
=>
        (retract ?dir)
)

 
