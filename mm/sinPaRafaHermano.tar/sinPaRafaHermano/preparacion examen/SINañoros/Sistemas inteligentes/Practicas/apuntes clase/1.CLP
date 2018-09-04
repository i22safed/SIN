(defrule hola
	?h1<-(hola)
	=> (printout t
	"hola jmi" crlf)
	(retract ?h1)
	(assert (tiempo))
	)
(defrule notiempo
	?h2<-(tiempo)
	=> (printout t
	"no time" crlf)
	(retract ?h2)
	(assert (adios))
	)
(defrule adios
	?h3<-(adios)
	=> (printout t
	"adios jmi" crlf)
	(retract ?h3)
	)