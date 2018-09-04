;ejercicio 14

(deffacts calcular
  (valor 3) ;Valor a calcular el factorial
) 

(deffacts Resultado-factorial
  (resultado 1) ;Para no multiplicar por cero
) 

(defrule calcular-factorial
  ?h1 <- (valor ?x&:(> ?x 1))
  ?h2 <- (resultado ?r)
  =>
    (retract ?h1 ?h2)
    (assert (resultado (* ?x ?r)))
    (assert (valor (- ?x 1))
  )
) 


(defrule mostrar-factorial
  (valor  ?x&:(= ?x 1))
  (resultado ?r)
  =>
  (printout t "El resultado del factorial es: " ?r crlf))



