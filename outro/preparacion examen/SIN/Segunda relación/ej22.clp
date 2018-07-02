(deffacts vector "Datos a comprobar"
	(vector 2 3 4) ; No simétrico
	(vector 1 2 3 2 1) ; Simétrico impar
	(vector 1 2 2 1) ; Simétrico par
)

(defrule recorreVector
	?h<-(vector ?x $?contenido ?x)
	=>
	(retract ?h)
	(assert (vector $?contenido))
)

(defrule simPar
	(vector )
	=>
	(printout t "El vector es simétrico par" crlf)
)

(defrule simImpar
	(vector ?x)
	=>
	(printout t "El vector es simétrico impar" crlf)
)

(defrule noSim
	(vector ?x $?medio ?y)
	=>
	(printout t "El vector es no simétrico" crlf)
)