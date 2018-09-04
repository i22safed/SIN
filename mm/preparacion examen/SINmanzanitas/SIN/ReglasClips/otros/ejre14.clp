(deffacts datos-a-analizar
	(dato 6)
	(factorial 1)
)
(defrule hazFactorial
	?datos<-(dato ?x&: (numberp ?x))
	?facto<-(factorial ?y&: (numberp ?y))
	(not(dato ?x&: (= ?x 1)))
	=>
	(retract ?datos)
	(assert (dato (- ?x 1)))
	(retract ?facto)
	(assert (factorial (* ?x ?y)))
)

(defrule imprimeFactorial
	(dato ?x&: (numberp ?x))
	(dato ?x&: (= ?x 1))
	(factorial ?y&: (numberp ?y))
	=>
	(printout t "El factorial del número introducido es: " ?y crlf))