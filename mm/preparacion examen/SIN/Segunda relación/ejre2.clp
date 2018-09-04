(deftemplate animal
	(slot nombre)
	(slot sonido))

(deffacts animales
	(animal (nombre perro)(sonido guau))
	(animal (nombre gato)(sonido miau))
	(animal (nombre pingu)(sonido noot))
	(animal (nombre cuervo)(sonido peec)))

(deffacts sonidos-escuchados
	(sonido guau)
	(sonido miau)
	(sonido peec))

(defrule esAnimal
	(animal (nombre ?x) (sonido ?y))
	(sonido ?y)
	=>
	(printout t ?y"->"?x crlf))

