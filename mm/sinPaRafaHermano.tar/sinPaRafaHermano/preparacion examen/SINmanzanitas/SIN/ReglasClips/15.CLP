;ejercicio 15

(deftemplate sensores
	(slot codigo (type INTEGER)
		     (range 1 10))
	(slot estado(type SYMBOL)
		    (allowed-symbols correcto incorrecto))
)

(deffacts hechos 
	(sensores(codigo 1)(estado incorrecto))
	(sensores(codigo 2)(estado incorrecto))
	(sensores(codigo 4)(estado correcto))	
	(sensores(codigo 3)(estado incorrecto))	
	(sensores(codigo 5)(estado correcto))
)

(defrule tressensores
(exists
	(sensores(codigo ?uno)(estado incorrecto))
	(sensores(codigo ?dos &~?uno)(estado incorrecto))
	(sensores(codigo ?tres &~?uno&~?dos)(estado incorrecto))
)
	=>
	(printout t "tres sensores incorrectos")

)
