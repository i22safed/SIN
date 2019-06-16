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
;5.- Haz un programa que dado un �nico hecho datos con un n�mero
;    indefinido de valores, elimine los que no sean numericos.
;===================================================================






;===================================================================
;	6.	Haz un programa que dado un conjunto de hechos
;(vector <nombreVector> <val1> ... <valN>), detecte aquellos
;hechos cuyos valores no est�n ordenados de menor a mayor e
;imprima el mensaje �El vector <nombreVector> no est� ordenado�.
;Se entender� que en la base de hechos no habr� dos hechos
;vector con mismo nombre de vector.
;===================================================================
; 7.-	Haz un programa que dado un conjunto de hechos de la
;     forma (dato 1), (dato 5), (dato verde)..., cree un �nico hecho
;     (todos-los-datos ...) con todos los valores de los hechos
;     anteriores.
;===================================================================
;8.- Haz un programa que dado un conjunto hechos
     (vector <nombreVector> <val1> ... <valN>)
     con valores num�ricos, ordene sus valores de menor a mayor.
;===================================================================
; 9.- Haz un programa que resuelva el ejercicio 7 pero
;     sin eliminar los hechos (dato 1), (dato 5), (dato verde)....
;    (Se presupone un �nico hecho todos-los-datos)
;===================================================================
; 10.-	Haz un programa que dado un conjunto de hechos de tipo dato
        y un �nico valor num�rico, imprima los valores num�ricos
        por pantalla de menor a mayor. Vigila que el programa
        funciona correctamente incluso con la estrategia de ejecuci�n
        de reglas Random.
;===================================================================
; 11.- Haz un programa que resuelva el ejercicio 9, pero que s�lo
       utilice los hechos con valores num�ricos y los inserte de
       forma ordenada (de menor a mayor) en el hecho todos-los-datos.
       (Se presupone un �nico hecho todos-los-datos)
;===================================================================
; 12.- Haz un programa que calcule el factorial de un n�mero,
       de manera que ante un hecho (factorial 3), muestre por
       pantalla el mensaje �El factorial de 3 es 6�.
;===================================================================
;13.-	Una planta industrial tiene diez sensores identificados
;	por un c�digo num�rico entre 1 y 10. Cada sensor puede
;	encontrarse en un estado correcto o incorrecto. Escribe
;	una plantilla que permita representar la informaci�n relativa
;	a los sensores y un conjunto de reglas que imprima un mensaje
;	de advertencia si tres o m�s sensores se encuentran en un
;	estado incorrecto. S�lo debe mostrarse un mensaje de error
;	aunque haya m�s de tres sensores en estado incorrecto.
;===========================================================
;14.- Escribe un programa para ayudar a una persona a decidir qu� plantas
;     podr�a plantar. La siguiente tabla indica las caracter�sticas de una
;     serie de plantas (tolerancia al fr�o, tolerancia a la sombra,
;     tolerancia al clima seco...). La entrada al programa debe
;     consistir en un conjunto de hechos
;     (caracter�stica-deseada <caracter�stica>) que indiquen
;     caracter�sticas que se desee que tenga una planta.
;     El programa debe mostrar por pantalla el nombre de las plantas
;     que cuenten con las caracter�sticas indicadas, aunque aparte de
;     esas cuenten con otras caracter�sticas
;=====================================================================
; 15.- Haz un programa en base a la informaci�n del ejercicio
;      anterior, pero ahora se imprimir�n s�lo aquellas plantas
;      que cumplan exactamente con todas las caracter�sticas
;      deseadas (no puede contener otras caracter�sticas)
;=====================================================================
;16.-	Complementa el ejercicio 8 para que tambi�n se detecten
     los vectores que s� est�n ordenados. Es decir, sin modificar los
     hechos ni crear hechos auxiliares, se debe imprimir un mensaje
     por cada vector (vector <nombreVector> <val1> ... <valN>),
     indicando si sus elementos est�n ordenados o no.
     Se entender� que en la base de hechos no habr� dos
     hechos vector con mismo nombre de vector.
;=====================================================================
;17.	Haz un programa que dado un �nico hecho vector con un
;    n�mero indefinido de valores num�ricos, imprima el valor que se
;    sit�a justo en medio, o la media de los dos valores de
;    en medio.
;=====================================================================
;18.-	Haz un programa que dado un �nico hecho vector, detecte si sus
;    valores se repiten de forma sim�trica. Siempre que la salida sea
;    correcta, puedes modificar el vector o utilizar hechos auxiliares.
;    Lo siguiente es una posible soluci�n entre muchas posibilidades
;=====================================================================
