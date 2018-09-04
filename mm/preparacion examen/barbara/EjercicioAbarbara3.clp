(deffacts hechos
	(pos 1)
	(pos 2)
	(pos 3)
	(pos 4)
	(pos 5)
	(pos 6)
	(pos 7)
	(pos 9)
	(pos 10)
	(pos 11)
	(caballo 5 5)
)

(defrule ponerCaballos
	(pos ?f)
	(pos ?c)
	(forall (caballo ?f2 ?c2)
		(test
			(not
				(or
					(and (= ?f (+ ?f2 1 )) (= ?c (- ?c2 2)))
					(and (= ?f (- ?f2 2 )) (= ?c (+ ?c2 1)))
					(and (= ?f (+ ?f2 2 )) (= ?c (- ?c2 1)))					(and (= ?f (- ?f2 1 )) (= ?c (+ ?c2 2)))
					(and (= ?f (- ?f2 2 )) (= ?c (- ?c2 1)))
					(and (= ?f (- ?f2 1 )) (= ?c (- ?c2 2)))
					(and (= ?f (+ ?f2 1 )) (= ?c (+ ?c2 2)))
					(and (= ?f (+ ?f2 2 )) (= ?c (+ ?c2 1)))
				)
			)
		)
	)
	=>
	(assert (caballo ?f ?c))
)