(deffacts vector "Datos a comprobar"
	(vector 2 3 4) ; No sim�trico
	(vector 1 2 3 2 1) ; Sim�trico impar
	(vector 1 2 2 1) ; Sim�trico par
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
	(printout t "El vector es sim�trico par" crlf)
)

(defrule simImpar
	(vector ?x)
	=>
	(printout t "El vector es sim�trico impar" crlf)
)

(defrule noSim
	(vector ?x $?medio ?y)
	=>
	(printout t "El vector es no sim�trico" crlf)
)