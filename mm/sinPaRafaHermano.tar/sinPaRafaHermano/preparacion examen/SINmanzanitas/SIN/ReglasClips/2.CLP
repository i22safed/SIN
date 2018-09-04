;ejercicio2

(deftemplate animal
	(slot nombre)
	(slot sonido)
)



(defrule animales
	
	(animal(nombre ?animal)(sonido ?sonido))
	=>
	(printout t "se trata de: " ?animal)
)