(defrule reglaCocheComodin
"Regla sencilla sobre el estado de la bateria con comodines"
(coche ?)
(estado-luces ? tenues))
=>
(assert (estado-bateria Juan defectuoso))
(printout t "Bateria mal"crlf))


(defrule encontrar-datos
(datos $?x $?y //sin terminar