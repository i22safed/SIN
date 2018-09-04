;ejercicio 3

(deffacts hechos
	(datos 4 5)
	(datos 5 2)
	(datos 4 1)
	(datos 4 9)
)


(defrule mayor
	?h1<-(datos ?x ?y)
	(test(> ?y  ?x))
	=>
	(printout t "El hecho" ?h1 "cumple que el segundo valor: "?y" es mayor que el primero: " ?x crlf)
)
