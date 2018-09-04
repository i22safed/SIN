(deftemplate fecha
	(slot dia (type NUMBER) (range 1 31))
	(slot mes (type NUMBER)	(range 1 12))
	(slot ano (type NUMBER))
)
(defrule comprobarFecha
	
	(or
		(fecha (dia ?x&:(> ?x 30)) (mes ?y&11|4|6|9) (ano ?z))
		(and
			(fecha (dia ?t&:(> ?t 28)) (mes 2) (ano ?k))
			(not
			(or
				(and 
					(test (= (mod ?k 4) 0))
					(not (test (= (mod ?k 100) 0)))
				)
			(test (= (mod ?k 400) 0))
			))	
		)
	)
	=>
	(printout t "La fecha es incorrecta." crlf)
)