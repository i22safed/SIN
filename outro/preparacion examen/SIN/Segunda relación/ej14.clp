(deffacts datos
	(factorial 5)
)
(defrule factorial-1
	(factorial ?x) ;Función que coge el dato introducido y lo pone en el formato para trabajar
	=>
	(assert (auxfactorial ?x 1 1))
)

(defrule factorial
	?h1<-(auxfactorial ?x ?y&:(<= ?y ?x) ?z) ;hace el factorial
	=>
	(retract ?h1)
	(assert (auxfactorial ?x (+ ?y 1) (* ?z ?y)))
)
(defrule mostrar
	?h1<-(auxfactorial ?x =(+ ?x 1) ?y)
	?h2<-(factorial ?x)
	=>
	(retract ?h1 ?h2)
	(printout t "El factorial de " ?x " es " ?y crlf)
)