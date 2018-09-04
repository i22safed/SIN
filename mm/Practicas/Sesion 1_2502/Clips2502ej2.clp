; Objetivos 
; Explicar:

	; Mecanismo de inferencia de comparacion de patrones 
	; Refractabilidad: Un mismo hecho no produce activacion repetidas de reglas 
	; Prioridad en la agenda respecto a los hechos recientes: 
	; 	Reglas que emparejen con los hechos mas recientes de la agenda wesel


(deffacts h1; constructor de hechos 

	(hombre Socrates); hecho ordenador con dos campos ocupados por simbolos 
	(hombre Platon) ; 
) 


(defrule r1; declaracion de una regla 

	(hombre ?x); Elemento condicional del patron 

=>

	(assert(mortal ?x)); Accion de afirmacion del hecho ordenado (mortal 

) 


(defrule r2; Declaracion de una regla 

	(mortal ?x)
=>
	(printout t ?x " Es mortal" crlf )

)