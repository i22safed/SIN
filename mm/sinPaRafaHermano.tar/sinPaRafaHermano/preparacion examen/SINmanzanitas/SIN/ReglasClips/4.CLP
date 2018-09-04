;ejercicio4

(deffacts hechos 
	(datos 2 5 24 5 62 4 2 8);si se cumple
	(datos 24  23 4 1  5 2  4 2);no se cumple
	(datos 1 34 45 34 2)
)

(defrule par
	(datos ?principio $? ?final&:(evenp ?principio)&:(< ?principio ?final))
	=>
	(printout t "primer numero "?principio " segundo numero "?final crlf)
)

