;Ejercicio 20

(deftemplate habitacion
(slot numero)
(slot capacidad (type INTEGER) (range 1 4))
(slot sexo (type SYMBOL) (allowed-symbols hombre mujer))
(slot fumadores (type SYMBOL) (allowed-symbols si no))
(slot plazas-libres (type INTEGER) (range 0 4))
(multislot compañeros))

(deftemplate estudiante
(slot nombre)
(slot sexo (type SYMBOL) (allowed-symbols hombre mujer))
(slot fuma (type SYMBOL) (allowed-symbols si no))
(slot alojado (type SYMBOL INTEGER) (allowed-symbols no) (default no))
)

(deffacts residencia
(habitacion (numero 1) (capacidad 2) (plazas-libres 2))
(habitacion (numero 2) (capacidad 1) (plazas-libres 1))
(habitacion (numero 3) (capacidad 3) (plazas-libres 3))
(habitacion (numero 4) (capacidad 2) (plazas-libres 2))
(estudiante(nombre Paco)(sexo hombre)(fuma no)(alojado no))
(estudiante(nombre Pepe)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre A)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre B)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre C)(sexo hombre)(fuma no)(alojado no))
(estudiante(nombre D)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre E)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre F)(sexo hombre)(fuma si)(alojado no))
(estudiante(nombre G)(sexo hombre)(fuma si)(alojado no))
)


(defrule alojar
?t <- (estudiante(nombre ?nom) (sexo ?s) (fuma ?f) (alojado no))
(not (habitacion(plazas-libres ?pl&:(> ?pl 0))
(sexo ?s)
(fumadores ?f)))
?destino <- (habitacion (numero ?num)
(capacidad ?c2)
(plazas-libres ?c2))
(not (habitacion (capacidad ?c3)
(plazas-libres ?c3&:(> ?c3 ?c2))))
=>
(modify ?t (alojado ?num))
(modify ?destino (plazas-libres (- ?c2 1)) (sexo ?s) (fumadores ?f) (compañeros ?nom))
(printout t "Estudiante " ?nom " alojado en la habitacion " ?num " de capacidad " ?c2 crlf)
)

(defrule alojar_habitacion_compatible
?est <- (estudiante (nombre ?nom) (sexo ?s) (fuma ?f) (alojado no))
?destino <- (habitacion (numero ?num)
(plazas-libres ?pl&:(> ?pl 0))
(capacidad ?c)
(sexo ?s)
(fumadores ?f)
(compañeros $?compañeros))
=>
(modify ?est (alojado ?num))
(modify ?destino (plazas-libres (- ?pl 1)) (compañeros $?compañeros ?nom))
(printout t "Estudiante " ?nom " alojado en la habitacion " ?num " de capacidad " ?c crlf)
)

(defrule estudiante_no_alojable
?est <- (estudiante (nombre ?nom) (sexo ?s) (fuma ?f) (alojado no))
(not (habitacion (plazas-libres ?pl&:(> ?pl 0))
(sexo ?s)
(fumadores ?f)))
(not (habitacion (capacidad ?c)
(plazas-libres ?c)))
=>
(printout t "No hay sitio para alojar a " ?nom crlf)
)
