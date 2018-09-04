(deffacts datos "Vectores a comprobar"
	(datos 1 piso 3 casa)
	(datos hua hue hui huo)
	(datos 1 2 3 4)
)

(defrule eliminaNoNumero "Eliminamos los campos no numéricos de un vector de cualquier longitud"
	?d <- (datos $?cabeza ?x&:(not(numberp ?x)) $?cola)
	=>
	(retract ?d)
	(assert (datos $?cabeza $?cola))
)