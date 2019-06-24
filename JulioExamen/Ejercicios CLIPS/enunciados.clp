; 2.- Haz un programa que dado un conjunto de hechos de tipo datos
;    con un numero indefinido de valores, detecte e imprima
;    aquellos tal que el primer valor sea par y menor o igual
;    al ultimo.
;===================================================================

(deffacts hechos 
	(datos 3 5 6 7 2 5)
	(datos 5 5 10 7 30 1 2 8 2 5)
	(datos 10 20 7 50)
)

(defrule parmenorigual

	(datos ?primero&:(evenp ?primero) $?medio ?ultimo&:(<= ?primero ?ultimo))		
=>
	(printout t "El hecho que cumple la condicion es:" ?primero " " $?medio " " ?ultimo crlf)		
)

;===================================================================
; 3.- Haz un programa que dado un unico hecho datos con un numero
;    indefinido de valores (ejemplo: (datos hola 1 3 nuevo 1 adios)),
;    elimine todas las apariciones del valor 1.
;===================================================================

(deffacts hecho 
	(datos hola 1 3 nuevo 1 adios)
) 

(defrule eliminar-unos 

	?h1<-(datos $?principio 1 $?final)	; Buscamos los 1's en el hecho
=>
	(retract ?h1)				; Retractamos el hecho  
	(assert (datos $?principio $?final))	; Para poder afirmarlo con el 1  
)

;===================================================================
;4.- Haz un programa que detecte e imprima los hechos
;   (vector <nombreVector> ...) que contengan los
;    valores 3 y 4 en alguna posicion, y que entre estos
;    haya un numero impar de valores. Se debe utilizar la
;    funcion length$ (ver documentacion).
;    ver https://www.csie.ntu.edu.tw/~sylee/courses/clips/rhs.htm
;===================================================================

(deffacts hechos 
	(vector v1 1 2 4 5 6)
	(vector v2 6 3 5 4 2 1 0)
	(vector v3 10 8 3 7 4 9 2)
)

(defrule detecta-vector
	(vector ?nombre $?principio 3 $?medio&:(oddp (length$ $?medio)) 4 $?final)
=> 
	(printout t "El vector que cumple la condicion es: " ?nombre crlf)
)




;===================================================================
; 5.- Haz un programa que dado un unico hecho datos con un numero
;   indefinido de valores, elimine los que no sean numericos.
;===================================================================

(deffacts hechos 
	(datos pepe "Juan" 3 verde 8 10)  
)

(defrule elimina-numeros

	; Empareja con cada uno de los elementos del hecho 
	; Si encuentra alguno que no es numero pues metemos 
	; el principio y el final 

	?h1<-(datos $?principio ?notnumber&~:(numberp ?notnumber) $?final)
=> 
	(retract ?h1)
	(assert ( datos $?principio $?final))
)


;===================================================================
; 6.- Haz un programa que dado un conjunto de hechos
;   (vector <nombreVector> <val1> ... <valN>), detecte aquellos
;   hechos cuyos valores no esten ordenados de menor a mayor e
;   imprima el mensaje "El vector <nombreVector> no esta ordenado".
;   Se entendera que en la base de hechos no habria dos hechos
;   vector con mismo nombre de vector.
;===================================================================

; ----------------------------------------------------------------------
; HACER ESTE PERO QUE MUESTRE TANTO EL QUE ESTÁ ORDENADO COMO EL QUE NO 
; ----------------------------------------------------------------------

(deffacts hechos 
	(vector v1 1 2 4 5 10 20)
	(vector v2 4 2 0 5 1 100)
	(vector v3 10 22 4 1 20)
	(vector v4 1 4 4 53 10 20)
	(vector v5 24 2 4 5 10 20)
) 

(defrule mostrar-ordenados 

	; Condicion: con que un elemento X (elemento actual) sea
	; mayor que un elemento Y (elemento siguiente) podemos 
	; determinar que el vector no está ordenado
 
	?h1<-(vector ?nombre $?cabesa ?x ?y&:(> ?x ?y) $?final)
=>
	(printout t "El vector " ?nombre " no está ordenado" crlf)  
	(retract ?h1)
) 


;===================================================================
; 7.- Haz un programa que dado un conjunto de hechos de la
;   forma (dato 1), (dato 5), (dato verde)..., cree un unico hecho
;   (todos-los-datos ...) con todos los valores de los hechos
;   anteriores.
;===================================================================

(deffacts hechos 
	(dato 1)
	(dato 5)
	(dato verde)
	(dato turbocaca)
	(todos-los-datos)
)

(defrule unir-hechos 
	?h0<-(dato ?valor) ; Emparejamos con los hechos del deffacts 
	?h1<-(todos-los-datos $?datos) 	; Emparejamos el hecho que almacenará 
					; el resto de hechos 
=>
	;(retract ?h0) 	; Retractamos los hechos individuales
			; ya que si no entraria en bucle 
	
	(retract ?h1)	; Retractamos el hecho final para volver a afirmarlo con 
			; El hecho individual emparejado anteriormente 

	(assert(todos-los-datos $?datos ?valor))
)


;===================================================================
; 8.- Haz un programa que dado un conjunto hechos
;   (vector <nombreVector> <val1> ... <valN>)
;   con valores numericos, ordene sus valores de menor a mayor.
;===================================================================

(deffacts hechos 
	(vector v1 1 2 4 10 5 6 6)
)
(defrule ordena-vector-menor-mayor	
	?h1<-(vector ?nombre $?cabesa ?x ?y&:(> ?x ?y) $?cola)
=>
	(retract ?h1)
	(assert(vector ?nombre $?cabesa ?y ?x ?cola))
)

; EXTRA -> Para ordenar de mayor a menor 

(defrule ordena-vector-menor-mayor	
	?h1<-(vector ?nombre $?cabesa ?x ?y&:(< ?x ?y) $?cola)
=>
	(retract ?h1)
	(assert(vector ?nombre $?cabesa ?y ?x ?cola))
)

;===================================================================
; 9.- Haz un programa que resuelva el ejercicio 7 pero
;   sin eliminar los hechos (dato 1), (dato 5), (dato verde)....
;   (Se presupone un unico hecho todos-los-datos)
;===================================================================

(deffacts hechos 
	(dato 1)
	(dato 5)
	(dato verde)
	(dato turbocaca)
	(todos-los-datos)
)

(defrule unir-hechos 
	(dato ?valor)
	?h1<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?valor $?)) 	; Comprobamos que en el hecho final 
						; no este en el dato a introducir  
=>	
	(retract ?h1)	; Retractamos el hecho final para volver a afirmarlo con 
			; El hecho individual emparejado anteriormente 
	(assert(todos-los-datos $?valores ?valor))
)


;===================================================================
; 10.- Haz un programa que dado un conjunto de hechos de tipo dato
;   y un unico valor numerico, imprima los valores numericos
;   por pantalla de menor a mayor. Vigila que el programa
;   funciona correctamente incluso con la estrategia de ejecucion
;   de reglas Random.
;===================================================================

(deffacts hechos 
	(dato 1)
	(dato 10)
	(dato 4)
	(dato 3) 
	(dato 6)
)

(defrule imprime-ordenado 
	?h1<-(dato ?x)
	(not (dato ?y&:(> ?x ?y)))
=> 
	(retract ?h1)
	(printout t ?x " ")
)

;===================================================================
; 11.- Haz un programa que resuelva el ejercicio 9, pero que solo
;   utilice los hechos con valores numericos y los inserte de
;   forma ordenada (de menor a mayor) en el hecho todos-los-datos.
;   (Se presupone un unico hecho todos-los-datos)
;===================================================================

(deffacts hechos 
	(dato 1)
	(dato 5)
	(dato verde)
	(dato turbocaca)
	(dato 2)
	(dato 10)
	(todos-los-datos)
)

(defrule unir-hechos 
	(dato ?x&:(numberp ?x))
	?h1<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?))	; Aqui comprobamos que no insertemos 
						; un elemento ya insertado  
		
	; Esquema logico -> ¬((y < x) and ¬(Estar en el hecho))

	(not (and
		(dato ?y&:(numberp ?y)&:(< ?y ?x))
		(not (todos-los-datos $? ?y $?))))

=>	
	(retract ?h1)	
	(assert(todos-los-datos $?valores ?x))
)


;===================================================================
;
; 12.- Haz un programa que calcule el factorial de un numero,
;   de manera que ante un hecho (factorial 3), muestre por
;   pantalla el mensaje "El factorial de 3 es 6".
;
;===================================================================

; CALCULAR FACTORIAL SIN "DADO EL HECHO FACTORIAL 3" ---------------

(deffacts hechos 
	(factorial 6)
	(res 1)
)

(defrule calcularFactorial 
	?h1<-(num ?x&:(>= ?x 1))
	?h2<-(res ?y)	
=> 
	(retract ?h1)
	(retract ?h2)
	(assert (factorial (- ?x 1)))
	(assert (res (* ?y ?x)))
)

; CALCULAR FACTORIAL CON "DADO EL HECHO FACTORIAL 3" ---------------

(deffacts hechos 
	(factorial 4)
)
(deftemplate facto
	(slot numero)
	(slot contador (default 1))
	(slot acc (default 1))
)
(defrule arranca
	(factorial ?x)
=> 
	(assert (facto (numero ?x)(contador 1)(acc 1)))
)

(defrule proceso-factorial 
	?h1<-(facto (numero ?n)(contador ?c&:(<= ?c ?n))(acc ?a))
=> 
	(retract ?h1)
	(assert (facto (numero ?n)(contador (+ ?c 1)) (acc (* ?a ?c))))
)

(defrule mostrar-factorial 
	(facto (numero ?n)(contador ?c&:(= (+ ?n 1) ?c))(acc ?a))
=> 
	(printout t "El factorial de " ?n " es: " ?a crlf)
)

;===================================================================
;
; 13.-	Una planta industrial tiene diez sensores identificados
;   por un codigo numerico entre 1 y 10. Cada sensor puede
;   encontrarse en un estado correcto o incorrecto. Escribe
;   una plantilla que permita representar la informacion relativa
;   a los sensores y un conjunto de reglas que imprima un mensaje
;   de advertencia si tres o mas sensores se encuentran en un
;   estado incorrecto. Solo debe mostrarse un mensaje de error
;   aunque haya mas de tres sensores en estado incorrecto.
;
;===================================================================

(deftemplate sensor
	(slot codigo (type INTEGER)(range 1 10))
	(slot estado (allowed-values correcto incorrecto))
)

(deffacts hechos 
	(sensor (codigo 1)(estado incorrecto))
	(sensor (codigo 2)(estado incorrecto))
	(sensor (codigo 3)(estado incorrecto))
)

(defrule chequeoSensores

	(exists 
		(sensor (codigo ?x)(estado incorrecto))
		(sensor (codigo ?y&~?x)(estado incorrecto))
		(sensor (codigo ?z&~?y&~?x)(estado incorrecto))
	)
=>
	(printout t "Hay 3 sensores o mas funcionando incorrectamente" crlf)
)

;=====================================================================
; 14.- Escribe un programa para ayudar a una persona a decidir que plantas
;   podria plantar. La siguiente tabla indica las caracteristicas de una
;   serie de plantas (tolerancia al frio, tolerancia a la sombra,
;   tolerancia al clima seco...). La entrada al programa debe
;   consistir en un conjunto de hechos
;   (caracteristica-deseada <caracteristica>) que indiquen
;   características que se desee que tenga una planta.
;   El programa debe mostrar por pantalla el nombre de las plantas
;   que cuenten con las caracteristicas indicadas, aunque aparte de
;   esas cuenten con otras caracteristicas
;=====================================================================
; 15.- Haz un programa en base a la informacion del ejercicio
;   anterior, pero ahora se imprimiran solo aquellas plantas
;   que cumplan exactamente con todas las caracteristicas
;   deseadas (no puede contener otras caracteristicas)
;=====================================================================

	14 y 15 IRRELEVANTES, HACERLOS CUANDO SOBRE TIEMPO 

;=====================================================================
;
; 16.- Complementa el ejercicio 8 para que tambien se detecten
;   los vectores que si esten ordenados. Es decir, sin modificar los
;   hechos ni crear hechos auxiliares, se debe imprimir un mensaje
;   por cada vector (vector <nombreVector> <val1> ... <valN>),
;   indicando si sus elementos estan ordenados o no.
;   Se entendera que en la base de hechos no habria dos
;   hechos vector con mismo nombre de vector.
;
;=====================================================================

(deffacts hechos 
	(vector v1 1 2 3 4 5 6)
	(vector v2 1 2 3 4 10 6)
	(vector v3 1 2 5 8)
	(vector v4 20 2 3 4 5 6)
	(vector v5 7 20 31 46 51)
)

(defrule vOrdenado
	(vector ?nombre $? ?x ?y $?)
	(forall (vector ?nombe $? ?x ?y $?)
		(test (> ?x ?y))
	)

=> 
	(printout t "El vector " ?nombre " esta desordenado" crlf)	
)


;=====================================================================
; 17.- Haz un programa que dado un unico hecho vector con un
;    numero indefinido de valores numericos, imprima el valor que se
;    situa justo en medio, o la media de los dos valores de
;    en medio.
;=====================================================================

(deffacts hechos 
	(vector v1 1 2 3 4 5 6)
	(vector v2 1 2 3 4 10 6)
	(vector v3 1 2 5 8)
	(vector v4 20 2 3 4 5 6)
	(vector v5 7 20 31 46 51)
)
	
(defrule imprimeMedio 
	(vector ?nombre $?cabesa ?x $?cola&:(= (length$ $?cabesa) (length$ $?cola)))
=> 
	(printout t "El valor del medio del vector " ?nombre " es " ?x crlf)	
)

(defrule imprimeMedia 
	(vector ?nombre $?cabesa ?x ?y $?cola&:(= (length$ $?cabesa) (length$ $?cola)))
=> 
	(printout t "El valor medio del vector " ?nombre " es " (/ (+ ?x ?y) 2) crlf)	
)


;=====================================================================
;
; 18.- Haz un programa que dado un unico hecho vector, detecte si sus
;    valores se repiten de forma simetrica. Siempre que la salida sea
;    correcta, puedes modificar el vector o utilizar hechos auxiliares.
;    Lo siguiente es una posible solucion entre muchas posibilidades
;
;=====================================================================
; 
; EJERCICIOS EXAMEN 
; 
;=====================================================================
;
; E1.- Haz un programa que dado un conjunto de hechos
;   (vector <nombreVector> <val1> ... <valN>), indique que vector 
;   está ordenado de mayor a menor y cual no. Imprimiendo el mensaje 
;   "El vector <nombreVector> no/esta ordenado". Se entendera que 
;   en la base de hechos no habria dos hechos vector con mismo nombre 
;   de vector.
;
;=====================================================================


(deffacts hechos 
	(vector v1 1 2 4 5 10 20)
	(vector v2 4 5 6 100)
	(vector v3 10 22 4 1 20)
	(vector v4 1 4 4 53 10 20)
	(vector v5 220)
) 


(defrule no-ordenado
	(vector ?nombre $?)
	(exists(vector ?nombre $? ?x ?y&:(> ?x ?y) $?))
=>
 	(printout t "El vector " ?nombre " no esta ordenado" crlf)
)

(defrule ordenado
	(vector ?nombre $?)
 	(forall (vector ?nombre $? ?x ?y $?)
	  (test(< ?x ?y)))
=>
	(printout t "El vector " ?nombre " esta ordenado" crlf)
)

;=====================================================================
;
; E2.- Dado un conjunto de hechos numericos, realizar el productorio de 
;   dichos numeros y almacenarlo en un hecho. 
;
;=====================================================================
;
; E3.- Dado un conjunto de hechos agruparlos todos en uno sin que se
;   sin que se repitan hechos. 
;
;===================================================================== 
;
; E4.- Separar una cadena en palabras y quedarte con las terceras palabras 
;   de cada cadena 
;
;===================================================================== 
;
; E5.- Haz un programa que calcule el factorial de un numero,
;   de manera que ante un hecho (factorial 3), muestre por
;   pantalla el mensaje "El factorial de 3 es 6". 
;
;===================================================================== 
; 
; E6.- Unir todos los datos sin que se repitan en un solo hecho 
; 
;===================================================================== 

(deffacts hechos 
	(datos1  5 7 9)
	(datos2  6 8 9 5)
	(todos-los-datos)
)

(defrule inserta-hechos
	(or 
		(datos1 $? ?x $?)	
		(datos2 $? ?x $?)	
	)
	(not (todos-los-datos $? ?x $?))
	?h1<-(todos-los-datos $?valores)
=> 
	(retract ?h1)
	(assert(todos-los-datos $?valores ?x))
)

;===================================================================== 
; 
; E7.- Dado un conjunto de hechos imprimir los hechos de menor a mayor 
; 
;===================================================================== 

(deffacts los-datos 
	(dato 6) 
	(dato 1.3) 
	(dato 2) 
	(dato -1) 
	(dato 5.3) 
) 

(defrule imprime-ordenados 

	?h1<-(dato ?x)
	(not (dato ?y&:(< ?x ?y)))

=> 	
	(retract ?h1)
	(printout t ?x crlf)


)


;===================================================================== 
; 
; E7.- Meter en un conjunto todos-los-hechos, los datos numericos de
; 	de forma ordenada
; 
;===================================================================== 

(deffacts los-datos 
	(dato 6) 
	(dato verde) 
	(dato 2) 
	(dato cuatro) 
	(dato 5) 
	(todos-los-datos)
) 

(defrule inserta-ordenados

	(datos ?x&:(numberp ?x))
	?h1<-(todos-los-datos $?valores)
	(not(todos-los-datos $? ?x $?))
	(not (and 
		(datos ?y&:(numberp ?y)&:(< ?y ?x))
		(not (todos-los-datos $? ?y $?)))
	)

=> 	
	(retract ?h1)
	(assert (todos-los-datos $?valores ?x))
)