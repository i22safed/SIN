(deftemplate alfabeto
	(slot letra)
	(slot posicion)
)
(deffacts hechos 
	(alfabeto (letra a) (posicion 1))
	(alfabeto (letra b) (posicion 2))
	(alfabeto (letra c) (posicion 3))
	(alfabeto (letra d) (posicion 4))
	(alfabeto (letra e) (posicion 5))
	(alfabeto (letra f) (posicion 6))
	(alfabeto (letra g) (posicion 7))
	(alfabeto (letra h) (posicion 8))
	(alfabeto (letra i) (posicion 9))
	(alfabeto (letra j) (posicion 10))
	(alfabeto (letra k) (posicion 11))
	(alfabeto (letra l) (posicion 12))
	(alfabeto (letra m) (posicion 13))
	(alfabeto (letra n) (posicion 14))
	(alfabeto (letra o) (posicion 15))
	(alfabeto (letra p) (posicion 16))
	(alfabeto (letra q) (posicion 17))
	(alfabeto (letra r) (posicion 18))
	(alfabeto (letra s) (posicion 19))
	(alfabeto (letra t) (posicion 20))
	(alfabeto (letra u) (posicion 21))
	(alfabeto (letra v) (posicion 22))
	(alfabeto (letra w) (posicion 23))
	(alfabeto (letra x) (posicion 24))
	(alfabeto (letra y) (posicion 25))
	(alfabeto (letra z) (posicion 26))
	(mensaje pasa casa 8 -5 1 53 19 "qué tal" 16 83 1 hola 19 1 4 15 c 78 12 3.4 1 tres 16 ocho 18 viene 21 5 2 1 "!")
	

)

(defrule regla1
	
	?h1<-(mensaje $?del ?x&~:(integerp ?x)|:(< ?x 1)|:(> ?x 26) $?det)
	=>
	(retract ?h1)
	(assert (mensaje $?del $?det))
	
)
(defrule regla2

	(mensaje $?datos)
	=>
	(assert (mensaje-filtrado $?datos))
	(printout t $?datos : (length$ $?datos) crlf)
)

(defrule regla3;esta regla es la que no se ejecuta

	?h1<-(mensaje-filtrado $?del ?p $?det)
	(alfabeto (letra ?l) (posicion ?p))
	=>
	(retract ?h1)
	(assert (mensaje-filtrado $?del ?l $?det))
)

(defrule regla4

	(mensaje-filtrado $?mensaje)
	=>
	(printout t $?mensaje crlf)
)
