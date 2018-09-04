(deftemplate paquete
	(slot id)
	(multislot contenido)
	(multislot auxiliar)
	(slot comp_errores)
	(slot estado_comprobacion (default sin_comprobar))
	)

(deffacts hechos
	(paquete (id 1) (contenido a a hola b adios) (comp_errores aab) (auxiliar )(estado_comprobacion sin_comprobar))
	(paquete (id 2) (contenido n a a b arroz 23) (comp_errores aab) (auxiliar )(estado_comprobacion sin_comprobar))
	)
	
(defrule regla2
	?h1<-(paquete (id ?i) (contenido $?c) (auxiliar) (comp_errores ?comp) (estado_comprobacion ?e&:(eq ?e sin_comprobar)))
	=>
	(retract ?h1)
	(assert (paquete (id ?i) (contenido $?c) (auxiliar $?c) (comp_errores ?comp) (estado_comprobacion iniciado)))
	)
	
(defrule regla3
	?h1<-(paquete (id ?i) (contenido $?co) (auxiliar $?ant ?x&:(and (neq ?x a) (neq ?x b)) $?post) (comp_errores ?comp) (estado_comprobacion ?e&:(eq ?e iniciado)))
	=>
	(retract ?h1)
	(assert (paquete (id ?i) (contenido $?co) (auxiliar $?ant $?post) (comp_errores ?comp) (estado_comprobacion iniciado)))
	)
	 
(defrule reglaa 
	?h1<-(paquete (id ?i) (contenido $?co) (auxiliar $?aux) (comp_errores ?comp) (estado_comprobacion iniciado))
	(not (exists (paquete (id ?i) (contenido $?co) (auxiliar $? ?x&:(and (neq ?x a) (neq ?x b)) $?) (comp_errores ?comp) (estado_comprobacion iniciado))))
	=>
	(retract ?h1)
	(assert (paquete (id ?i) (contenido $?co) (auxiliar $?aux) (comp_errores ?comp) (estado_comprobacion concatenando)))
	)
	
(defrule reglab
	?h1<-(paquete (id ?i) (contenido $?co) (auxiliar ?x ?y $?post) (comp_errores ?comp) (estado_comprobacion concatenando))
	=>
	(retract ?h1)
	(assert (paquete (id ?i) (contenido $?co) (auxiliar (sym-cat ?x ?y) $?post) (comp_errores ?comp) (estado_comprobacion concatenando)))
	)
	
(defrule reglac
	?h1<-(paquete (id ?i) (contenido $?co) (auxiliar ?aux) (comp_errores ?comp&:(eq ?comp ?aux)) (estado_comprobacion concatenando))
	=>
	(retract ?h1)
	(assert (paquete (id ?i) (contenido $?co) (auxiliar ) (comp_errores ?comp) (estado_comprobacion correcto)))
)
