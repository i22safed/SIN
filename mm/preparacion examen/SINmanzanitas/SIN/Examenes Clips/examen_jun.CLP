(deftemplate bloque
	(slot id)
	(slot encima-de)

)
(deffacts hechos
	(bloque(id b1) (encima-de mesa))
	(bloque (id b2) (encima-de b1))
	(bloque (id b3) (encima-de mesa))
	(bloque (id b4) (encima-de b2))


)
;ejercicio 1
(defrule encuentra

	(bloque (id ?id) (encima-de ?x))
	(not
		(or
			(test (eq ?x mesa))
			(exists (bloque (id ?x)))))
			=>
		(printout t "El objeto " ?x " no se encuentra encima ni de mesa ni de otro bloque" crlf)	

)
;ejercicio 2

(defrule comprueba

	(bloque (id ?id) (encima-de ?x&~mesa))
	;(test (neq ?x mesa))
	(exists(bloque(id ?x) (encima-de ?y&:(eq ?y mesa))))
	(exists(bloque(id ?) (encima-de ?id)))
	=>
	(printout t "El bloque " ?x " tiene mas de un bloque encima" crlf))

;ejercicio 3

(defrule ciclo
	
	(bloque (id ?id) (encima-de ?x&~mesa))
	;(test (neq ?x mesa))
	(exists (bloque(id ?x) (encima-de ?y&:(eq ?y mesa))))
	(exists (bloque(id ?id2&:(neq ?id2 ?x)) (encima-de ?id)))
	=>
	(printout t "No hay ciclos" crlf)
)
;ejercicio3 bis
(defrule iniciaPila
	?h1<-(pila)
	(bloque (id ?x))
	=>
	(retract ?h1)
	(assert (pila ?x))	
)

(defrule continuaPila
	?h<-(pila $?cosas ?x)
	(bloque (id ?x) (encima-de ?y))
	(not (pila $? ?y $?))
	=>
	(retract ?h)
	(assert (pila $?cosas ?x ?y)))

(defrule detecta
	(pila $?cosas1 ?y $?cosas2 ?x) 
	(bloque (id ?x) (encima-de ?y))

	=>
	(printout t "Hay ciclo" crlf))
	