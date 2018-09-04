(defrule esPerro
	(sonido guau)
	=>
	(printout t "Es un perro" crlf))
(defrule esGato
	(sonido miau)
	=>
	(printout t "Es un gato" crlf))
(defrule esPato
	(sonido cuac)
	=>
	(printout t "Es un pato" crlf))
(defrule esVaca
	(sonido mu)
	=>
	(printout t "Es una vaca" crlf))
(defrule esGallo
	(sonido kikiriki)
	=>
	(printout t "Es un gallo" crlf))
(defrule esOveja
	(sonido beeee)
	=>
	(printout t "Es un oveja" crlf))

(deffacts sonidos
	(sonido cuac)
	(sonido mu)
	(sonido guau)
	(sonido beeee)
)