;*****************************************
; Autores:
; - Salido Álvarez, Rafael
; - Sánchez Fernández, David
; Historial de cambios:
;  - Fecha: mejoras/cambios
;*****************************************


;********Hecho1***************************
;Tipo: hechos
;Función: Guardar todos los movimientos que va a realizar Willy por el espacio

(deftemplate casilla
  (slot posicion-x (type INTEGER) (default ?NONE))
  (slot posicion-y (type INTEGER) (default ?NONE))
  (slot visitada (type INTEGER)(allowed-values 0 1) (default 0))
  (slot monstruo (type INTEGER)(allowed-values 0 1) (default 0))
  (slot agujero (type INTEGER)(allowed-values 0 1) (default 0))
)

(deffacts hechos
  (casilla (posicion-x 0)(posicion-y 0)(visitada 1))
  (ultimoMovimiento NULL)
  (numeroMovimientos 0)
  (casilla-actual 0 0)
)

(defrule moverNorte
  (declare (salience 10));Prioridad

  ;Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy se mueva hacia dicha posición
  (directions $? ?direction&:(eq ?direction north) $?)

  ?id1 <- (casilla-actual ?x ?y)


  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (+ ?y 1) ?b)))));comprobamos que la casilla a la que vamos a movernos no ha sido visitada.



=>
  (moveWilly north)
  (retract ?id1)
  (assert (ultimoMovimiento north))
  (assert (casilla-actual ?x (+ ?y 1)))
  (assert (casilla(posicion-x ?x)(posicion-y (+ ?y 1))(visitada 1)))
)


(defrule moverSur
  (declare (salience 10));Prioridad

  ;Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy se mueva hacia dicha posición
  (directions $? ?direction&:(eq ?direction south) $?)

  ?id1 <- (casilla-actual ?x ?y)


  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (- ?y 1) ?b)))));comprobamos que la casilla a la que vamos a movernos no ha sido visitada.



=>
  (moveWilly south)
  (retract ?id1)
  (assert (ultimoMovimiento south))
  (assert (casilla-actual ?x (- ?y 1)))
  (assert (casilla(posicion-x ?x)(posicion-y (- ?y 1))(visitada 1)))
)

(defrule moverEste
  (declare (salience 10));Prioridad

  ;Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy se mueva hacia dicha posición
  (directions $? ?direction&:(eq ?direction east) $?)

  ?id1 <- (casilla-actual ?x ?y)


  (not(exists(casilla(posicion-x ?b&:(= (+ ?x 1) ?b))(posicion-y ?y))));comprobamos que la casilla a la que vamos a movernos no ha sido visitada.



=>
  (moveWilly east)
  (retract ?id1)
  (assert (ultimoMovimiento east))
  (assert (casilla-actual (+ ?x 1) ?y))
  (assert (casilla(posicion-x (+ ?x 1))(posicion-y ?y)(visitada 1)))
)

(defrule moverOeste
  (declare (salience 10));Prioridad

  ;Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy se mueva hacia dicha posición
  (directions $? ?direction&:(eq ?direction west) $?)

  ?id1 <- (casilla-actual ?x ?y)


  (not(exists(casilla(posicion-x ?b&:(= (- ?x 1) ?b))(posicion-y ?y))));comprobamos que la casilla a la que vamos a movernos no ha sido visitada.



=>
  (moveWilly west)
  (retract ?id1)
  (assert (ultimoMovimiento west))
  (assert (casilla-actual (- ?x 1) ?y))
  (assert (casilla(posicion-x (- ?x 1))(posicion-y ?y)(visitada 1)))
)
