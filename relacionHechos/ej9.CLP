


; 9. Escribe una plantilla que permita representar información sobre el juego de
; los barquitos, en el que se colocan barcos sobre una cuadrícula, indicando las
; posiciones mediante filas (letras) y columnas (números). Para cada barco hay
; que indicar:
;
;   • Las casillas que ocupa, que pueden ser como máximo 4.
;   • El tipo de barco, que sólo puede ser uno de los siguientes: patrullera,
;   dragaminas, fragata, acorazado, destructor, portaaviones.
;   • El estado en que se encuentra el barco, que sólo puede ser uno de los
;   siguientes: indemne, tocado, hundido.
;
; Además, deben contemplarse las siguientes restricciones:
;
;   • El usuario debe dar siempre valor a los atributos correspondientes a casillas
;   ocupadas y tipo de barco.
;   • El valor por defecto para el estado del barco es indemne.


(deftemplate barco

     (slot tipo
		(type SYMBOL)
		(allowed-values patrullera dragaminas fragata acorazado destructor portaaviones)
		(default ?NONE)
     )

	(slot estado
		(allowed-values indemne tocado hundido)
		(default ?NONE)
     )

     (slot casillasOcupadas
		(type INTEGER)
		(range 0 4)
		(default ?NONE)
     )

	(slot fila
		(type STRING)
		(default ?NONE)
     )

     (slot columna
		(type INTEGER)
		(default ?NONE)
     )
)
