
;==========================================================================================================================================

;2. Haz un programa que dado un conjunto de hechos de tipo datos 
;con un numero indefinido de valores, detecte e imprima aquellos tal 
;que el primer valor sea par y menor o igual al último.

(deffacts h

   (datos 4 3  5 6 7 8)
   (datos 1 3  5 6 7 8)
   (datos 4 3  5 6 7 2))

(defrule regla 

	(datos ?x&:(numberp ?x)&:(evenp ?x) $? ?y&:(<= ?x ?y)) 
=> 
	
	(printout t ?x  "es el numero x y " ?y "es el numero ultimo" crlf)) 

;==========================================================================================================================================

;3. Haz un programa que dado un único hecho datos con un número 
;indefinido de valores (ejemplo: (datos hola 1 3 nuevo 1 adios)), 
;elimine todas las apariciones del valor 1.

(deffacts h
 
	(datos hola 1 3 nuevo 1 adios))

(defrule regla
	
	?h <- (datos $?cabeza 1 $?cola)
=>

	(retract ?h)
	(assert (datos $?cabeza $?cola)))

;==========================================================================================================================================
	
;4. Haz un programa que detecte e imprima los hechos
; (vector <nombreVector> ...) que contengan los valores 
; 3 y 4 en alguna posición, y que entre éstos haya un numero 
; impar de valores. Se debe utilizar la función length$ 
 (ver documentación).
 
 
(deffacts h

	(vector v1 1 4 9 3 5 6 7 4 5 4 5 5)
	(vector v2 1 4 9 3 5 6 7 9 4 5 5 5)

)

(defrule regla

	(vector ?v $? 3 $?enMedio&:(oddp (length$ $?enMedio)) 4 $?)

=>

	(printout t ?v ..... crlf))

;==========================================================================================================================================

;5. Haz un programa que dado un único hecho datos con un número 
;indefinido de valores, elimine los que no sean numéricos.

(deffacts h

	(datos 1 4 9 3 casa 5 6 7 jardin 4 5 5 5))

(defrule regla
	
	?h<-(datos $?cabeza ?x&~:(numberp ?x) $?cola)
=>

	(retract ?h)
	(assert (datos $?cabeza $?cola)))

;==========================================================================================================================================
	
;6. Haz un programa que dado un conjunto de hechos 
;(vector <nombreVector> <val1> ... <valN>), 
;detecte aquellos hechos cuyos valores no están ordenados 
;de menor a mayor e imprima el mensaje 
;“El vector <nombreVector> no está ordenado”. Se entenderá que en la base de hechos no habrá dos hechos vector con mismo nombre de vector.

(deffacts h
	
	(vector v1 1 4 9 )
	(vector v2 1 4 6  8 7 ))

(defrule detectaNoOrdenado

	(vector ?nombre $? ?x ?y&:(> ?x ?y) $?)
=>
	
	(printout t "El vector " ?nombre " no está ordenado" crlf))

;==========================================================================================================================================
	
;9. Haz un programa que dado un conjunto de hechos de la forma
; (dato 1), (dato 5), (dato verde)..., cree un único 
; hecho (todos-los-datos ...) con todos los valores numéricos de 
; los hechos anteriores.

(deffacts h

  (dato 1)
  (dato 5)
  (dato 18)
  (dato verde)
  (todos-los-datos))

(defrule uneValores

	?h1<-(dato ?x&:(numberp ?x));Captamos en ?x cada valor numérico
	?h2<-(todos-los-datos $?valores)

=>

	(retract ?h1 ?h2)
	(assert (todos-los-datos ?x $?valores)))
	
	
;==========================================================================================================================================
	
;	10.	Haz un programa que dado un conjunto de hechos de 
;    tipo dato y un único valor numérico, imprima los valores 
;    numéricos por pantalla de menor a mayor. 
;    Vigila que el programa funciona correctamente incluso 
;    con la estrategia de ejecución de reglas Random.

(deffacts h
  (dato 1)
  (dato 5)
  (dato 3)
  (todos-los-datos)
)

(defrule imprimeOrdenado
	?h<-(dato ?x); captamos un ?x
	(not (dato ?y&:(< ?y ?x))); No haya un ?y menor x
	=>
	(retract ?h);eliminamos el hecho que contiene el menor ?x
	(printout t ?x crlf))


;==========================================================================================================================================

; Ojo ver
; 9.Haz un programa que resuelva el ejercicio la ordenacion de datos, pero que solo 
;  utilice los hechos con valores num�ricos y los inserte de forma 
;  ordenada (de menor a mayor) en el hecho todos-los-datos. 
; (Se presupone un unico hecho todos-los-datos)

(deffacts h

  (dato 1)
  (dato 5)
  (dato 3)
  (dato 4)
  (todos-los-datos))


(defrule insertaOrdenado

	(dato ?x) ; Captamos un campo de los hechos (dato ..) en la variable ?x
	?h<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?)); ?x no debe estar ya en todos los valores
	(not (and ; no puede ocurrir que haya un ?y menor que ?x 
		(dato ?y&:(< ?y ?x))
		(not (todos-los-datos $? ?y $?));?y no puede estar ya en todos...
	)
	)
	
=>
	
	(retract ?h)
	(assert (todos-los-datos $?valores ?x)))

; Resuelto con for-all

(deffacts h

  (dato 5)
  (dato 1)
  (dato 3)
  (dato 4)
  (todos-los-datos))


(defrule insertaOrdenadoConForall
	(dato ?x) ; Captamos un campo de los hechos (dato ..) en la variable ?x
	          ; Este ?x sera valido si 
	?h<-(todos-los-datos $?valores)
	(not (todos-los-datos $? ?x $?)) ; ?x no puede estar ya ordenado
	(forall (dato ?y&:(< ?y ?x)) ; Para todo ?y menor ?x, ?y debe de estar ya en todos-los-datos
		     (todos-los-datos $? ?y $?)  
	)

=>
	
	(retract ?h)
	(assert (todos-los-datos $?valores ?x)))
	
;==========================================================================================================================================

;Complementa el ejercicio 8 para que tambien se detecten 
;los vectores que si� est�n ordenados. Es decir, sin modificar 
;los hechos ni crear hechos auxiliares, se debe imprimir un mensaje 
;por cada vector (vector <nombreVector> <val1> ... <valN>), indicando 
;si sus elementos están ordenados o no. Se entenderá que en la base 
;de hechos no habrá dos hechos vector con mismo nombre de vector.


(deffacts h
(vector v1 1 4 9 )
(vector v2 1 4 6  8 7 )
(vector v3 1 4 6  8 9 )
(vector v4 4 1))


(defrule imprimeSiOrdenado
	(vector ?nombre $?)
	(forall (vector ?nombre $? ?x ?y $?)
		(test (>= ?y ?x)))
	=>
(printout t "El vector   " ?nombre " esta� ordenado" crlf))

;==========================================================================================================================================

;    14. Una planta industrial tiene diez sensores identificados 
;    por un codigo numerico entre 1 y 10. Cada sensor puede encontrarse 
;    en un estado correcto o incorrecto. Escribe una plantilla que 
;    permita representar la información relativa a los sensores y un 
;    conjunto de reglas que imprima un mensaje de advertencia si 
;    tres o más sensores se encuentran en un estado incorrecto. 
;    Solo debe mostrarse un mensaje de error aunque haya más de tres 
;    sensores en estado incorrecto.

(deftemplate sensor
	
	(slot codigo (type INTEGER) (range 1 10))
	(slot estado (allowed-values correcto incorrecto)))

(deffacts h

   (sensor (codigo 1) (estado incorrecto))
   (sensor (codigo 2) (estado incorrecto))
   (sensor (codigo 3) (estado correcto))
   (sensor (codigo 4) (estado correcto))
   (sensor (codigo 5) (estado correcto))
   (sensor (codigo 6) (estado correcto))
   (sensor (codigo 7) (estado incorrecto))
   (sensor (codigo 8) (estado correcto))
   (sensor (codigo 9) (estado correcto))

)
   
(defrule regla
	(exists
		(sensor (codigo ?x) (estado incorrecto))
		(sensor (codigo ?y&~?x) (estado incorrecto))
		(sensor (codigo ?z&~?y&~?x) (estado incorrecto))
	)

=>

	(printout t "Tres o mas sensores se encuentran en estado incorrecto" crlf))

;==========================================================================================================================================


; 15.- Escribe un programa para ayudar a una persona a decidir que plantas
; podria plantar. La siguiente tabla indica las caracterasticas 
; de una serie de plantas (tolerancia al frio, tolerancia a la sombra, 
; tolerancia al clima seco...). La entrada al programa debe 
; consistir en un conjunto de hechos 
; (caracterastica-deseada <caracterastica>) 
; que indiquen caracterasticas que se desee que tenga una planta. 
; El programa debe mostrar por pantalla el nombre de 
; las plantas que cuenten con las caracterasticas indicadas, 
; aunque aparte de esas cuenten con otras características

(deftemplate planta (slot nombre) (multislot caracteristicas))
(deffacts plantas
	
	(planta 
	     (nombre hortensia) 
	     (caracteristicas sombra ciudad maceta cuidado_facil crece_rapido))
	(planta  
	    (nombre  adelfa     )
	    (caracteristicas  ciudad maceta cuidado-facil crece-rapido))
	(planta  
	    (nombre   laurel    )
	    (caracteristicas frio sombra sequedad suelo-humedo ciudad cuidad-facil crece-rapido ))
	(planta  
	    (nombre   madreselva    )
	    (caracteristicas ciudad maceta cuidado-facil crece-rapido ))
	
	(planta  
	    (nombre gardenia      )
	    (caracteristicas sombra suelo-acido maceta ))
	(planta  
	    (nombre   enebro    )
	    (caracteristicas  frio sequedad suelo-acido ciudad cuidado-facil))
	(planta  
	    (nombre escaramujo       )
	    (caracteristicas frio sombra suelo-humedo ciudad cuidado-facil ))
	(planta  
	    (nombre  aucuba     )
	    (caracteristicas sombra sequedad maceta cuidado-facil ))
	(planta  
	    (nombre azalea      )
	    (caracteristicas sombra suelo-humedo suelo-acido maceta)))

(deffacts h1	    
	(caracteristica-deseada       sombra)
	(caracteristica-deseada       maceta)
	(caracteristica-deseada       suelo-acido)
	(caracteristica-deseada       suelo-humedo )
	;(caracteristica-deseada       a ))
	  
(defrule escogePlanta
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y);Toda caracteristica deseada
		(planta (nombre ?x)
		(caracteristicas $? ?y $?)));Se encuentra en las caracteristicas de la planta
	
=>
	
	(printout t "Puedes plantar una " ?x crlf))
		
;==========================================================================================================================================

;16. Haz un programa en base a la información del ejercicio anterior, 
; pero ahora se imprimirán sólo aquellas plantas que 
; cumplan exactamente con todas las características deseadas 
; (no puede contener otras características)

(defrule escogePlanta
	
	(planta (nombre ?x))
	(forall (caracteristica-deseada ?y) ;Toda carcateristica deseada debe de estar en las características
	                                    ; de la planta
		(planta (nombre ?x)
		(caracteristicas $? ?y $?)))
			     
	(forall (planta (nombre ?x)   ; Además para esa planta
		   (caracteristicas $? ?y $?)) ; Todas sus características
		   (caracteristica-deseada ?y)) ; deben de estar en la característica deseada. 
=>
	
	(printout t “Puedes plantar una “ ?x crlf))
	
;==========================================================================================================================================
	
;  19. Haz un programa que dado un único hecho vector con un número 
;  indefinido de valores numéricos, imprima el valor que se sitúa 
;  justo en medio, o la media de los dos valores de en medio.

(deffacts hechos

  (vector v1 1 3 5 6)
  (vector v2 1 3 5 6 7)

)

(defrule valorEnMedio

	(vector ?nombre $?cabeza ?x $?cola&:(= (length$ $?cabeza) (length$ $?cola)))

=>

	(printout t  "El valor de en medio de " ?nombre " es " ?x crlf))

(defrule mediaDeEnMedio
	
	(vector ?nombre $?cabeza ?x ?y $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
	
=>
	
	(printout t "La media de en medio de " ?nombre " es "
		(/ (+ ?x ?y) 2) crlf))

;==========================================================================================================================================

;  1. Haz un programa que dado un único hecho vector, 
; detecte si sus valores se repiten de forma simétrica. 
; Siempre que la salida sea correcta, puedes modificar el vector 
; o utilizar hechos auxiliares.
     
;Lo siguiente es una posible solución entre muchas posibilidades

(deffacts hechos

  (vector v1 1 2 2 1)
  ;(vector v2 1 3 5 6 7))



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

	(printout t "El vector " ?nombre " es simétrico" crlf))

(defrule simetricoPar
	
	(vector ?nombre)
	
=>

	(printout t "El vector " ?nombre " es simétrico" crlf))


;==========================================================================================================================================

; 22. OPCIONAL (dificil): �Sabrias resolver el ejercicio 22 sin 
; modificar el vector ni utilizar hechos auxiliares?

(deffacts hechos
  (vector v1 1 2 2 1)
  (vector v2 1 3 5 6 7))


(defrule detectaSimetrico

	(vector ?nombre $?valores)
	(forall (vector ?nombre $?cabeza ?x $?medio ?y
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
			(test (eq ?x ?y)))
=>

	(printout t "El vector " ?nombre " es simétrico" crlf))

(defrule detectaNoSimetrico

	(vector ?nombre $?cabeza ?x $?medio ?y&~?x
			  $?cola&:(= (length$ $?cabeza) (length$ $?cola)))
 
=>

	(printout t “El vector “ ?nombre “ no es simétrico” crlf))


; Problema de diagnostico
; Dadas la siguiente plantilla y hechos obtener una regla que 
; diagnostique
; las enfermedades

(deftemplate enfermedad
(slot nombre)
(multislot siempre)
(multislot a-veces))

(deffacts enfermedades
(enfermedad (nombre gripe) (siempre congestion fiebre) (a-veces tos dolor-cabeza dolor-huesos))
(enfermedad (nombre varicela) (siempre ronchas fiebre) (a-veces vomitos mareos))
(enfermedad (nombre tifus) (siempre diarrea fiebre) (a-veces dolor-cabeza delirios))
(enfermedad (nombre gastroenteritis) (siempre diarrea fiebre) (a-veces dolor-huesos))
(enfermedad (nombre resfriado) (siempre congestion) (a-veces dolor-cabeza tos)))

(deffacts caso ; Caso a diagnosticar
(sintoma diarrea)
(sintoma fiebre)
(sintoma delirios))


(defrule posible-enfermedad
(enfermedad (nombre ?n))
(forall (sintoma ?s) ;Todo síntoma del caso debe de estar en el slot siempre o en el slot  a-veces
(or (enfermedad (nombre ?n) (siempre $? ?s $?))
    (enfermedad (nombre ?n) (a-veces $? ?s $?))
))

(forall ;Toda enfermedad debe de tener todos los sintomas siempre en el caso

                (enfermedad (nombre ?n) (siempre $? ?si $?))
                (sintoma ?si)

)

=>

(printout t    "Podría tratarse de " ?n  crlf))