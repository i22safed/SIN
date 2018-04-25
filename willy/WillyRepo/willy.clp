;---------WILLY.CLP--------;
;Autores:
;	- Díaz Marmolejo, José Ignacio
;	- Llamas Nuflo, Diego
;Fecha: 11/05/2017

;---------CONSTRUCTOR---------;
;Tipo: deffacts
;Nota: contiene los hechos que se introducirán desde el principio:
;	- ultimoMov: hecho donde guardaremos la dirección del último movimiento realizado. Hecho único.
;	- movimientos: hecho donde guardaremos el número de movimientos. Hecho único.
;	- casilla: hecho que guarda una casilla ya visitada. Se repetirá durante la ejecución con nuevas casillas.
;	- casilla-actual: hecho que guarda la posición donde se encuentra Willy en cada momento. Hecho único.
;	- Acto: hecho que permite establecer una secuencia en la ejecución del programa. Hecho único.
;	- contador: hecho usado para la detección de bloqueos en el movimiento.

(deffacts Constructor
	(ultimoMov NULL)
	(movimientos 0)
	(casilla 0 0)
	(casilla-actual 0 0)
	(Acto 0)
	(contador 0)
)

;---------Puede-o-NoPuede-Moverse---------;
;Tipo: regla
;Función: permite establecer un límite de movimiento sobre el que Willy no se podrá mover.
;Nota: se establece la prioridad a 50 para asegurar su ejecución el instante correcto.

(defrule Puede-o-NoPuede-Moverse
	(declare (salience 50))
	?id <- (Acto 0)
	(movimientos ?x)
	(test (< ?x 999))
=>	
	(retract ?id)
	(assert (Acto 1))
)

;---------EscogerDirección---------;
;Tipo: regla
;Función: se escoge una dirección al azar sobre la cual se hará un breve análisis para ver si es posible moverse a dicha dirección

(defrule EscogerDireccion
	?id <- (Acto 1)
	(movimientos ?x)
	(directions $? ?direction $?)
=>
	(retract ?id)
	(assert (Acto 2))
	(assert (proxMov ?direction))
)

;---------Posición-a-la-que-Movernos---------;
;Tipo: regla
;Función: permite introducir en la base de hechos un hecho -proxCasilla- para ver cuál sería la casilla a la que nos moveríamos.

(defrule Posicion-a-la-que-Movernos
	?id <- (Acto 2)
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

	(assert (Acto 3))
)

;---------Comprobar-Casilla-Visitada---------;
;Tipo: regla
;Función: regla que se activa cuando la casilla a la que nos moveríamos sí está visitada -debemos escoger otra por tanto-.
;Nota: en caso de activarse, produce un retroceso en la secuencia de ejecución del programa -hasta Acto 0-.

(defrule Comprobar-Casilla-Visitada
	?id <- (Acto 3)
	?id2 <- (proxCasilla ?i ?j)
	?id3 <- (proxMov ?)
	?id4 <- (contador ?valor)
	(casilla ?i ?j)
=>
	(retract ?id ?id2 ?id3 ?id4)
	(assert (contador (+ ?valor 1)))
	(assert (Acto 0))
)

;---------Comprobar-Casilla-NOvisitada---------;
;Tipo: regla
;Función: regla que se activa cuando la casilla a la que nos moveríamos no está visitada -la secuencia continúa-.

(defrule Comprobar-Casilla-NOvisitada "En este caso NO esta visitada"
	?id <- (Acto 3)
	?id2 <- (proxCasilla ?i ?j)
	?id3 <- (contador ?valor)
	(not (casilla ?i ?j))
=>
	(retract ?id ?id2)
	(assert (contador 0))
	(assert (Acto 4))
)

;---------Willy-Bloqueado---------;
;Tipo: regla
;Función: detecta bucles en la secuencia Acto 0 -> Acto 1 -> Acto 2 -> Acto 3 y rompe dicho bucle.
;Nota: en caso de activarse, rompe la secuencia normal -se introduce el Acto Especial-.
;Nota2: se establece la prioridad a 51 para asegurar su ejecución el instante correcto.

(defrule Willy-Bloqueado
	(declare (salience 51))
	?id <- (contador ?valor)
	?id2 <- (Acto ?) 
	(test (eq ?valor 15))
=>
	(retract ?id ?id2)
	(assert (contador 0))
	(assert (Acto Especial))
)

;---------moveWilly-Random---------;
;Tipo: regla
;Función: permite un movimiento en una dirección al azar en caso de bloqueo.
;Nota: en caso de activarse, continúa la secuencia del programa por el Acto 4.

(defrule moveWilly-Random
	?id <- (Acto Especial)
	(directions $? ?direction $?)
=>
	(retract ?id)
	(assert (proxMov ?direction))
	(assert (Acto 4))
)

;---------moveWilly-Norte---------;
;Tipo: regla
;Función: realiza un movimiento en la dirección norte.

(defrule moveWilly-Norte
	?id <- (movimientos ?x)
   	?id2 <- (proxMov ?dire)
   	?id3 <- (Acto 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMov ?)
   	?id6 <- (contador ?)

   	(test (eq ?dire north))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (contador 0))
	(assert (movimientos (+ ?x 1)))
	(assert (ultimoMov north))

	(assert (casilla (+ ?i 1) ?j))
	(assert (casilla-actual (+ ?i 1) ?j))

	(assert (Acto 0))
   	(moveWilly ?dire)
)

;---------moveWilly-Sur---------;
;Tipo: regla
;Función: realiza un movimiento en la dirección sur.

(defrule moveWilly-Sur
	?id <- (movimientos ?x)
   	?id2 <- (proxMov ?dire)
   	?id3 <- (Acto 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMov ?)
   	?id6 <- (contador ?)

   	(test (eq ?dire south))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (contador 0))
	(assert (movimientos (+ ?x 1)))
	(assert (ultimoMov south))

	(assert (casilla (- ?i 1) ?j))
	(assert (casilla-actual (- ?i 1) ?j))

	(assert (Acto 0))
   	(moveWilly ?dire)
)

;---------moveWilly-Este---------;
;Tipo: regla
;Función: realiza un movimiento en la dirección este.

(defrule moveWilly-Este
	?id <- (movimientos ?x)
   	?id2 <- (proxMov ?dire)
   	?id3 <- (Acto 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMov ?)
   	?id6 <- (contador ?)

   	(test (eq ?dire east))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (contador 0))
	(assert (movimientos (+ ?x 1)))
	(assert (ultimoMov east))

	(assert (casilla ?i (+ ?j 1)))
	(assert (casilla-actual ?i (+ ?j 1)))

	(assert (Acto 0))
   	(moveWilly ?dire)
)

;---------moveWilly-Oeste---------;
;Tipo: regla
;Función: realiza un movimiento en la dirección oeste.

(defrule moveWilly-Oeste
	?id <- (movimientos ?x)
   	?id2 <- (proxMov ?dire)
   	?id3 <- (Acto 4)
   	?id4 <- (casilla-actual ?i ?j)
   	?id5 <- (ultimoMov ?)
   	?id6 <- (contador ?)

   	(test (eq ?dire west))
=>
	(retract ?id ?id2 ?id3 ?id4 ?id5 ?id6)
	(assert (contador 0))
	(assert (movimientos (+ ?x 1)))
	(assert (ultimoMov west))

	(assert (casilla ?i (- ?j 1)))
	(assert (casilla-actual ?i (- ?j 1)))

	(assert (Acto 0))
   	(moveWilly ?dire)
)

;---------fireWilly---------;
;Tipo: regla
;Función: en caso de tener la flecha disponible, al dispara hacia la dirección en la que Willy se movió por última vez.
;Nota2: se establece la prioridad a 65 para asegurar su ejecución el instante correcto.

(defrule fireWilly
	(declare (salience 65))
	(hasArrow)
	(or (percepts Sound)
		(percepts Sound ?)
		(percepts ? Sound))
	(directions $? ?direction $?)

	?id <- (movimientos ?x)
	?id2 <- (Acto 4)
	?id3 <- (ultimoMov ?mov)

=>
	(retract ?id ?id2)
	(assert (movimientos (+ ?x 1)))
	(assert (Acto 0))
	
	(if (eq ?mov north)
		then (fireArrow north))
	(if (eq ?mov south)
		then (fireArrow south))
	(if (eq ?mov east)
		then (fireArrow east))
	(if (eq ?mov west)
		then (fireArrow west))

)

;---------peligroSerpiente---------;
;Tipo: regla
;Función: en caso de no tener la flecha disponible y si hay una serpiente cerca realiza un movimiento hacia atrás para esquivar el peligro.
;Nota2: se establece la prioridad a 61 para asegurar su ejecución el instante correcto.

(defrule peligroSerpiente
 	(declare (salience 61))
	(or (percepts Sound)
 		(percepts Sound ?)
 		(percepts ? Sound))

 	(not (hasArrow))

 	?id <- (movimientos ?x)
    ?id2 <- (proxMov ?dire)
    ?id3 <- (Acto 4)
    ?id4 <- (casilla-actual ?i ?j)
    ?id5 <- (ultimoMov ?mov)

=>
 	(retract ?id ?id2 ?id3 ?id4 ?id5)
 	(assert (Acto 0))
 	(assert (movimientos (+ ?x 1)))

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
 		then (assert (ultimoMov south)))
	(if (eq ?mov south)
 		then (assert (ultimoMov north)))
 	(if (eq ?mov east)
 		then (assert (ultimoMov west)))
 	(if (eq ?mov west)
 		then (assert (ultimoMov east)))
)

;---------peligroArenas---------;
;Tipo: regla
;Función: en caso de que haya unas arenas movedizas cerca realiza un movimiento hacia atrás para esquivar el peligro.
;Nota2: se establece la prioridad a 62 para asegurar su ejecución el instante correcto.

(defrule peligroArenas
 	(declare (salience 62))
	(or (percepts Tremor)
 		(percepts Tremor ?)
 		(percepts ? Tremor))

 	?id <- (movimientos ?x)
    ?id2 <- (proxMov ?dire)
    ?id3 <- (Acto 4)
    ?id4 <- (casilla-actual ?i ?j)
    ?id5 <- (ultimoMov ?mov)

=>
 	(retract ?id ?id2 ?id3 ?id4 ?id5)
 	(assert (Acto 0))
 	(assert (movimientos (+ ?x 1)))

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
 		then (assert (ultimoMov south)))
	(if (eq ?mov south)
 		then (assert (ultimoMov north)))
 	(if (eq ?mov east)
 		then (assert (ultimoMov west)))
 	(if (eq ?mov west)
 		then (assert (ultimoMov east)))
)

