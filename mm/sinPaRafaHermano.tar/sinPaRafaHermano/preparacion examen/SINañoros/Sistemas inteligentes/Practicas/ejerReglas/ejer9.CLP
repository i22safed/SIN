(deftemplate habitacion
	(slot id (type INTEGER))
	(slot tipo (allowed-values simple doble triple cuadruple))
	(slot sexo (allowed-values null hombre mujer))
	(slot fumadores (allowed-values null si no))
	(slot ocupantes (default 0))
	)
(deftemplate estudiante
	(slot nombre)
	(slot sexo (allowed-values hombre mujer))
	(slot fumador (allowed-values si no))
	(slot habitacion (default -1)(type INTEGER))
	)

(deffacts hechos
	(habitacion (id 1) (tipo simple))
	(habitacion (id 2) (tipo cuadruple))
	(habitacion (id 3) (tipo doble))
	(habitacion (id 4) (tipo triple))
	(habitacion (id 5) (tipo doble))
	(habitacion (id 6) (tipo cuadruple))
	(estudiante (nombre juan) (sexo hombre) (fumador no))
	(estudiante (nombre juan2) (sexo hombre) (fumador si))
	(estudiante (nombre juan3) (sexo hombre) (fumador no))
	(estudiante (nombre juan4) (sexo hombre) (fumador si))
	(estudiante (nombre ana) (sexo mujer) (fumador no))
	(estudiante (nombre ana1) (sexo mujer) (fumador si))
	(estudiante (nombre ana2) (sexo mujer) (fumador no))
	(estudiante (nombre ana3) (sexo mujer) (fumador si))
	(estudiante (nombre ana4) (sexo mujer) (fumador no))
	(estudiante (nombre ana5) (sexo mujer) (fumador no))
	)

(defrule meterHabitacion4
	?h1<-(estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion -1))
	?h2<-(habitacion (id ?i) (tipo cuadruple) (fumadores ?f4&:(or (eq ?f4 ?f) (eq ?f4 null))) (sexo ?s4&:(or (eq ?s4 ?s) (eq ?s4 null))) (ocupantes ?o))
	(test (< ?o 4))
	=>
	(retract ?h1 ?h2)
	(assert (estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion ?i)))
	(assert (habitacion (id ?i) (tipo cuadruple) (fumadores ?f) (sexo ?s) (ocupantes (+ ?o 1))))
)

(defrule meterHabitacion3
	?h1<-(estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion -1))
	(not (habitacion (id ?i) (tipo cuadruple) (fumadores ?f4&:(or (eq ?f4 ?f) (eq ?f4 null))) (sexo ?s4&:(or (eq ?s4 ?s) (eq ?s4 null))) (ocupantes ?o4&:(< ?o4 4))))
	?h2<-(habitacion (id ?i) (tipo triple) (fumadores ?f3&:(or (eq ?f3 ?f) (eq ?f3 null))) (sexo ?s3&:(or (eq ?s3 ?s) (eq ?s3 null))) (ocupantes ?o))
	(test (< ?o 3))
	=>
	(retract ?h1 ?h2)
	(assert (estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion ?i)))
	(assert (habitacion (id ?i) (tipo triple) (fumadores ?f) (sexo ?s) (ocupantes (+ ?o 1))))
)

(defrule meterHabitacion2
	?h1<-(estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion -1))
	(not (habitacion (id ?i) (tipo cuadruple) (fumadores ?f4&:(or (eq ?f4 ?f) (eq ?f4 null))) (sexo ?s4&:(or (eq ?s4 ?s) (eq ?s4 null))) (ocupantes ?o4&:(< ?o4 4))))
	(not (habitacion (id ?i) (tipo triple) (fumadores ?f3&:(or (eq ?f3 ?f) (eq ?f3 null))) (sexo ?s3&:(or (eq ?s3 ?s) (eq ?s3 null))) (ocupantes ?o3&:(< ?o3 3))))
	?h2<-(habitacion (id ?i) (tipo doble) (fumadores ?f2&:(or (eq ?f2 ?f) (eq ?f2 null))) (sexo ?s2&:(or (eq ?s2 ?s) (eq ?s2 null))) (ocupantes ?o))
	(test (< ?o 2))
	=>
	(retract ?h1 ?h2)
	(assert (estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion ?i)))
	(assert (habitacion (id ?i) (tipo doble) (fumadores ?f) (sexo ?s) (ocupantes (+ ?o 1))))
)
(defrule meterHabitacion1
	?h1<-(estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion -1))
	(not (habitacion (id ?i) (tipo cuadruple) (fumadores ?f4&:(or (eq ?f4 ?f) (eq ?f4 null))) (sexo ?s4&:(or (eq ?s4 ?s) (eq ?s4 null))) (ocupantes ?o4&:(< ?o4 4))))
	(not (habitacion (id ?i) (tipo triple) (fumadores ?f3&:(or (eq ?f3 ?f) (eq ?f3 null))) (sexo ?s3&:(or (eq ?s3 ?s) (eq ?s3 null))) (ocupantes ?o3&:(< ?o3 3))))
	(not (habitacion (id ?i) (tipo doble) (fumadores ?f2&:(or (eq ?f2 ?f) (eq ?f2 null))) (sexo ?s2&:(or (eq ?s2 ?s) (eq ?s2 null))) (ocupantes ?o2&:(< ?o2 2))))
	?h2<-(habitacion (id ?i) (tipo simple) (fumadores ?f1&:(or (eq ?f1 ?f) (eq ?f1 null))) (sexo ?s1&:(or (eq ?s1 ?s) (eq ?s1 null))) (ocupantes ?o))
	(test (< ?o 1))
	=>
	(retract ?h1 ?h2)
	(assert (estudiante (nombre ?n) (sexo ?s) (fumador ?f) (habitacion ?i)))
	(assert (habitacion (id ?i) (tipo simple) (fumadores ?f) (sexo ?s) (ocupantes (+ ?o 1))))
) 
