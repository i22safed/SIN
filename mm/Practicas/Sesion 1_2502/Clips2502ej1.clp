(deffacts hechos 

	(hombre Socrates))

; Todos los hombres son mortales // Socrates -> ?x
(defrule r1 
	
	(hombre ?x) ; Elemento condicionante 

	=>

	(assert(mortal ?x))
	
)