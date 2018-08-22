
;
; 7.-	Haz un programa que dado un conjunto de hechos de la
;     forma (dato 1), (dato 5), (dato verde)..., cree un único hecho
;     (todos-los-datos ...) con todos los valores de los hechos
;     anteriores.
;

(deffacts hechos 

	(dato verde)
	(dato 1)
	(dato 5)
	(dato wesel)
	(todos-los-datos)
)


(defrule agrupa-datos

	?h1<-(dato ?x)
	?h2<-(todos-los-datos $?valors)

	=>
	(retract ?h1 ?h2)
	(assert(todos-los-datos $?valors ?x))

)