;*****************************************
; Autores:
; - Salido Álvarez, Rafael
; - Sánchez Fernández, David
; Historial de cambios:
;  - Fecha: mejoras/cambios
;  - Cosas que faltan por implementar:
;     + Disparar el laser
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

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------




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
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (+ ?y 1) ?b)))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada

  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento


  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos


=>
  (moveWilly north);Movemos a Willy hacia el norte
  (retract ?id);Retractamos el hecho del número de movimientos
  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x ?x)(posicion-y (+ ?y 1))(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
  (assert (numeroMovimientos (+ ?m 1)))
)
;*****************************************************************************

;********moverSur*************************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el sur
(defrule moverSur
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction south) $?);Comprobamos si existe el sur, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento


  (not(exists(casilla(posicion-x ?x)(posicion-y ?b&:(= (- ?y 1) ?b)))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly south);Movemos a Willy hacia el sur
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x ?x)(posicion-y (- ?y 1))(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
  (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********moverEste*************************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el este
(defrule moverEste
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction east) $?);Comprobamos si existe el oeste, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento

  (not(exists(casilla(posicion-x ?b&:(= (+ ?x 1) ?b))(posicion-y ?y)(agujero 0))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly east);Movemos a Willy hacia el este
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x (+ ?x 1))(posicion-y ?y)(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
  (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********moverOeste***********************************************************
;Tipo:regla que hace que Willy se mueva hacia la proxima casilla hacia el oeste
(defrule moverOeste
  (declare (salience 10));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction west) $?);Comprobamos si existe el oeste, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento

  (not(exists(casilla(posicion-x ?b&:(= (- ?x 1) ?b))(posicion-y ?y))));Comprobamos que la casilla a la que vamos a movernos no ha sido visitada
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly west);Movemos a Willy hacia el oeste
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual (- ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy

  (assert (casilla(posicion-x (- ?x 1))(posicion-y ?y)(visitada 1)(agujero 0)));Guardamos la casilla nueva que acabamos de visitar
  (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********willyBloqueadoNorte***********************************************************
;Tipo:regla que realiza un movimiento aleatorio hacia el norte
(defrule willyBloqueadoNorte
  (declare (salience 5));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction north) $?);Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly north);Movemos a Willy hacia el norte
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
  (assert (numeroMovimientos (+ ?m 1)))


  )
;*****************************************************************************


;********willyBloqueadoSur****************************************************
;Tipo:regla que realiza un movimiento aleatorio hacia el sur
(defrule willyBloqueadoSur
  (declare (salience 5));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction south) $?);Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly south);Movemos a Willy hacia el norte
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy

  (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
  (assert (numeroMovimientos (+ ?m 1)))


)
;*****************************************************************************


;********willyBloqueadoEste***************************************************
;Tipo:regla que realiza un movimiento aleatorio hacia el este
(defrule willyBloqueadoEste
  (declare (salience 5));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction east) $?);Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly east);Movemos a Willy hacia el norte
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy

(assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
(assert (numeroMovimientos (+ ?m 1)))


)
;*****************************************************************************


;********willyBloqueadoOeste**************************************************
;Tipo:regla que realiza un movimiento aleatorio hacia el oeste
(defrule willyBloqueadoOeste
  (declare (salience 5));Prioridad (Las 4 reglas de movimiento tienen la misma)

  (directions $? ?direction&:(eq ?direction west) $?);Comprobamos si existe el norte, para que en caso de que sea afirmativa Willy pueda moverse hacia dicha dirección
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra

  ?id2 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
  (moveWilly west);Movemos a Willy hacia el norte
  (retract ?id);Retractamos el hecho del número de movimientos

  (retract ?id1);Retractamos la posición donde estaba willy
  (retract ?id2);Retractamos el hecho del último movimiendo

  (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy

(assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
(assert (numeroMovimientos (+ ?m 1)))


)

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------

;********Escucha de peligros de Willy*****************************************
;Hemos creado 4 reglas por cada peligro que puede escuchar Willy (agujero de gusano, monstruo y los dos a la vez)
;Cada vez que llega a una casilla y escucha un peligro cercano, Willy vuelve inmediatamente a la casilla de la que venía.
;*****************************************************************************


;********peligroAgujeroNegroNorte*********************************************
;Tipo:Willy detecta un agujero negro y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroNorte
  (declare (salience 60));
  (percepts Pull);Comprobamos si hay ruido cercano de un agujero de gusano
  (ultimoMovimiento north);Comprobamos que el último moviento realizado proviene del norte
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);;Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly south);Movemos a Willy hacia el sur
      (assert (numeroMovimientos (+ ?m 1)))

  )
;*****************************************************************************


;********peligroAgujeroNegroSur***********************************************
;Tipo:Willy detecta un agujero negro y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroSur
  (declare (salience 60));
  (percepts Pull);Comprobamos si hay ruido cercano de un agujero de gusano
  (ultimoMovimiento south);Comprobamos que el último moviento realizado proviene del sur
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos
      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
     	(moveWilly north);Movemos a Willy hacia el norte
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********peligroAgujeroNegroEste**********************************************
;Tipo:Willy detecta un agujero negro y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroEste
  (declare (salience 60));
  (percepts Pull);Comprobamos si hay ruido cercano de un agujero de gusano
  (ultimoMovimiento east);Comprobamos que el último moviento realizado proviene del este
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (- ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly west);Movemos a Willy hacia el oeste
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************

;********peligroAgujeroNegroOeste*********************************************
;Tipo:Willy detecta un agujero negro y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroOeste
  (declare (salience 60));
  (percepts Pull);Comprobamos si hay ruido cercano de un agujero de gusano
  (ultimoMovimiento west);Comprobamos que el último moviento realizado proviene del oeste
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly east);Movemos a Willy hacia el este
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------

;********peligroMonstruoNorte*************************************************
;Tipo:Willy detecta un monstruo cercano y se mueve a la casilla anterior.
(defrule peligroMonstruoNorte
  (declare (salience 60));
  (percepts Noise);Comprobamos si hay ruido cercano de un monstruo
  (ultimoMovimiento north);Comprobamos que el último movimiento proviene del norte
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly south);Movemos a Willy hacia el sur
      (assert (numeroMovimientos (+ ?m 1)))

  )
;*****************************************************************************


;********peligroMonstruoSur***************************************************
;Tipo:Willy detecta un monstruo cercano y se mueve a la casilla anterior.
(defrule peligroMonstruoSur
  (declare (salience 60));
  (percepts Noise);Comprobamos si hay ruido cercano de un monstruo
  (ultimoMovimiento south);Comprobamos que el último movimiento proviene del sur
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
     	(moveWilly north);Movemos a Willy hacia el norte
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********peligroMonstruoEste**************************************************
;Tipo:Willy detecta un monstruo cercano y se mueve a la casilla anterior.
(defrule peligroMonstruoEste
  (declare (salience 60));
  (percepts Noise);Comprobamos si hay ruido cercano de un monstruo
  (ultimoMovimiento east);Comprobamos que el último movimiento proviene del este
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (- ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly west);Movemos a Willy hacia el oeste
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********peligroMonstruoOeste*************************************************
;Tipo:Willy detecta un monstruo cercano y se mueve a la casilla anterior.
(defrule peligroMonstruoOeste
  (declare (salience 60));
  (percepts Noise);Comprobamos si hay ruido cercano de un monstruo
  (ultimoMovimiento west);Comprobamos que el último movimiento proviene del oeste
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly east);Movemos a Willy hacia el este
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------


;********peligroAgujeroNegroyMonstruoNorte************************************
;Tipo:Willy detecta un monstruo cercano y un agujero de gusano y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroyMonstruoNorte
  (declare (salience 62));
  (percepts Pull Noise);Comprobamos si hay ruido cercano de un monstruo y un agujero de gusano
  (ultimoMovimiento north);Comprobamos que el último movimiento proviene del norte
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento south));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (- ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly south);Movemos a Willy hacia el sur
      (assert (numeroMovimientos (+ ?m 1)))

  )
;*****************************************************************************


;********peligroAgujeroNegroyMonstruoSur**************************************
;Tipo:Willy detecta un monstruo cercano y un agujero de gusano y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroyMonstruoSur
  (declare (salience 62));
  (percepts Pull Noise);Comprobamos si hay ruido cercano de un monstruo y un agujero de gusano
  (ultimoMovimiento south);Comprobamos que el último movimiento proviene del sur
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy

      (assert (ultimoMovimiento north));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual ?x (+ ?y 1)));Actualizamos hacia la casilla que se ha movido Willy
     	(moveWilly north);Movemos a Willy hacia el norte
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********peligroAgujeroNegroyMonstruoEste*************************************
;Tipo:Willy detecta un monstruo cercano y un agujero de gusano y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroyMonstruoEste
  (declare (salience 62));
  (percepts Pull Noise);Comprobamos si hay ruido cercano de un monstruo y un agujero de gusano
  (ultimoMovimiento east);Comprobamos que el último movimiento proviene del este
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento west));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (- ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly west);Movemos a Willy hacia el oeste
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************


;********peligroAgujeroNegroyMonstruoOeste************************************
;Tipo:Willy detecta un monstruo cercano y un agujero de gusano y se mueve a la casilla anterior.
(defrule peligroAgujeroNegroyMonstruoOeste
  (declare (salience 62));
  (percepts Pull Noise);Comprobamos si hay ruido cercano de un monstruo y un agujero de gusano
  (ultimoMovimiento west);Comprobamos que el último movimiento proviene del oeste
  ?id <- (numeroMovimientos ?m)
  ?id1 <- (ultimoMovimiento ?);Recogemos el hecho donde se almacena la dirección del último movimiento
  ?id2 <- (casilla-actual ?x ?y);Recogemos la posición en la que Willy se encuentra
  (test (< ?m 999));Comprobamos que no se ha superado el limite de movimientos

=>
      (retract ?id);Retractamos el hecho del número de movimientos

      (retract ?id1);Retractamos el hecho del último movimiendo
      (retract ?id2);Retractamos la posición donde estaba willy
      (assert (ultimoMovimiento east));Guardamos hacia donde se ha movido Willy
      (assert (casilla-actual (+ ?x 1) ?y));Actualizamos hacia la casilla que se ha movido Willy
      (moveWilly east);Movemos a Willy hacia el este
      (assert (numeroMovimientos (+ ?m 1)))

)
;*****************************************************************************

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
