(defrule reglaCochevariables
"Regla sencilla sobre estado de bater�a con variables"
(coche ?x)
(estado-luces ?x tenues)
=>
(assert (estado-bateria ?x defectuoso))
(printout t "Bateria mal"crlf))

?x -> 1 valor
$?x -> 0 o muchos valores