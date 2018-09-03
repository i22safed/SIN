;============================EJERCICIO 2===============================
;En una residencia de estudiantes se desea mantener información sobre los
;estudiantes alojados y las habitaciones de la residencia que ocupan.
;Se tendrán en cuenta las siguientes consideraciones:
;	-Hay habitaciones de cuatro tipos: 1 simple, 1 doble, 1 triple y 1 cuádruple
;	-Es más económico llenar las habitaciones más grandes
;	-Todos los ocupantes de una habitación deben ser del mismo sexo
;	-Todos los ocupantes de una habitación deben ser fumadores o no fumadores

;Defina las plantillas necesarias para poder almacenar la información
;tanto de estudiantes como de las habitaciones. Además, escriba las reglas
;necesarias para alojar a un estudiante de manera que sea asignado a una
;habitación que esté ya parcialmente ocupada y sea compatible o, si no,
;que sea asignado a la mayor habitación libre disponible. Si no hay
;ninguna habitación disponible, deberá mostrarse un mensaje por pantalla.
;======================================================================


(deftemplate estudiante "Datos de los estudiantes a alojar"
	(slot nombre 
		(type STRING)
		(default ?NONE))
	(slot apellidos
		(type STRING)
		(default ?NONE))
	(slot sexo
		(type SYMBOL)
		(allowed-values H M) 
		(default ?NONE))
	(slot fuma
		(type SYMBOL)
		(allowed-symbols TRUE FALSE)
		(default ?NONE))
	(slot habitacion
		(type SYMBOL)
		(allowed-symbols FALSE simple doble triple cuadruple)
		(default FALSE))
)

(deftemplate habitacion "Datos de las habitaciones"
	(slot tipo 
		(type SYMBOL)
		(allowed-symbols simple doble triple cuadruple) 
		(default ?NONE))
	(slot capacidad 
		(type INTEGER)
		(range 1 4)
		(default ?NONE))
	(slot ocupantes
		(type INTEGER)
		(default 0))
)

;==================================================================================

(deffacts estudiantes "Lista de estudiantes para asignar a las habitaciones"
	(estudiante (nombre "Carmen") (apellidos "Lopez Lopez") (sexo M) (fuma FALSE))
	(estudiante (nombre "Luis") (apellidos "Gomez Gomez") (sexo H) (fuma FALSE))
	(estudiante (nombre "Pedro") (apellidos "Rodriguez Rodriguez") (sexo H) (fuma TRUE))
	(estudiante (nombre "Sara") (apellidos "Campos Campos") (sexo M) (fuma FALSE))
	(estudiante (nombre "Juan") (apellidos "Castro Castro") (sexo H) (fuma FALSE))
	(estudiante (nombre "Ana") (apellidos "Ruiz Ruiz") (sexo M) (fuma TRUE))
	(estudiante (nombre "Sonia") (apellidos "Gonzalez Gonzalez") (sexo M) (fuma TRUE))
)


(deffacts habitaciones "Información sobre las habitaciones disponibles"
	(habitacion (tipo simple) (capacidad 1))
	(habitacion (tipo doble) (capacidad 2))
	(habitacion (tipo triple) (capacidad 3))
	(habitacion (tipo cuadruple) (capacidad 4))
)

;==================================================================================

(defrule imposibleAsignar "Informa cuando no se puede alojar a un estudiante"
	(estudiante (habitacion FALSE)(nombre ?nombre)								;No se podrá asignar un estudiante a una habitación:
		 	 (sexo ?s1)(fuma ?f1))												;Si el estudiante es fumador y el resto no o viceversa,
		 	 																	;si es del sexo opuesto al resto de inquilinos,
	(not (habitacion (ocupantes 0)))											;o bien si la habitación está llena
	(forall (and (habitacion 											
				(tipo ?n)(capacidad ?c)(ocupantes ?o))							;Se comprueba para todas las habitaciones y cada uno de los estudiantes:
			  (exists (estudiantes												;...
						(habitacion ?n)											;Que la habitación ya esté llena
						(sexo ?s1)(fuma ?f1))))									;Si se activa esta regla es porque los estudiantes que ya están residiendo impiden
		   (test (= ?c ?o)))													;la compatibilidad de condiciones para alojar a alguien más y porque la habitación
	=>																			;simple también está llena
	(printout t ?nombre " no puede ser asignado/a a ninguna habitacion." crlf)
)


(defrule alojar "Asigna habitación compatible al estudiante"

	?estudiante <- (estudiante 											;Para cumplir la compatibilidad especificada en el enunciado se procede así:
					(nombre ?nombre)									;Se emparejan los datos de un estudiante que no tenga habitación
					(habitacion FALSE)
					(sexo ?s1)(fuma ?f1))
	?habitacion <- (habitacion 											;Se emparejan los datos de una habitación que no esté llena
					(tipo ?n1)
					(capacidad ?c1)
					(ocupantes ?o1&:(< ?o1 ?c1)))						;la habitación no está llena si los ocupantes son menores que la capacidad p.ej: 2 < 4
	(exists (estudiante 
			(habitacion ?n1)(sexo ?s1)(fuma ?f1)))						;Se comprueba que exista una asignación posible de ese estudiante a una habitación

				=>
	(modify ?estudiante (habitacion ?n1))								;En caso afirmativo, se le asigna la habitación emparejada al estudiante
	(modify ?habitacion (ocupantes (+ 1 ?o1)))							;Y los ocupantes de dicha habitación se incrementan en uno

	(printout t ?nombre " se ha asignado a la habitación " ?n1 crlf)	;Se muestra por pantalla a quién se le ha asignado qué habitación
)


(defrule nueva-habitación "Asigna al estudiante una habitación vacía"

	?estudiante <- (estudiante 											;Para estudiantes que vayan a entrar en una habitación vacía el procedimiento es similar:
					(nombre ?nombre)									;Se emparejan los datos de un estudiante que no tenga habitación
					(habitacion FALSE)
					(sexo ?s1)(fuma ?f1))
	(forall 	(estudiantes											;Se comprueba para todos los estudiantes que ya tengan asignada una habitación
				(habitacion ?n&~FALSE)
				(sexo ?s1)(fuma ?f1))
			(habitacion 												;Que exista alguna habitación de igual capacidad y ocupantes (en este caso cero)
				(tipo ?n)(capacidad ?c)(ocupantes ?c)))

	?habitacion <- (habitacion 											;Se emparejan los datos de una habitación vacía
					(tipo ?n1)
					(capacidad ?c1)
					(ocupantes 0))

	(not (habitacion 													;Se comprueba que no haya una habitación vacía con mayor capacidad 
			(ocupantes 0)(capacidad ?c&:(< ?c1 ?c))))					;que la que se había emparejado previamente, puesto que
																		;hay que llenar primero las habitaciones más grandes
				=>
	(modify ?estudiante (habitacion ?n1))								;En ese caso se le asigna la habitación emparejada al estudiante
	(modify ?habitacion (ocupantes 1))									;que será el primer (o único) ocupante de la habitación

	(printout t ?nombre " se ha asignado a la habitación " ?n1 crlf)	;Se muestra por pantalla a quién se le ha asignado qué habitación
)