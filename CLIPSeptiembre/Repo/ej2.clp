;2.- Haz un programa que dado un conjunto de hechos de tipo datos
;    con un número indefinido de valores, detecte e imprima
;    aquellos tal que el primer valor sea par y menor o igual
;    al último.

(deffacts hechos 
	(conjunto 1 2 4 6 1 3 5 6)
	(conjunto 7 3 2 44 2 5 6 10)
	(conjunto 8 1 5 7 2 6 2 6)
	(conjunto 2 34 23 1)
	(conjunto 2 34 23 3))

(defrule menor-mayor

	?h<-(conjunto ?x&:(numberp ?x)&:(evenp ?x) $?medio ?ultimo&:(<= ?x ?ultimo)) ;Como nombre se debe de poner el mismo en todos los hechos 
    =>
	(printout t ?h " Primero -> " ?x " Ultimo -> " ?ultimo crlf)
)
