;*****************************************
; Autores:
; - Salido Álvarez, Rafael
; - Sánchez Fernández, David
; Historial de cambios:
;  - Fecha: mejoras/cambios
;*****************************************

;********Controlador**********************
;Tipo: hechos
;Función: Guardar todos los movimientos que va a realizar Willy por el espacio

(deffacts Controlador
  (ultimoMov NULL) ;guardamos la direccón del último moviento que Willy ha realizado.
  (movimientos 0) ;guardamos el número de movimientos.
  (casilla 0 0 ) ;almacenamos una casilla ya visitada por Willy.
  (actual 0 0) ;almacenamos donde se ecuentra Willy actualmente.
  (acto 0) ;almacenamos por donde va la ejecución del programa.
  (bloqueo 0) ;guardamos los bloqueos en el movimiento
)
;*****************************************







(defrule moveWilly
   (directions $? ?direction $?)
   =>
   (moveWilly ?direction)
   )

(defrule fireWilly
	(hasLaser)
	(directions $? ?direction $?)
	=>
	(fireLaser ?direction)
	)
