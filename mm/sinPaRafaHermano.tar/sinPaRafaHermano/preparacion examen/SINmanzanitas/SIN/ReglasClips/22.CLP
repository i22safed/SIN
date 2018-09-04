;Ejercicio 22

;regla que compruebe que el primero y el ultimo son iguales y los elimina 
(defrule veEliminando
	?dhd<-(datos ?h1 $?a ?h1)
	=>
	(retract ?dhd)
	(assert (datos $?a)))


;regla que detecta que no es simetrico 
(defrule nosimetrico
	(datos ?x $? ?y)
	(test(neq ?x ?y))
	=>
	(printout t "No es simetrico"crlf)
)


;regla que imprime simetrico si solo queda un elemento (normalmente funciona bien con reglas diferentes)
(defrule simetrico1 
	(or(datos ?)
	    (datos))
	=>
	(printout t "Es simetrico"crlf)
) 

(deffacts hechos
	(datos 1 2 3 3 2 1)
	(datos 1 2 3 4 5 1)
)

