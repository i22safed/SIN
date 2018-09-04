(defrule esGitano
	(sonido ayqueteloroboto)
	=>
	(printout t "Es un gitano" crlf))

(defrule esGallo
	(sonido kikiriki)
	=>
	(printout t "Es un gallo" crlf))

(defrule esPerro
	(sonido guau)
	=>
	(printout t "Es un perro" crlf))

(deffacts sonidos
	(sonido ayqueteloroboto)
	(sonido guau))