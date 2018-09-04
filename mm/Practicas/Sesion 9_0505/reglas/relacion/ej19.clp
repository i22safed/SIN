(deffacts vector "Datos a comprobar"
	(datos 1 7 9 7 5 4 8 5)
)

(defrule imprimeValorEnmedioImpar "Imprime dato de en medio en vector con un n de elementos impar"
	?d<-(datos $?cabeza ?x $?cola&:(eq (length $?cabeza) (length $?cola)))
	=>
	(printout t ?x crlf)
)

(defrule imprimeValorEnmedioPar "Imprime dato de en medio en un vector con un n de elementos par"
	?d<-(datos $?cabeza ?x ?y $?cola&:(eq (length $?cabeza) (length $?cola)))
	=>
	(printout t (/(+ ?x ?y)2) crlf)
)
