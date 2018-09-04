;ejercicio8

(deffacts hechos
	(vector vector1 1 2 3 4 5); si se cumple por que esta ordenado,por lo tanto no se muestra por pantalla
	(vector vector2 1 2 5 4); vector desordenado, mostrara el nombre por pantalla
	(vector vector2 2 3 14 1)
)


(defrule detectar
	(vector ?nombre $?ant ?x ?y $?post)
	(test(> ?x ?y))
	(not(comprobado ?))
	
	=>
	(assert (comprobado 1))
	(printout t "El vector "?nombre" no est\'e1 ordenado" crlf)
)
	