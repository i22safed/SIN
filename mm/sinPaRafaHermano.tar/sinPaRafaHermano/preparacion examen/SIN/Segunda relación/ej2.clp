(deftemplate animal
	(slot nombre)
	(slot sonido))
(deffacts animales
	(animal (nombre perro) (sonido guau))
	(animal (nombre pato) (sonido cuac))
	(animal (nombre vaca) (sonido mu))
	(animal (nombre oveja) (sonido beeee))
	(animal (nombre gallo) (sonido kikiriki))
	(animal (nombre gato) (sonido miau)))
(deffacts sonidos
	(sonido guau)
	(sonido mu)
	(sonido kikiriki))
(defrule esAnimal
	(animal (nombre ?x) (sonido ?y))
	(sonido ?y)
	=>
	(printout t ?y" -> "?x crlf))