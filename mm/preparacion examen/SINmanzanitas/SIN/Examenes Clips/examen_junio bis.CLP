(deftemplate bloque
	(slot id)
	(slot encima-de)
)
(deffacts hechos
	(bloque (id b1) (encima-de mesa))
	(bloque (id b2) (encima-de b1))
	(bloque (id b3) (encima-de mesa))
	(bloque (id b4) (encima-de 8))
)
;ejercicio1

(defrule comprueba
	(bloque (id ?id) (encima-de ?x&~mesa))
	(not(bloque (id ?x) (encima-de ?y)))
	=>
	(printout t "El bloque " ?id " no esta ni en lo alto de otro bloque ni de la mesa" crlf)
)
;ejercicio 2
(defrule masdeuno
	(bloque (id ?id) (encima-de ?x&~mesa));b2
	(bloque (id ?x) (encima-de ?y&~?id));b1
	(bloque (id ?) (encima-de ?id));cualquiera distinto a b1 y b2
	=>
	(printout t "El bloque " ?x " tiene mas de un bloque encima" crlf)
)