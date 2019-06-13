;2.- Haz un programa que dado un conjunto de hechos de tipo datos 
;    con un número indefinido de valores, detecte e imprima 
;    aquellos tal que el primer valor sea par y menor o igual 
;    al último.

(deffacts hechos
  (datos 2 34 23 1)
  (datos 2 34 23 3)
  
)

(defrule regla 
?dh<-	(datos ?x&:(numberp ?x)&:(evenp ?x) $? ?y&:(<= ?x ?y)) 
	=> 
	(printout t ?dh "   " ?x crlf)
) 


;===================================================================
;3.- Haz un programa que dado un único hecho datos con un número 
;    indefinido de valores (ejemplo: (datos hola 1 3 nuevo 1 adios)), 
;    elimine todas las apariciones del valor 1.

(deffacts hechos
  (datos hola 1 3 nuevo 1 adios))
 )

(defrule regla
	?h <- (datos $?cabeza 1 $?cola)
	=>
	(retract ?h)
	(assert (datos $?cabeza $?cola))
)
;===================================================================


;4.- Haz un programa que detecte e imprima los hechos 
;   (vector <nombreVector> ...) que contengan los 
;    valores 3 y 4 en alguna posición, y que entre éstos 
;    haya un numero impar de valores. Se debe utilizar la 
;    función length$ (ver documentación).
;    ver https://www.csie.ntu.edu.tw/~sylee/courses/clips/rhs.htm

(deffacts hechos
  (vector v1 9 8  3 2 1 1 4 2 2 1 3 )
   (vector v2 9 8 3 1 2 1 1 4 2 2 1 3 1 2 3 4)
 )

(defrule regla

?dh <-	(vector $? 3 $?enMedio&:(oddp (length$ $?enMedio)) 4 $?)
	=>
	(printout t  ?dh crlf)
)
;===================================================================

;5.- Haz un programa que dado un único hecho datos con un número 
;    indefinido de valores, elimine los que no sean numéricos.

(deffacts hechos
  (datos hola 1 3 nuevo 1 adios)
 )

(defrule regla
	?h<-(datos $?cabeza ?x&~:(numberp ?x) $?cola)
	=>
	(retract ?h)
	(assert (datos $?cabeza $?cola))
)
;===================================================================


;	6.	Haz un programa que dado un conjunto de hechos 
;(vector <nombreVector> <val1> ... <valN>), detecte aquellos 
;hechos cuyos valores no están ordenados de menor a mayor e 
;imprima el mensaje “El vector <nombreVector> no está ordenado”. 
;Se entenderá que en la base de hechos no habrá dos hechos 
;vector con mismo nombre de vector.

(deffacts hechos
   (vector v1 1 3 5 )
   (vector v2 1 3 5 2)
 )

(defrule detectaNoOrdenado
	(vector ?nombre $? ?x ?y&:(> ?x ?y) $?)
	=>
	(printout t "El vector " ?nombre " no está ordenado" crlf )
)

;===================================================================
; 7.-	Haz un programa que dado un conjunto de hechos de la 
;     forma (dato 1), (dato 5), (dato verde)..., cree un único hecho 
;     (todos-los-datos ...) con todos los valores de los hechos 
;     anteriores.
     
(deffacts hechos
  (dato 1)
  (dato 3)
  (todos-los-datos)
)


(defrule uneValores
	?h1<-(dato ?x)
	?h2<-(todos-los-datos $?valores)
	=>
	(retract ?h1 ?h2)
	(assert (todos-los-datos ?x $?valores)))
	
;===================================================================
;8.- Haz un programa que dado un conjunto hechos 
     (vector <nombreVector> <val1> ... <valN>) 
     con valores numéricos, ordene sus valores de menor a mayor.
     
(deffacts hechos
  (vector v1 2 3 4)
  (vector v2 3 4 2 1 4 9)
)
    
(defrule ordena
	?h<-(vector ?nombre $?cabeza ?x ?y&:(> ?x ?y) $?cola)
	=>
	(retract ?h)
	(assert (vector ?nombre $?cabeza ?y ?x $?cola))
)
	
;===================================================================

	
	
	
	
; 9.- Haz un programa que resuelva el ejercicio 7 pero 
;     sin eliminar los hechos (dato 1), (dato 5), (dato verde).... 
;    (Se presupone un único hecho todos-los-datos)

(deffacts hechos
  (dato 1)
  (dato 3)
  
  (todos-los-datos)
)


(defrule uneValores
	(dato ?x)
	?h2 <-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?))
	=>
	(retract ?h2)
	(assert (todos-los-datos ?x $?valores)))
	
;===================================================================
	
	
; 10.-	Haz un programa que dado un conjunto de hechos de tipo dato 
        y un único valor numérico, imprima los valores numéricos 
        por pantalla de menor a mayor. Vigila que el programa 
        funciona correctamente incluso con la estrategia de ejecución
        de reglas Random.
         
(deffacts hechos
  (dato 1)
  (dato 3)
  (dato 9)
  (dato 5)
  (dato 4)
  (dato 0)
 
)

(defrule imprimeOrdenado
	?h<-(dato ?x)
	(not (dato ?y&:(< ?y ?x)))
	=>
	(retract ?h)
	(printout t ?x crlf))

;===================================================================

; 11.- Haz un programa que resuelva el ejercicio 9, pero que sólo 
       utilice los hechos con valores numéricos y los inserte de 
       forma ordenada (de menor a mayor) en el hecho todos-los-datos. 
       (Se presupone un único hecho todos-los-datos)
       
(deffacts hechos
  (dato 1)
  (dato 3)
  (dato verde)
  (dato 2)
  (todos-los-datos)
)

      
(defrule insertaOrdenado
	(dato ?x&:(numberp ?x))
	?h<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?))
	(not (and
		(dato ?y&:(numberp ?y)&:(< ?y ?x))
		(not (todos-los-datos $? ?y $?))))
	=>
	(retract ?h)
	(assert (todos-los-datos $?valores ?x))
)

;===================================================================
(defrule insertaOrdenadoConForall
	(dato ?x&:(numberp ?x))
	?h<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?))
	(forall (dato ?y&:(numberp ?y)&:(< ?y ?x))
		(todos-los-datos $? ?y $?))
	=>
	(retract ?h)
	(assert (todos-los-datos $?valores ?x)))

;===================================================================
; 12.- Haz un programa que calcule el factorial de un número, 
       de manera que ante un hecho (factorial 3), muestre por 
       pantalla el mensaje “El factorial de 3 es 6”.

(deffacts hechos
    (factorial 3)
 )

      
(deftemplate auxFactorial
	(slot pedido)
	(slot acumulado (default 1))
	(slot contador (default 1)))

(defrule empiezaFactorial
	(factorial ?x)
	(not (auxFactorial (pedido ?x)))
	=>
	(assert (auxFactorial (pedido ?x))))

(defrule avanzaFactorial
	?h<-(auxFactorial
		(pedido ?x)
		(acumulado ?y)
		(contador ?c&:(< ?c ?x)))
	=>
	(retract ?h)
	(assert (auxFactorial
			(pedido ?x)
			(acumulado (* ?y (+ ?c 1)))
			(contador (+ ?c 1)))))

(defrule imprimeFactorial
	(factorial ?x)
	(auxFactorial (pedido ?x) (contador ?x) (acumulado ?y))
	=>
	(printout t “El factorial de “ ?x “ es “ ?y “.“  crlf))
;===================================================================
;13.-	Una planta industrial tiene diez sensores identificados 
;	por un código numérico entre 1 y 10. Cada sensor puede 
;	encontrarse en un estado correcto o incorrecto. Escribe 
;	una plantilla que permita representar la información relativa 
;	a los sensores y un conjunto de reglas que imprima un mensaje 
;	de advertencia si tres o más sensores se encuentran en un 
;	estado incorrecto. Sólo debe mostrarse un mensaje de error 
;	aunque haya más de tres sensores en estado incorrecto.
	
(deftemplate sensor
	(slot codigo (type INTEGER) (range 1 10))
	(slot estado (allowed-values correcto incorrecto)))
(deffacts hechos
(sensor 
  (codigo 1)
  (estado incorrecto)
)
(sensor 
  (codigo 2)
  (estado incorrecto)
)
(sensor 
  (codigo 3)
  (estado incorrecto)
)
(sensor 
  (codigo 4)
  (estado incorrecto)
)
)


(defrule regla
	(exists
		(sensor (codigo ?x) (estado incorrecto))
		(sensor (codigo ?y&~?x) (estado incorrecto))
		(sensor (codigo ?z&~?y&~?x) (estado incorrecto))
	)
	=>
	(printout t "Tres o más sensores se encuentran en estado 			incorrecto" crlf)
)


;===========================================================
;14.- Escribe un programa para ayudar a una persona a decidir qué plantas 
;     podría plantar. La siguiente tabla indica las características de una
;     serie de plantas (tolerancia al frío, tolerancia a la sombra, 
;     tolerancia al clima seco...). La entrada al programa debe 
;     consistir en un conjunto de hechos 
;     (característica-deseada <característica>) que indiquen 
;     características que se desee que tenga una planta. 
;     El programa debe mostrar por pantalla el nombre de las plantas 
;     que cuenten con las características indicadas, aunque aparte de 
;     esas cuenten con otras características
 
(deftemplate planta 
    (slot nombre) 
    (multislot caracteristicas))

(deffacts plantas
	(planta (nombre hortensia) (caracteristicas sombra ciudad maceta cuidado_facil crece_rapido))

   (caracteristica-deseada sombra)
)

	
(defrule escogePlanta
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y)
		(planta (nombre ?x)
			(caracteristicas $? ?y $?)))
	=>
	(printout t “Puedes plantar una “ ?x crlf))

;=====================================================================

; 15.- Haz un programa en base a la información del ejercicio 
;      anterior, pero ahora se imprimirán sólo aquellas plantas 
;      que cumplan exactamente con todas las características 
;      deseadas (no puede contener otras características)

(defrule escogePlanta
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y)
		(planta (nombre ?x)
			(caracteristicas $? ?y $?)))
	(forall (planta (nombre ?x)
				(caracteristicas $? ?y $?))
			(caracteristica-deseada ?y))
	=>
	(printout t “Puedes plantar una “ ?x crlf))

;=====================================================================
;16.-	Complementa el ejercicio 8 para que también se detecten 
     los vectores que sí están ordenados. Es decir, sin modificar los 
     hechos ni crear hechos auxiliares, se debe imprimir un mensaje 
     por cada vector (vector <nombreVector> <val1> ... <valN>), 
     indicando si sus elementos están ordenados o no. 
     Se entenderá que en la base de hechos no habrá dos 
     hechos vector con mismo nombre de vector.

(deffacts hechos
   (vector v1 1 3 5 )
   (vector v2 1 3 5 2)
   (vector v3 1 3 5 7 2 3  )
   (vector v4 1 3 3 4 1 5 2)
   (vector v5 1 3 5 9)
   (vector v6 1 3 5 7)


 )
     
(defrule imprimeSiOrdenado
	(vector ?nombre $?)
	(forall (vector ?nombre $? ?x ?y $?)
		(test (>= ?y ?x)))
	=>
	(printout t “El vector " ?nombre “ está ordenado" crlf)
)


;=====================================================================
;17.	Haz un programa que dado un único hecho vector con un 
;    número indefinido de valores numéricos, imprima el valor que se 
;    sitúa justo en medio, o la media de los dos valores de 
;    en medio.

(deffacts hechos
   (vector v1 1 3 5 )
   (vector v2 1 3 5 2)
   (vector v3 1 3 5 7 2 3  )
   (vector v4 1 3 3 4 1 5 2)
   (vector v5 1 3 5 9)
   (vector v6 1 3 5 7)
 )

(defrule valorEnMedio
   (declare (salience 2))
	(vector ?nombre $?cabeza ?x
		$?cola&:(= (length$ $?cabeza) (length$ $?cola)))
	=>
	(printout t "El valor de en medio de " ?nombre " es " ?x crlf))

(defrule mediaDeEnMedio
	(vector ?nombre $?cabeza ?x ?y
		$?cola&:(= (length$ $?cabeza) (length$ $?cola)))
	=>
	(printout t "La media de en medio de " ?nombre " es "
		(/ (+ ?x ?y) 2) crlf))



;=====================================================================
;18.-	Haz un programa que dado un único hecho vector, detecte si sus 
;    valores se repiten de forma simétrica. Siempre que la salida sea 
;    correcta, puedes modificar el vector o utilizar hechos auxiliares.
;    Lo siguiente es una posible solución entre muchas posibilidades
(deffacts hechos
 (vector v1 1 2 2 1)
 (vector v2 1 3 3 1 4)
 (vector v3 1 2 4 2 1)
)


(defrule detectaNoSimetrico
	(vector ?nombre ?x $? ?y&~?x)
	=>
	(printout t "El vector " ?nombre " no es simétrico" crlf))

(defrule continuaSimetrico
	?h<-(vector ?nombre ?x $?medio ?x)
	=>
	(retract ?h)
	(assert (vector ?nombre $?medio)))

(defrule simetricoImpar
	(vector ?nombre ?)
	=>
	(printout t "El vector " ?nombre " es simétrico impar" crlf))

(defrule simetricoPar
	(vector ?nombre)
	=>
	(printout t "El vector " ?nombre " es simétrico par" crlf))




;=====================================================================

(defrule detectaSimetrico
	(vector ?nombre $?valores)
	(forall (vector ?nombre $?cabeza ?x $?medio ?y
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
			(test (eq ?x ?y)))
	=>
	(printout t “El vector “ ?nombre “ es simétrico” crlf))

(defrule detectaNoSimetrico
	(vector ?nombre $?cabeza ?x $?medio ?y&~?x
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
	=>
	(printout t “El vector “ ?nombre “ no es simétrico” crlf))
