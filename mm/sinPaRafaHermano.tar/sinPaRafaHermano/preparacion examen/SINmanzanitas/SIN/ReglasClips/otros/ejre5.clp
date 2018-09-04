(deffacts datos-a-analizar
	(datos 1 holis 4 pene 7 1 8 3)
)

(defrule eliminaUno
	?hecho<-(datos ?x&:(numberp ?x) $?cabeza $?cola)
	(test (= 1 ?x))
	=>
	(retract ?hecho)
	(assert (datos $?cabeza $?cola)))