(defrule reglaCoche
"Regla sencilla sobre el estado de la bater�a"
(coche Juan)
(estado-luces Juan tenues)
=>
(assert (estado-bateria Juan bajo)))

(deffacts constructorCoche
(coche Juan)
(estado-luces Juan tenues))