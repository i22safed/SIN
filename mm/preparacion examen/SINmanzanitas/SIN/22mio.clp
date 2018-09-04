;Haz un programa que dado un unico hecho vector, detecte si sus valores se repiten de forma simetrica. 
;Siempre que la salida sea correcta, puedes modificar el vector o utilizar hechos auxiliares.


(deffacts hechos
(vector vector1 1 2 3 4 5 6 6 5 4 3 2 1);simetricoPar
(vector vector2 1 2 3 4 6 4 3 2 1);simetricoPar
(vector vector3 1 4 5 6 3 7 8 9 2 4 1 ))

(defrule elimina 
	?h1<-(vector ?nombre ?x $?medio ?x )
	=>
	(retract ?h1)
	(assert (vector ?nombre $?medio))
)


(defrule simPar
	(vector ?nombre)
	=>
	(printout t "El vector " ?nombre " es simétrico par" crlf)
)

(defrule simImpar
	(vector ?nombre ?x)
	=> 
	(printout t "El vector "  ?nombre " es  simetrico impar" crlf)
	
)

(defrule noSimetrica
	(vector ?nombre ?x $?medio ?y)
	=> 
	(printout t "El vector "  ?nombre "  No es  simetrico " crlf)
	
)