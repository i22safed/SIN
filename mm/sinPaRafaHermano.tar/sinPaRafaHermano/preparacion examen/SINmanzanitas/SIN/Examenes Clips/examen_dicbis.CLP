(deftemplate paquete
	(slot id)
	(multislot contenido)
	(slot comp_errores)
	(multislot auxiliar)
	(slot estado_comprobacion)
)

(deffacts hechos
	(paquete (id 1) (contenido a b ab 3 arroz a 23 n) (comp_errores
aba) (auxiliar) (estado_comprobacion sin_comprobar))
	(paquete (id 2) (contenido n a a b arroz 23) (comp_errores baa)
(auxiliar ) (estado_comprobacion sin_comprobar)))

;ejercicio2
(defrule comprueba2
	?h<-(paquete (contenido $?x) (auxiliar) (estado_comprobacion sin_comprobar))
	=>
	(modify ?h (auxiliar $?x) (estado_comprobacion iniciado))
)
;ejercicio 3 4
(defrule comprueba3
	?h<-(paquete (id ?id) (auxiliar $?del ?aux&~a&~b $?det) (estado_comprobacion iniciado))
	=>
	(modify ?h (auxiliar $?del $?det))
)

(defrule comprueba51
	?h<-(paquete (id ?id)  (estado_comprobacion iniciado))
	(not (paquete (id ?id) (auxiliar $?del ?aux&~a&~b $?det)))
	=>
	(modify ?h (estado_comprobacion concatenado))
)
(defrule concatenar
	?h<-(paquete (auxiliar ?del ?aux $?det) (estado_comprobacion concatenado))
	=>
	(modify ?h (auxiliar(sym-cat ?del ?aux) $?det))
)
(defrule comprobar
	?h<-(paquete (comp_errores ?e) (auxiliar ?aux&:(eq ?aux ?e)) (estado_comprobacion concatenado))
	=>
	(modify ?h (estado_comprobacion correcto) (auxiliar))
)