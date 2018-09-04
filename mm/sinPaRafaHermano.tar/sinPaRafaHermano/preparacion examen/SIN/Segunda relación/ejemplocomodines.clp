(defrule reglaCocheComodin
"Regla sencilla sobre el estado de la bateria con comodines"
(coche ?)
(estado-luces ? tenues))
=>
(assert (estado-bateria Juan defectuoso))
(printout t "Bateria mal"crlf))


? -> Valor simple (un solo campo)
$? -> Valor mútiple (de varios campos)