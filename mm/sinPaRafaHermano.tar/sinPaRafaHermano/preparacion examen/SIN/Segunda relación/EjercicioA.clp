;EjercicioA


(deffacts hechos
	
	(pos 1)
	
	(pos 2)
	
	(pos 3)
	
	(pos 4)
	
	(pos 5)
	
	(pos 6)
	
	(pos 7)

	(pos 8)
	
	(reina 0 0)

)




(defrule reinas
	
	(pos ?f)
	
	(pos ?c)

	(forall	(reina ?f2 ?c2)

		(test(not ;no se tienen que cumplir alguna
			(or

				(= ?f ?f2) ;ni misma fila ni columna

				(= ?c ?c2) ;ni misma fila ni columna
				(= (+ ?f ?c) (+ ?f2 ?c2)) ;ni en diagonal
				(= (- ?f ?c) (- ?f2 ?c2)) ;ni en diagonal

				)

		)
		
	)
	
	)
	
	(not (reina ?f ?c)) ;y no hay reina ya con esa posicion


	=>

	(assert(reina ?f ?c))
)
	
