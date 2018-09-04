(deftemplate auxfact
	(slot pedido)
	(slot acc (default 1))
	(slot contador)
)

(defrule empezar
	(factorial ?x)
	(not (auxfact (pedido ?x)))
	=>
	(assert (auxfact ?x))
)

(defrule avanzar
	?h1<-(auxfact 
		(pedido ?x)
		(acc ?y)
		(contador ?c&:(< ?c ?x)))
	=>
	(retract ?h1)
	(assert (auxfact 
			(pedido ?x)
			(acc (*?y(+ ?c 1)))
			(contador (+ ?c 1)))
)
(defrule mostrar
	?h1<-(auxfactorial ?x =(+ ?x 1) ?y)
	?h2<-(factorial ?x)
	=>
	(retract ?h1 ?h2)
	(printout t "El factorial de " ?x " es " ?y crlf)
)