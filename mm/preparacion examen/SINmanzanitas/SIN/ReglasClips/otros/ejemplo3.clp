(defrule reglaComparacion
"comparo dos numeros, primero menor que segundo"
(dato ?x&: (numberp ?x) ?y&: (> ?y ?x))
=>
(printout t "Se dispara regla para "?x" "$?y" "?x crlf)
)

(deffacts constructorBasico
"Algunos hechos a afirmar"
(colores rojo amarillo rojo)
(colores blacno azul verde)
(colores blanco azul verde blanco)
)