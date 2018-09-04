(deftemplate producto
	(slot nombre)
	(slot pvp)
)

(deftemplate compra
	(slot producto)
	(slot unidades (type INTEGER))
)
(deffacts datos
	(total 0)
	(compra (producto leche) (unidades 4))
	(producto (nombre leche) (pvp 2))
	(compra (producto zumo) (unidades 2))
	(producto (nombre zumo) (pvp 8.7))
	(compra (producto huevos) (unidades 34))
	(producto (nombre huevos) (pvp 6.8))
	(compra (producto tomate) (unidades 5))
	(producto (nombre tomate) (pvp 1.7))
	(compra (producto vino) (unidades 7))
	(producto (nombre vino) (pvp
	(compra (producto jamon) (unidades 9))
	(producto (nombre jamon) (pvp 7)) 4.2))
)
(defrule calcularCompra3x2
	?c<-(compra (producto ?nombre) (unidades ?x))	
	?p<-(producto (nombre ?nombre) (pvp ?y))
	?h1<-(total ?z)
	=>
	(retract ?h1 ?c ?p)
	(assert (total =(+ ?z (* ?y (- ?x (/ (- ?x (mod ?x 3)) 3))))))
)