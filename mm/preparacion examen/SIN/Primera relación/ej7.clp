(deftemplate animal
	(slot reino
		(type SYMBOL)
		(allowed-values mamiferos reptiles aves))
	(slot familia)
	(slot nombre)
	(slot tipo
		(type SYMBOL)
		(allowed-values nocturna diurna)))

(deffacts hechos
(animal (reino mamiferos) (familia roedores) (nombre rata))
(animal (reino mamiferos) (familia roedores) (nombre ardilla))
(animal (reino mamiferos) (familia felinos) (nombre tigre))
(animal (reino mamiferos) (familia felinos) (nombre lince))
(animal (reino mamiferos) (familia felinos) (nombre jaguar))
(animal (reino reptiles) (familia serpientes) (nombre cobra))
(animal (reino reptiles) (familia serpientes) (nombre boa))
(animal (reino aves) (familia rapaces) (tipo diurna) (nombre halcon))
(animal (reino aves) (familia rapaces) (tipo diurna) (nombre gavilan))
(animal (reino aves) (familia rapaces) (tipo nocturna) (nombre buho))
(animal (reino aves) (familia rapaces) (tipo nocturna) (nombre lechuza)))

