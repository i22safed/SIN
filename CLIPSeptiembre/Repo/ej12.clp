

;
; 12.- Haz un programa que calcule el factorial de un número,
;      de manera que ante un hecho (factorial 3), muestre por
;      pantalla el mensaje “El factorial de 3 es 6”.
;

(deffacts hechos
	(fact 1 1)
	(limite 6)
	(mostrar 5)
)

(defrule factorial
	(limite ?l)
	?f <-(fact ?x&:(< ?x ?l) ?y)
	?m <-(mostrar ?mos)
	=>
	(retract ?f ?m)
	(assert (fact (+ ?x 1) (* ?y (+ ?x 1))))
	(assert(mostrar (- ?mos 1)))
)

(defrule mostrar-factorial
	(mostrar ?x&:(eq ?x 0))
	(fact ?y ?z)
	=> 
	(printout t clrf "El factorial de " ?y " es: " ?z crlf)

)
