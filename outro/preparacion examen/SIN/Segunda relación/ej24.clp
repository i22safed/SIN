(deffacts vector "Datos a comprobar"
	(vector 2 3 4) ; No sim�trico
	(vector 1 2 3 2 1) ; Sim�trico impar
	(vector 1 2 2 1) ; Sim�trico par
)

(defrule compruebaSimetria
	(forall (vector $?cabeza ?x $?medio ?y $?cola&: (eq (length cabeza) (length cola))))
	(test (eq ?x ?y))
=>
(printout t "El vector es sim�trico" crlf)
)