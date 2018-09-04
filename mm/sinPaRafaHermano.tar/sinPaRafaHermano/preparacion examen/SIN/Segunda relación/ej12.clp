(deffacts datos "Datos a comprobar"
	(dato 1)
	(dato 8)
	(dato 3) 
)

(defrule ordenaDatos "Imprimimos los datos antes declarados de menor a mayor"
?d<-(dato ?x) (not(dato ?y&:(> ?x ?y)))
=>
(printout t ?x crlf)
(retract ?d)
)