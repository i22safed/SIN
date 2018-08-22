;
;5.- Haz un programa que dado un único hecho datos con un número
;    indefinido de valores, elimine los que no sean numéricos.
;

(deffacts hecho

	(valores turbo 5 "caca" hueso 4 5 verde)

)


(defrule regla 

	?h<-(valores $?cabeza ?medio&~:(numberp ?medio) $?cola)
	
=>
	
	(retract ?h)
	(assert(valores $?cabeza ?cola))

)