(deffacts vector "Datos a comprobar"
	(vector 2 3 4) ; No simétrico
	(vector 1 2 3 2 1) ; Simétrico impar
	(vector 1 2 2 1) ; Simétrico par
)

(defrule compruebaSimetria
	(forall (vector $?cabeza ?x $?medio ?y $?cola&: (eq (length cabeza) (length cola))))
	(test (eq ?x ?y))
=>
(printout t "El vector es simétrico" crlf)
)