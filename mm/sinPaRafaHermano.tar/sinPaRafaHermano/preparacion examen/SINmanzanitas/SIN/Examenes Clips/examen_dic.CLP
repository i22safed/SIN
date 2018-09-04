(deftemplate paquete
	(slot id)
	(multislot contenido)
	(slot comp_errores)
	(multislot auxiliar)
	(slot estado_comprobacion (default "sin_comprobar"))
)

(deffacts hechos
	(paquete (id 1) (contenido a b ab 3 arroz a 23 n) (comp_errores
aba) (auxiliar) (estado_comprobacion sin_comprobar))
	(paquete (id 2) (contenido n a a b arroz 23) (comp_errores baa)
(auxiliar ) (estado_comprobacion sin_comprobar)))

;ejercicio2

(defrule modifciar
	?h1<-(paquete (id ?id)(contenido $?c)(comp_errores ?e)(auxiliar)(estado_comprobacion sin_comprobar))
	=>
	(modify ?h1 (auxiliar $?c)(estado_comprobacion iniciado))

)
;ejercicio 3
(defrule existe
	?h1<-(paquete (id ?id)(contenido $?c) (comp_errores ?e)(auxiliar $?del ?aux $?det)(estado_comprobacion iniciado))
	(and
		(test (neq ?aux a))
		(test (neq ?aux b)))
	=>
	(modify ?h1 (auxiliar $?del $?det))

)
(defrule conca1
	?h1<-(paquete (id ?id)(contenido $?c) (comp_errores ?e)(auxiliar $?del ?aux1&:(neq ?aux1 a)&:(neq ?aux1 b))(estado_comprobacion iniciado))
	=>
	(modify ?h1 (estado_comprobacion concatenado))
)
(defrule conca2
	?h1<-(paquete (id ?id) (contenido $?c) (comp_errores ?e) (auxiliar ?del ?aux $?det)(estado_comprobacion concatenado))
	=>
	(modify ?h1 (auxiliar(sym-cat ?del ?aux) $?det))
)

(defrule conca3
	?h1<-(paquete (id ?id) (contenido ?c) (comp_errores ?e) (auxiliar ?aux) (estado_comprobacion concatenado))
	(test (eq ?e ?aux))
	=>
	(modify ?h1 (estado_comprobacion correcto) (auxiliar))
)

