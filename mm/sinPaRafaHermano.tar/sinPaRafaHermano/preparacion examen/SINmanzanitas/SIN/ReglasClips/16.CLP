;ejercicio 16

(deftemplate fecha
	(slot dia (type INTEGER)(range 1 31))
	(slot mes(type SYMBOL)(allowed-symbols enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre))
	(slot anyo(type INTEGER)(range 1900 2100))
)

(deffacts hechos
	(fecha(dia 12)(mes febrero)(anyo 2005));correcto
)

(defrule diaCorrecto
	(fecha(dia ?dia)(mes ?mes)(anyo ?anyo))
	
	=>
	(printout t "fecha introducida: "?dia"/"?mes"/"?anyo crlf)
)

(defrule bisiesto
	(fecha(dia ?dia)(mes ?mes)(anyo ?anyo))
	(and
		(test(= (mod ?anyo 4) 0))
		(or	
		(not(test(= (mod ?anyo 100) 0)))
		(test(= (mod ?anyo 400) 0))
	)
	)
		
	=>
	(printout t "sabiendo que: ", crlf )
	(printout t "p: es divisible entre 4 q: es divisble entre 100 r: es divisible entre 400" crlf)
	(printout t "se aplica la expresion p^(no q v r)" crlf)
	(printout t "fecha introducida: "?dia"/"?mes"/"?anyo" es bisiesto" crlf)
)

(defrule Nobisiesto
	(fecha(dia ?dia)(mes ?mes)(anyo ?anyo))
	(not
		(and
			(test(= (mod ?anyo 4) 0))
			(or	
				(not(test(= (mod ?anyo 100) 0)))
				(test(= (mod ?anyo 400) 0))
			)
		)
	)
	=>
	(printout t "Año No bisiesto" crlf)

)



	