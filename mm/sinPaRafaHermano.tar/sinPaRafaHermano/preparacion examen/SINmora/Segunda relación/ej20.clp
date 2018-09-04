(deftemplate alumno
	(slot nombre)
	(slot sexo (allowed-values H M))
	(slot fumador (allowed-values si no))
)
(deftemplate habitacion
	(slot tamano (type NUMBER) (range 1 4))
	(slot fumadores (allowed-values si no))
	(slot sexo (allowed-values H M))
	(slot ocupado (type NUMBER))
	(slot numero)
)
(deffacts hechos
	(alumno (nombre Juan) (sexo H) (fumador si))
	(alumno (nombre Luis) (sexo H) (fumador no))
	(alumno (nombre Carlos) (sexo H) (fumador no))
	(alumno (nombre Maria) (sexo M) (fumador no))
	(alumno (nombre Sara) (sexo M) (fumador si))
	(alumno (nombre Paco) (sexo H) (fumador no))
	(alumno (nombre Cristina) (sexo M) (fumador no))
	(alumno (nombre Rocio) (sexo M) (fumador si))
	(alumno (nombre Manuel) (sexo H) (fumador si))
	(alumno (nombre Clara) (sexo M) (fumador si))
	(alumno (nombre Alberto) (sexo H) (fumador si))
	
	(habitacion (tamano 1) (ocupado 0) (numero 1) (sexo H) (fumadores no)) 
	(habitacion (tamano 2) (ocupado 0) (numero 2) (sexo M) (fumadores no))
	(habitacion (tamano 4) (ocupado 0) (numero 3) (sexo H) (fumadores si))
	(habitacion (tamano 3) (ocupado 0) (numero 4) (sexo H) (fumadores no))
	(habitacion (tamano 2) (ocupado 0) (numero 5) (sexo M) (fumadores si))
)
(defrule habitacionCuadruple
	(declare (salience 50));prioridad
	?h1<-(alumno (nombre ?nombre) (sexo ?sexo) (fumador ?fumador))
	?h2<-(habitacion (tamano 4) (ocupado ?x) (numero ?y) (fumador ?fum) (sexo ?sex))
	(test (neq ?x 4))
	(test (eq ?sex ?sexo))
	(test (eq ?fum ?fumador))
	=>
	(retract ?h1)
	(bing ?x(+ ?x 1))
	(modify ?h2(ocupado ?x))
	(printout t "El alumno "?nombre" ha sido asignado a la habitación "?y" crlf)
)
(defrule habitacionTriple
	(declare (salience 40));prioridad
	?h1<-(alumno (nombre ?nombre) (sexo ?sexo) (fumador ?fumador))
	?h2<-(habitacion (tamano 3) (ocupado ?x) (numero ?y) (fumador ?fum) (sexo ?sex))
	(test (neq ?x 3))
	(test (eq ?sex ?sexo))
	(test (eq ?fum ?fumador))
	=>
	(retract ?h1)
	(bing ?x(+ ?x 1))
	(modify ?h2(ocupado ?x))
	(printout t "El alumno "?nombre" ha sido asignado a la habitación "?y" crlf)
)
(defrule habitacionDoble
	(declare (salience 30));prioridad
	?h1<-(alumno (nombre ?nombre) (sexo ?sexo) (fumador ?fumador))
	?h2<-(habitacion (tamano 2) (ocupado ?x) (numero ?y) (fumador ?fum) (sexo ?sex))
	(test (neq ?x 2))
	(test (eq ?sex ?sexo))
	(test (eq ?fum ?fumador))
	=>
	(retract ?h1)
	(bing ?x(+ ?x 1))
	(modify ?h2(ocupado ?x))
	(printout t "El alumno "?nombre" ha sido asignado a la habitación "?y" crlf)
)
(defrule habitacionSimple
	(declare (salience 20));prioridad
	?h1<-(alumno (nombre ?nombre) (sexo ?sexo) (fumador ?fumador))
	?h2<-(habitacion (tamano 1) (ocupado ?x) (numero ?y) (fumador ?fum) (sexo ?sex))
	(test (neq ?x 1))
	(test (eq ?sex ?sexo))
	(test (eq ?fum ?fumador))
	=>
	(retract ?h1)
	(bing ?x(+ ?x 1))
	(modify ?h2(ocupado ?x))
	(printout t "El alumno "?nombre" ha sido asignado a la habitación "?y" crlf)
)
(defrule alumnoSinHabitacion
	(declare (salience 10));prioridad
	(alumno (nombre ?nombre) (sexo ?sexo) (fumador ?fumador))
	=>
	(printout t "El alumno "?nombre" no ha sido asignado a ninguna habitación crlf)
)