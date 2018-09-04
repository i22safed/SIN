;Ejercicio 25 8 Reinas en profundidad con retroceso

;Plantilla que define la estructura de cada nodo
(deftemplate reina
	(slot id) 		;identificar cada uno de los nodos
	(slot pid) 		;identificar el padre de cada nodo
	(slot fila) 		;fila que ocupa 
	(slot col)		;columna que ocupa
	(slot depth) 		;profundidad del nodo
	(multislot ancestros))	;id de todos los ancestros

(deffacts hechosIniciales
	(nextId 1)
	(reina (id 0) (depth 0) (fila nil) (col nil) (ancestros 0))
	(front 0)
	(pos 1) (pos 2) (pos 3) (pos 4) (pos 5) (pos 6) (pos 7) (pos 8))

;Busca fila y columna que no ataque a la reina padre
;para generar nuevos ids en la BH tendremos (nextId 1)
(defrule generaReina
	(not (reina(depth 8)))
	?h1 <- (front ?x $?resto)
	?h2 <- (nextId ?newId)
	(reina (id ?x) (depth ?profPadre) (ancestros $?ancestros))
	(pos ?f); son los mismos (fila ?f)
	(pos ?c); sin los mismos (col ?c)
	;No atacar a los ancestros de id
	(not (and (reina (id ?x) (ancestros $? ?ant $?)) 
			(reina (id ?ant) (fila ?f))));no puede exisitr un ancestro de la reina padre tal que la fila no sea la misma
	(not (and (reina (id ?x) (ancestros $? ?ant $?)) 
			(reina (id ?ant) (col ?c))));no puede exisitr un ancestro de la reina padre tal que la columna no sea la misma
	
	;faltan las dos diagonales
	(not (and (reina (id ?x) (ancestros $? ?ant $?)) 
			(reina (id ?ant&~0) (fila ?f2)(col ?c2&:(= (+ ?f ?c)(+ ?f2 ?c2))))));no puede exisitr un ancestro de la reina padre 											     tal que la columna no sea la misma
	(not (and (reina (id ?x) (ancestros $? ?ant $?)) 
			(reina (id ?ant&~0) (fila ?f2)(col ?c2&:(= (- ?f ?c)(- ?f2 ?c2))))))
	;No repetir nodos
	(not (reina (pid ?x) (fila ?f) (col ?c)))
	=>
	(retract ?h1 ?h2)
	(assert (reina (id ?newId) (fila ?f) (col ?c) (pid ?x) (depth (+ ?profPadre 1))(ancestros ?newId $?ancestros)))
	(assert (front ?newId ?x $?resto))
	(assert (nextId ( + ?newId 1))))
	
(defrule eliminaDeFrontera
	?h1 <- (front ?x $?resto)
	;Detectar que no se puede generar hijos
	;cuando todas las posiciones están atacas por los ancestros
	(reina (id ?x)) ;para saber que generamos hijos desde c
	(forall  (and (pos ?f) (pos ?c))
			(or
				;Ancestro por fila
				(and (reina (id ?x) (ancestros $? ?ant $?))
					(reina (id ?ant)(fila ?f)))
				;Ancestro por columna
				(and (reina (id ?x) (ancestros $? ?ant $?))
					(reina (id ?ant) (col ?c)))
				;Ancestro por diagonal crecientes
				(and (reina (id ?x) (ancestros $? ?ant $?)) 
					(reina (id ?ant&~0) (fila ?f2)(col ?c2&:(= (+ ?f ?c)(+ ?f2 ?c2)))))
				
				;Ancestros por diagonal decrecientes
				(and (reina (id ?x) 
					(ancestros $? ?ant $?)) 
					(reina (id ?ant&~0) (fila ?f2)(col ?c2&:(= (- ?f ?c)(- ?f2 ?c2)))))
			
			(reina (pid ?x) (fila ?f)(col ?c))	
		)
	)

	=> 
	(retract ?h1)
	(assert (front $?resto)))