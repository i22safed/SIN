;*****************************************
; Autores:
; - Salido Álvarez, Rafael
; - Sánchez Fernández, David
; Historial de cambios:
;  - Fecha: mejoras/cambios
;  - Cosas que faltan por implementar:
;     + Detección de los peligros (agujeros de gusano y monstruos)
;     + Disparar el laser
;     + Comprobar que el movimiento aleatorio no lo hace hacia una casilla con peligro
;     + Quitar todos los if que haya en el código (Opcional pero hay quita nota)
;*****************************************


;********Plantilla Casilla****************************************************
;Tipo: plantilla
;Función: Guardar información de las casillas que Willy va visitando

(deftemplate casilla
  (slot posicion-x (type INTEGER) (default ?NONE)) ;Coordenada x de la casilla
  (slot posicion-y (type INTEGER) (default ?NONE)) ;Coordenada y de la casilla
  (slot visitada (type INTEGER)(allowed-values 0 1) (default 0)) ;Indicamos que la casilla ha sido visitada
  (slot monstruo (type INTEGER)(allowed-values 0 1) (default 0)) ;Sonido de monstruo detectado en la casilla
  (slot agujero (type INTEGER)(allowed-values 0 1)(default 0)) ;Sonido del agujero de gusano detectado en la casilla
)
;*****************************************************************************


;********hechos***************************************************************
;Tipo: hechos
;Función: Almacenar varios hechos que necesitaremos a lo largo de la ejecución

(deffacts hechos
  (casilla (posicion-x 0)(posicion-y 0)(visitada 1)(agujero 0)) ;Hecho que usa la plantilla anteriormente creada para mantener un control de las casillas a las que nos movemos
  (ultimoMovimiento NULL) ;Indicación de cuál ha sido nuestro último movimiento para en caso de encontrar un agujero o mosntruo podamos volver hacia atrás
  (numeroMovimientos 0)
  (casilla-actual 0 0) ;Casilla en la que nos enontramos actualmente
)
;*****************************************************************************


;********Movimientos de Willy*************************************************
;Hemos creado 4 reglas con movimientos hacia los 4 puntos cardinales más una regla adicional que se dispara si Willy no puede moverse
;Las reglas tienen todas la misma prioridad, de manera que el movimiento (en caso de que se pueda realizar) es aleatorio entre los movimientos disponibles
;Cada regla comprueba que a la casilla que se va a mover no ha sido visitada previamente.
;Además comprueba que el movimiento es posible. (Si willy no tiene más casilla hacia ese lado no puede moverse)
;*****************************************************************************


;********moverNorte***************************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el norte

(defrule moverNorte
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction north) $?);Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección

  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (+ ?y 1) ?b)))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada

  ?id2 <- (ultimoMovimiento ?)

=>
  (moveWilly north);Movemos a Willy hacia el norte

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2)

  (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x ?x)(posicion-y (+ ?y 1))(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
)
;*****************************************************************************

;********moverSur*************************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el sur
(defrule moverSur
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction south) $?);Comprobamos si existe el sur, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección

  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?)


  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (- ?y 1) ?b)))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada

=>
  (moveWilly south);Movemos a Willy hacia el sur

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2)

  (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x ?x)(posicion-y (- ?y 1))(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
)
;*****************************************************************************


;********moverEste*************************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el este
(defrule moverEste
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction east) $?);Comprobamos si existe el oeste, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección

  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?)

  (not(exists(casilla(posicion-x ?b&:(= (+ ?x 1) ?b))(posicion-y ?y)(agujero 0))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada

=>
  (moveWilly east);Movemos a Willy hacia el este

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2)

  (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x (+ ?x 1))(posicion-y ?y)(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
)
;*****************************************************************************


;********moverOeste***********************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el oeste
(defrule moverOeste
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction west) $?);Comprobamos si existe el oeste, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección

  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?)

  (not(exists(casilla(posicion-x ?b&:(= (- ?x 1) ?b))(posicion-y ?y))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada

=>
  (moveWilly west);Movemos a Willy hacia el oeste

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2)

  (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual (- ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x (- ?x 1))(posicion-y ?y)(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
)
;*****************************************************************************


;********willyBloqueado***********************************************************
;Tipo:esta regla hace que Willy se mueva hacia una posición posible de forma totalmente aleatoria
;debido a que las posiciones colindates de donde se encuentra ya han sido visitadas
(defrule willyBloqueado
  (directions $? ?direction $?);Consultamos las direcciones disponibles y nos quedamos con una de ellas

  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

=>

  (moveWilly ?direction);Movemos a Willy hacia dicha dirección
  (assert (ultimoMovimiento ?direction))
  (retract ?id1);Retractamos la posición donde estaba willy

;Dependiendo a que posición se haya movido Willy se actualiza la casilla
    (if (eq ?direction north)
      then (assert (casilla-actual ?x (+ ?y 1))))
    (if (eq ?direction south)
        then (assert (casilla-actual ?x (- ?y 1))))
    (if (eq ?direction east)
      then (assert (casilla-actual (+ ?x 1) ?y)))
    (if (eq ?direction west)
      then (assert (casilla-actual (- ?x 1) ?y)))

  )
;*****************************************************************************

(defrule peligroagujeronegro
  (declare (salience 60));
  (percepts Pull)

  ?id1 <- (ultimoMovimiento ?direccionMovimiento)
  ?id2 <- (casilla-actual ?x ?y);

=>
      (retract ?id1)
      (retract ?id2)

      (if (eq ?direccionMovimiento north)
      then (assert (ultimoMovimiento south)))
      (if (eq ?direccionMovimiento south)
        then (assert (ultimoMovimiento north)))
      (if (eq ?direccionMovimiento east)
        then (assert (ultimoMovimiento west)))
      (if (eq ?direccionMovimiento west)
        then (assert (ultimoMovimiento east)))

      (if (eq ?direccionMovimiento north)
     		then (assert (casilla-actual ?x (- ?y 1))))
    	(if (eq ?direccionMovimiento south)
     		then (assert (casilla-actual ?x (+ ?y 1))))
     	(if (eq ?direccionMovimiento east)
     		then (assert (casilla-actual (- ?x 1) ?y)))
     	(if (eq ?direccionMovimiento west)
     		then (assert (casilla-actual (+ ?x 1) ?y)))

      (if (eq ?direccionMovimiento north)
        then (moveWilly south))
      (if (eq ?direccionMovimiento south)
        then (moveWilly north))
      (if (eq ?direccionMovimiento east)
        then (moveWilly west))
      (if (eq ?direccionMovimiento west)
        then (moveWilly east))

  )
