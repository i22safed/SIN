;4.- Haz un programa que detecte e imprima los hechos
;   (vector <nombreVector> ...) que contengan los
;    valores 3 y 4 en alguna posición, y que entre éstos
;    haya un numero impar de valores. Se debe utilizar la
;    función length$ (ver documentación).
;    ver https://www.csie.ntu.edu.tw/~sylee/courses/clips/rhs.htm


(deffacts hechos
   (vector v1 9 8 3 2 1 1 4 2 2 1 3)
   (vector v2 9 8 3 1 2 1 1 4 2 2 1 3 1 2 3 4))

(defrule detecta-cosas-tochas

	?h<-(vector $? 3 $?medio&:(oddp (length$ $?medio)) 4 $?)
	=>
	(printout t ?h $?medio crlf)
)
