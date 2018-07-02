



Relacion de ejercicios 2: Reglas  

;1. En una granja hay animales de los siguientes tipos: perros, gatos, patos, vacas, ovejas y gallos.Escribe 
;	una serie de reglas de manera que en base a un hecho que indique el sonido que hace un animal identifique 
;	qué clase de animal es. Por ejemplo, si se afirma un hecho como (sonido kikiriki), el programa debe 
;	imprimir por pantalla el mensaje “Se trata de un gallo”.

(deftemplate animal

	(slot tipo)
	(slot sonido)

)

(deffacts hechos
	

	(animal(tipo gallo)(sonido kikiriki))
	(animal(tipo perro)(sonido guau))
	(animal(tipo gato)(sonido miau))
	(animal(tipo pato)(sonido cuak))
	(animal(tipo vaca)(sonido muuu))
	(animal(tipo oveja)(sonido beee))

)

(defrule sonidos
		
	(animal (tipo ?x) (sonido kikiriki))
=>
	(printout t "Se trata de un: " ?x crlf)

)