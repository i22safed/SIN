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

(deffacts Hecho1
  (ultimoMovimiento NULL) ;guardamos la direccón del último moviento que Willy ha realizado.
  (numeroMovimientos 0) ;guardamos el número de movimientos.
  (casilla 0 0) ;almacenamos una casilla ya visitada por Willy.
  (casilla-actual 0 0) ;almacenamos donde se ecuentra Willy actualmente.
  (Secuencia 0) ;almacenamos por donde va la ejecución del programa.
  (numeroBloqueos 0) ;guardamos los bloqueos en el movimiento
)
;*****************************************


;********puedeMoverseWilly****************
;Tipo: regla
;Función: estable un límite de movimiento para que Willy pueda moverse o no.
;Precondición: prioridad a 50 para la ejecución en el momento correcto.

(defrule puedeMoverseWilly
	(declare (salience 50))
	?id <- (Secuencia 0)
	(numeroMovimientos ?x)
	(test (< ?x 999))
=>
	(retract ?id)
	(assert (Secuencia 1))
)
;*****************************************


;********puedeMoverseWilly****************
;Tipo: regla
;Función: se escoge dirección al azar y se analiza para ver si es posible moverse en dicha dirección.
;Precondición: prioridad a 50 para la ejecución en el momento correcto.

(defrule EscogerDireccion
	?id <- (Secuencia 1)
	(numeroMovimientos ?x)
	(directions $? ?direction $?)
=>
	(retract ?id)
	(assert (Secuencia 2))
	(assert (proxMov ?direction))
)
;*****************************************


;********posiciónMovimiento***************
;Tipo: regla
;Función: metemos como hecho proxCasilla para comprobar cuál es la casilla a la que nos moveriamos.

(defrule posicionMovimiento
	?id <- (Secuencia 2)
	(proxMov ?proxDireccion)
	(casilla-actual ?i ?j)
=>
	(retract ?id)

	(if (eq ?proxDireccion north)
		then (assert (proxCasilla (+ ?i 1) ?j)))
	(if (eq ?proxDireccion south)
		then (assert (proxCasilla (- ?i 1) ?j)))
	(if (eq ?proxDireccion east)
		then (assert (proxCasilla ?i (+ ?j 1))))
	(if (eq ?proxDireccion west)
		then (assert (proxCasilla ?i (- ?j 1))))

	(assert (Secuencia 3))
)
;*****************************************

;********comprobarCasilla*****************
;Tipo: regla
;Función: comprobar si la casilla a la que nos vamos a mover ha sido visitada anteriormente.
;Información: Si se dispara la regla se produce un retroceso en la secuencia del programa.

(defrule comprobarCasilla
	?id <- (Secuencia 3)
	?id2 <- (proxCasilla ?i ?j)
	?id3 <- (proxMov ?)
	?id4 <- (numeroBloqueos ?valor)
	(casilla ?i ?j)
=>
	(retract ?id ?id2 ?id3 ?id4)
	(assert (numeroBloqueos (+ ?valor 1)))
	(assert (Secuencia 0))
)
;*****************************************

;********comprobarCasillaNoVisitada*******
;Tipo: regla
;Función: comprobar si la casilla a la que nos vamos a mover no ha sido visitada anteriormente. (ES LO CONTRARIO A LA REGLA ANTERIOR)
;Información: Si se dispara la regla se produce un retroceso en la secuencia del programa.

(defrule comprobarCasillaNoVisitada "En este caso NO esta visitada"
	?id <- (Secuencia 3)
	?id2 <- (proxCasilla ?i ?j)
	?id3 <- (numeroBloqueos ?valor)
	(not (casilla ?i ?j))
=>
	(retract ?id ?id2)
	(assert (numeroBloqueos 0))
	(assert (Secuencia 4))
)
;*****************************************

;********movimientoBloqueado**************
;Tipo: regla
;Función: esta regla comprueba si hay un bucle en las secuenias 0, 1 y 2. En caso de extir, rompe el bucle activando la secuencia especial.
;Información: Si se dispara la regla se produce un retroceso en la secuencia del programa.
;Postcondición: establecemos la prioridad a 51 para asegurar su ejecución.

(defrule movientoBloqueado
	(declare (salience 51))
	?id <- (numeroBloqueos ?valor)
	?id2 <- (Secuencia ?)
	(test (eq ?valor 15))
=>
	(retract ?id ?id2)
	(assert (numeroBloqueos 0))
	(assert (Secuencia Especial))
)
;*****************************************

;********movimientoAleatorio**************
;Tipo: regla
;Función: esta regla realiza un movimiento de Willy de forma aleatoria para que deje de estar bloqueado.
;Información: Si se activa esta regla la secuencia del programa sigue por 4.

(defrule movimientoAleatorio
	?id <- (Secuencia Especial)
	(directions $? ?direction $?)
=>
	(retract ?id)
	(assert (proxMov ?direction))
	(assert (Secuencia 4))
)
;*****************************************

;********moverWillyNorte**************
;Tipo: regla
;Función: esta regla mueve a Willy una casilla hacia el norte.

(defrule moverWillyNorte
	?id <- (numeroMovimientos ?x)
   	?id2 <- (proxMov ?direction)
   	?id3 <- (Secuencia 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMovimiento ?)
   	?id6 <- (numeroBloqueos ?)

   	(test (eq ?direction north))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (numeroBloqueos 0))
	(assert (numeroMovimientos (+ ?x 1)))
	(assert (ultimoMovimiento north))

	(assert (casilla (+ ?i 1) ?j))
	(assert (casilla-actual (+ ?i 1) ?j))

	(assert (Secuencia 0))
   	(moveWilly ?direction) ;;Llamada a la función que se nos da ya implementada
)
;*****************************************

;********moverWillySur********************
;Tipo: regla
;Función: esta regla mueve a Willy una casilla hacia el sur.

(defrule moverWillySur
	?id <- (numeroMovimientos ?x)
   	?id2 <- (proxMov ?direction)
   	?id3 <- (Secuencia 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMovimiento ?)
   	?id6 <- (numeroBloqueos ?)

   	(test (eq ?direction south))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (numeroBloqueos 0))
	(assert (numeroMovimientos (+ ?x 1)))
	(assert (ultimoMovimiento south))

	(assert (casilla (- ?i 1) ?j))
	(assert (casilla-actual (- ?i 1) ?j))

	(assert (Secuencia 0))
   	(moveWilly ?direction) ;;Llamada a la función que se nos da ya implementada
)
;*****************************************

;********moverWillyEste*******************
;Tipo: regla
;Función: esta regla mueve a Willy una casilla hacia el este.

(defrule moverWillyEste
	?id <- (numeroMovimientos ?x)
   	?id2 <- (proxMov ?direction)
   	?id3 <- (Secuencia 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMovimiento ?)
   	?id6 <- (numeroBloqueos ?)

   	(test (eq ?direction east))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (numeroBloqueos 0))
	(assert (numeroMovimientos (+ ?x 1)))
	(assert (ultimoMovimiento east))

	(assert (casilla ?i (+ ?j 1)))
	(assert (casilla-actual ?i (+ ?j 1)))

	(assert (Secuencia 0))
   	(moveWilly ?direction) ;;Llamada a la función que se nos da ya implementada
)
;*****************************************

;********moverWillyOeste******************
;Tipo: regla
;Función: esta regla mueve a Willy una casilla hacia el este.

(defrule moverWillyOeste
	?id <- (numeroMovimientos ?x)
   	?id2 <- (proxMov ?direction)
   	?id3 <- (Secuencia 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMovimiento ?)
   	?id6 <- (numeroBloqueos ?)

   	(test (eq ?direction west))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (numeroBloqueos 0))
	(assert (numeroMovimientos (+ ?x 1)))
	(assert (ultimoMovimiento west))

	(assert (casilla ?i (- ?j 1)))
	(assert (casilla-actual ?i (- ?j 1)))

	(assert (Secuencia 0))
   	(moveWilly ?direction) ;;Llamada a la función que se nos da ya implementada
)
;*****************************************









(defrule peligromonstruo
 	(declare (salience 61))
	(or (percepts Noise)
 		(percepts Noise ?)
 		(percepts ? Noise))

 	(not (haslaser)) 

 	?id <- (numeroMovimientos ?x)
    ?id2 <- (proxMov ?direction)
    ?id3 <- (Secuencia 4)
    ?id4 <- (casilla-actual ?i ?j)
    ?id5 <- (ultimoMovimiento ?mov)

=>
 	(retract ?id ?id2 ?id3 ?id4 ?id5)
 	(assert (Secuencia 0))
 	(assert (numeroMovimientos (+ ?x 1)))

 	(if (eq ?mov north)
 		then (moveWilly south))
 	(if (eq ?mov south)
 		then (moveWilly north))
 	(if (eq ?mov east)
 		then (moveWilly west))
 	(if (eq ?mov west)
 		then (moveWilly east))

    (if (eq ?mov north)
   		then (assert (casilla-actual (+ ?i 1) ?j)))
   	(if (eq ?mov east)
   		then (assert (casilla-actual ?i (+ ?j 1))))
	(if (eq ?mov west)
		then (assert (casilla-actual ?i (- ?j 1))))
	(if (eq ?mov south)
		then (assert (casilla-actual (- ?i 1) ?j)))

	(if (eq ?mov north)
 		then (assert (ultimoMovimiento south)))
	(if (eq ?mov south)
 		then (assert (ultimoMovimiento north)))
 	(if (eq ?mov east)
 		then (assert (ultimoMovimiento west)))
 	(if (eq ?mov west)
 		then (assert (ultimoMovimiento east)))
)

;---------peligroagujeronegro---------;
;Tipo: regla
;Función: en caso de que haya unas arenas movedizas cerca realiza un movimiento hacia atrás para esquivar el peligro.
;Nota2: se establece la prioridad a 62 para asegurar su ejecución el instante correcto.

(defrule peligroagujeronegro
 	(declare (salience 62))
	(or (percepts Pull)
 		(percepts Pull ?)
 		(percepts ? Pull))

 	?id <- (numeroMovimientos ?x)
    ?id2 <- (proxMov ?direction)
    ?id3 <- (Secuencia 4)
    ?id4 <- (casilla-actual ?i ?j)
    ?id5 <- (ultimoMovimiento ?mov)

=>
 	(retract ?id ?id2 ?id3 ?id4 ?id5)
 	(assert (Secuencia 0))
 	(assert (numeroMovimientos (+ ?x 1)))

 	(if (eq ?mov north)
 		then (moveWilly south))
 	(if (eq ?mov south)
 		then (moveWilly north))
 	(if (eq ?mov east)
 		then (moveWilly west))
 	(if (eq ?mov west)
 		then (moveWilly east))

    (if (eq ?mov north)
   		then (assert (casilla-actual (+ ?i 1) ?j)))
   	(if (eq ?mov east)
   		then (assert (casilla-actual ?i (+ ?j 1))))
	(if (eq ?mov west)
		then (assert (casilla-actual ?i (- ?j 1))))
	(if (eq ?mov south)
		then (assert (casilla-actual (- ?i 1) ?j)))

	(if (eq ?mov north)
 		then (assert (ultimoMovimiento south)))
	(if (eq ?mov south)
 		then (assert (ultimoMovimiento north)))
 	(if (eq ?mov east)
 		then (assert (ultimoMovimiento west)))
 	(if (eq ?mov west)
 		then (assert (ultimoMovimiento east)))
)

;(defrule moveWilly
;   (directions $? ?direction $?)
;   =>
;   (moveWilly ?direction)
;   )

;(defrule fireWilly
;	(hasLaser)
;	(directions $? ?direction $?)
;	=>
;	(fireLaser ?direction)
;	)
