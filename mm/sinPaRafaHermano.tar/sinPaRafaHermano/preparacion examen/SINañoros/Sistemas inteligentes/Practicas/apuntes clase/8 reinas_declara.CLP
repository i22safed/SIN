
(deftemplate reina
	(slot id)  ;Id de la reina
	(slot fila) ;Filas
	(slot ds);Diagonal suma 
	(slot col);columnas
	(slot dr) ;Diagonal resta
	(slot pid)
	(slot depth)
	(multislot ancestros)
)

(deffacts hechos
	(fila 1) (fila 2) (fila 3) (fila 4)
	(fila 5) (fila 6) (fila 7) (fila 8) 
	(col 1) (col 2) (col 3) (col 4)
	(col 5) (col 6) (col 7) (col 8) 
	(nextId 1) (frontera 0)
	(reina (id 0) (depth 0)(ancestros 0))
)

(defrule posicionNuevaReina
	?h1<-(frontera ?id $?resto)
	(reina (id ?id) (ancestros $?ancesPadre) (depth ?depthPadre))
	(fila ?f) (col ?c)
	?h2<- (nextId ?newId)
	(not (and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (fila ?f))))
	(not (and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (col ?c))))
	(not (and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (ds =(+ ?f ?c)))))
	(not (and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (dr =(- ?f ?c)))))
	=>
	(retract ?h1)
	(retract ?h2)
	(assert (frontera ?newId ?id $?resto) (nextId (+ ?newId 1)))
	(assert (reina (id ?newId) (fila ?f)
		(col ?c) (ds (+ ?f ?c))
		(dr (- ?f ?c)) (pid ?id)
		(depth (+ ?depthPadre 1)) (ancestros ?newId $?ancesPadre))))


(defrule eliminarDeFrontera
	?h1<-(frontera ?x $?resto)
	;No se pueden generar hijos de ?x (para toda fila y columna hay una reina que ataca)
	
	(forall (and (fila ?f) (col ?c)) ;Toda fila y columna esta atacada
		(or 
		(and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (fila ?f)))  ;Por una reina ancestro en la misma fila
		(and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (col ?c))) ;Por una reina ancestro en la misma columna
		(and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (ds =(+ ?f ?c)))) ;Por una reina ancestro en la misma diagonal suma
		(and (reina (id ?id) (ancestros $? ?anc  $?)) (reina (id ?anc) (dr =(- ?f ?c)))))) ;Por una reina ancestro en la misma diagonal resta
	=>
	(retract ?h1)
	(assert (frontera $?resto)))
