(deffacts calcular
	(valor 4))

(deffacts ResultadoFactorial
	(resultado 1))

(defrule calcular-factorial

	?h1<-(valor ?v&:(> ?v 1))
	?h2<-(resultado ?r)
	=>
	(retract ?h1 ?h2)
	(assert (resultado (* ?v ?r) ))
	(assert (valor (- ?v 1)))
)

(defrule mostrar-resultado

	(valor ?v&:(= ?v 1))
	(resultado ?r)
	=>
	(printout t "El factorial es: " ?r crlf)
)