

;
;18.-	Haz un programa que dado un único hecho vector, detecte si sus
;    valores se repiten de forma simétrica. Siempre que la salida sea
;    correcta, puedes modificar el vector o utilizar hechos auxiliares.
;    Lo siguiente es una posible solución entre muchas posibilidades
;



(deffacts vectores
	
	(vector v1 1 2 4 5 4 3 2 1)
	(vector v2 1 2 3 4 5)
	(vector v3 5 5 5 5 5 5)
	(vector v4 7 8 0 8 7)
	(vector v5 1 2 3 4 5 4 3 2)
)


(defrule detectaSimetrico
	(vector ?nombre $?valores)
	(forall (vector ?nombre $?cabeza ?x $?medio ?y
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
			(test (eq ?x ?y)))
	=>
	(printout t "El vector " ?nombre " es simétrico" crlf))

(defrule detectaNoSimetrico
	(vector ?nombre $?cabeza ?x $?medio ?y&~?x
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
	=>
	(printout t "El vector " ?nombre " no es simétrico" crlf))


