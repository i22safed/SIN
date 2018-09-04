;
; Ejemplos de las funciones anteriores:
;
;· Funciones de tipos: ********************************************************
;
;(integerp <expresion>) _______________________________________________________

		(deffunction esEntero (?numero)

			(if (integerp ?numero) then

				(printout t "El numero " ?numero " es entero" crlf)

			else

				(printout t "El numero " ?numero " no es entero" crlf)

		))

;
;	Para ejecutarla solo tenemos que poner en el prompt de CLIPS lo siguiente:
;
;	( nombreFuncion parametros)
;
;	En este caso seria
;
;
;		(esEntero 2.5)	-> Para probar el caso de que no sea entero
;
;		(esEntero 5)	-> Para probar el caso de que sea entero
;
;
;	Y la salida correspondiente sería:
;
;		CLIPS> Loading Selection...
;
;		Defining deffunction: esEntero
;
;		CLIPS> (esEntero 5)
;
;		El numero 5 es entero
;
;		CLIPS> (esEntero 2.5)
;
;		El numero 2.5 no es entero
;
; (floatp<expresión>) _________________________________________________________
;
;	· Comprueba que el argumento que recibe la funcion sea flotante
;

	(deffunction esFlotante (?numero)

		(if (floatp ?numero) then

			(printout t "El numero " ?numero " es flotante" crlf)

		else

			(printout t "El numero " ?numero " no es flotante" crlf)

		))

;		CLIPS> (esFlotante 7.5)
;
;		El numero 7.5 es flotante
;
;		CLIPS> (esFlotante 7)
;
;		El numero 7 no es flotante
;
; (numberp<expresión>) _________________________________________________________
;
;	· Comprueba que el argumento pasado a la función sea un numero
;

		(deffunction esNumero (?numero)

		(if (numberp ?numero) then

			(printout t "El numero " ?numero " es numero" crlf)

		else

			(printout t "El numero " ?numero " no es numero" crlf)

		))


;
;		CLIPS> (esNumero "pepe")
;
;		El numero pepe no es numero
;
;		CLIPS> (esNumero 7)
;
;		El numero 7 es numero
;
; (symbolp<expresión>)_________________________________________________________
;
;	· Comprueba que el argumento pasado a la función sea de tipo symbol,
;	es decir, verde, rojo, !!!. (A diferencia del tipo string, este no va
;	entre comillas).
;

		(deffunction esSimbolo (?numero)

		(if (symbolp ?numero) then

			(printout t "El numero " ?numero " es simbolo" crlf)

		else

			(printout t "El numero " ?numero " no es simbolo" crlf)

		))

;
;		CLIPS> (esSimbolo verde) -> Aqui se puede apreciar la diferencia entre
;							   simbolo y cadena
;		El numero verde es simbolo
;
;		CLIPS> (esSimbolo "verde")
;
;		El numero verde no es simbolo
;
;
; (stringp<expresión>)_________________________________________________________
;
;	· Comprueba que el argumento recibido por la función sea una cadena, podemos
;	argumentar el caso anterior (diferencia entre simbolo y cadena)
;

		(deffunction esCadena (?cadena)

		(if (stringp ?cadena) then

			(printout t "La variable " ?cadena " es una cadena" crlf)

		else

			(printout t "La variable " ?cadena " no es una cadena" crlf)

		))


;
;		CLIPS> (esCadena "Prueba")
;
;		La variable Prueba es una cadena
;
;		CLIPS> (esCadena Prueba)
;
;		La variable Prueba no es una cadena
;

; (lexemep<expresión>)_________________________________________________________
;
;	· Comprueba que el argumento que recibe la función es una cadena o un
; 	simbolo
;


		(deffunction esTexto (?txt)

		(if (lexemep ?txt) then

			(if (stringp ?txt) then

				(printout t "La variable" ?txt "es una cadena" crlf)

			else

				(printout t "La variable " ?txt " es un simbolo" crlf)


			)


		else

			(printout t "La variable " ?txt " no es ni cadena ni simbolo" crlf)

		))


;
;		CLIPS> (esTexto pedro)
;
;		La variable pedro es un simbolo
;
;		CLIPS> (esTexto "Pedro")
;
;		La variablePedroes una cadena
;
;		CLIPS> (esTexto 6)
;
;		La variable 6 no es ni cadena ni simbolo
;
;
; (evenp<expresión>)____________________________________________________________
;
;	· Devuelve TRUE si es argumento que recibe la funcion es par y FALSE si
;	este es impar
;

		(deffunction esPar (?numero)

		(if (evenp ?numero) then

			(printout t "El numero " ?numero " es par" crlf)

		else

			(printout t "El numero " ?numero " es impar" crlf)

		))

;
;
;		CLIPS> (esPar 5)
;
;		El numero 5 es impar
;
;		CLIPS> (esPar 6)
;
;		El numero 6 es par
;
;
;
; (oddp<expresión>)_____________________________________________________________
;
;	· Caso inverso de la función anterior en la que devuelve TRUE si el argumento
;	que recibe la función impar y FALSE si es par.
;
;


		(deffunction esImpar (?numero)

		(if (oddp ?numero) then

			(printout t "El numero " ?numero " es impar" crlf)

		else

			(printout t "El numero " ?numero " es par" crlf)

		))

;
;		CLIPS> (esImpar 3)
;
;		El numero 3 es impar
;
;		CLIPS> (esImpar 4)
;
;		El numero 4 es par
;
; (multifieldp<expresión>)______________________________________________________
;
;	· Devuelve TRUE si la variable es multicampo y FALSE si la variable no es
; 	multicampo
;
;

	(multifieldp (create$ a 3 4.1))

	(multifieldp 1)


;		CLIPS> (multifieldp (create$ a 3 4.1))
;		TRUE
;
;		CLIPS> (multifieldp 1)
;		FALSE

;
; · Funciones aritmeticas *******************************************************
;
; (eq <expresión1> <expresión2>+)_______________________________________________
;
;	· Compara el valor de la expresion1 con el valor de las expresiones restantes
;	devuelve TRUE si coinciden las expresiones y FALSE si alguna de ellas no
;	coincide.
;


	(eq 4 4 4 4)

	(eq 4 4 4 1)

;
; 	CLIPS> (eq 4 4 4 1)
;	FALSE
;
;	CLIPS> (eq 4 4 4 4)
;	TRUE
;
;
; (neq <expresión1> <expresión2>+)______________________________________________
;
;	· Caso inverso de la funcion anterior, en la que devuelve TRUE si no
;	coinciden dichas expresiones y FALSE si coinciden
;

	(neq 4 3 2 1)

	(neq 4 4)

;
;	CLIPS> (neq 4 3 2 1)
;	TRUE
;
;	CLIPS> (neq 4 4)
;	FALSE
;
;
; (= <expresión-num1> <expresión-num2>+)________________________________________
;
;	· Compara 2 o más expresiones numericas devolviendo TRUE si coinciden
;	y FALSE si no lo son
;
;

	(= 3 3.0 )

	(= 3 3.0001)


;
;	CLIPS> (= 3 3.0 )
;	TRUE
;
;	CLIPS> (= 3 3.0001)
;	FALSE
;
; (<> <expresión-num1> <expresión-num2>+)_______________________________________
;
;	· Comprueba que la expresion numerica 2 esté fuera del rango de la expresion
;	numerica 1 devuelve TRUE si lo esta y FALSE si no lo esta
;

	(<> 4 4.1)

	(<> 4 4.0)

;
;	CLIPS> (<> 4 4.0)
;	FALSE
;
;	CLIPS> (<> 4 67)
;	TRUE
;
;
; (< <expresión-num1> <expresión-num2>+)________________________________________
;
;	· Comprueba que la expresion numerica 1 sea menor que la expresión numerica
;	2 devolviendo TRUE su la expresion numerica 2 es mayor que la 1 y FALSE
;	si no lo es
;

	(< 4 6)

	(< 4 3)

;
;
;	CLIPS> (< 4 6)
;	TRUE
;
;	CLIPS> (< 4 3)
;	FALSE
;
;
; (<= <expresión-num1> <expresión-num2>+)_______________________________________
;
;	· Comprueba que la expresion numerica 1 sea menor o igual que la expresión
;	numerica 2 devolviendo TRUE si es mayor o igual la expresion numerica 2
;	que la 1 y FALSE si no lo es
;

	(<= 4 6)

	(<= 4 4)

	(<= 4 3)

;
;
;	CLIPS> (<= 4 6)
;	TRUE
;
;	CLIPS> (<= 4 4)
;	TRUE
;
;	CLIPS> (<= 4 3)
;	FALSE
;
;
; (> <expresión-num1> <expresión-num2>+)________________________________________
;
;	· Comprueba que la expresion numerica 1 sea mayor que la expresión numerica
;	2 devolviendo TRUE su la expresion numerica 2 es menor que la 1 y FALSE
;	si no lo es
;
;

	(> 4 6)

	(> 4 3)

;
;
;	CLIPS> (> 4 6)
;	FALSE
;
;	CLIPS> (> 4 3)
;	TRUE
;
;
;
; (>= <expresión-num1> <expresión-num2>+)_______________________________________
;
;	· Comprueba que la expresion numerica 1 sea mayor o igual que la expresión
;	numerica 2 devolviendo TRUE si es menor o igual la expresion numerica 2
;	que la 1 y FALSE si no lo es
;

	(>= 4 6)

	(>= 4 4)

	(>= 4 3)

;
;
;	CLIPS> (>= 4 6)
;	FALSE
;	CLIPS> (>= 4 4)
;	TRUE
;	CLIPS> (>= 4 3)
;	TRUE
;
;

; · Funciones logicas **********************************************************
;
; (and<expresión>+)_____________________________________________________________
;
;	· Evalua de manera logica (mediante el producto logico) las salidas de las
;	funciones, es decir TRUE o FALSE, tambien se podria comprobar directamente
;	introduciendo lo siguiente:
;

	(and TRUE TRUE)

	(and FALSE TRUE)

;
;	CLIPS> (or TRUE TRUE)
;	TRUE
;
;	CLIPS> (or FALSE TRUE)
;	FALSE
;
;


; (or<expresión>+)______________________________________________________________
;
;	· Evalua de manera logica (mediante la suma logica) las salidas de las
;	funciones, es decir TRUE o FALSE, tambien se podria comprobar directamente
;	introduciendo lo siguiente:
;

	(or FALSE FALSE)

	(or FALSE TRUE)

;
;	CLIPS> (or FALSE FALSE)
;	FALSE
;
;	CLIPS> (or FALSE TRUE)
;	TRUE
;
;


; (not<expresión>)______________________________________________________________
;
;	· Actua como complementador de salidas es decir niega la salida de las
;	funciones
;

	(not TRUE)

	(not FALSE)

;
;	CLIPS> (not TRUE)
;	FALSE
;
;	CLIPS> (not FALSE)
;	TRUE
;


; Funciones multicampo *********************************************************
;
; (create$)_____________________________________________________________________
;
;	· El valor de retorno de la funcion create$ es el valor del multicampo,
;	independientemente del valor o tipo de argumentos.
;

	(create$ rojo 1 verde "pan")

	(create$)


;
;	CLIPS> (create$ rojo 1 verde "pan")
;	(rojo 1 verde "pan")	-> Retorna el valor del multicmapo creado con las
;						cuatro variables (rojo 1 verde "pan")
;
;	CLIPS> (create$)
;	()					-> Retorna el valor del multicampo que al crearlo
;						con create$ devolveria un multicampo vacio ()
;
;
; (length$ <expr-multicampo>)___________________________________________________
;
;	· Retorna la cantidad de argumentos que posee el multicampo creado
;

	(length$ (create$ pan 4 verde "rojo"))

;
;	CLIPS> (length$ (create$ pan 4 verde "rojo"))
;	4
;
;
; (nth$ <expr-entera> <expr-multicampo>)________________________________________
;
;	· Devuelve el valor de argumento multicampo que especifica la expresion
;	numerica entera
;


	(nth$ 3 (create$ pan 3 siete "Verde"))

;
;
;	CLIPS> (nth$ 3 (create$ pan 3 siete "Verde"))
;	siete
;
;
; (member$ <expresión> <expr-multicampo>)_______________________________________
;
;	· Retorna la posicion de la primera ocurrencia de una determinada expresion
;	en el multicampo, en caso de que no haya ocurrencias, devuelve FALSE
;
;

	(member$ platano (create$ rojo "verde" 1 platano))

	(member$ 1 (create$ rojo "verde" 1 platano 1))

	(member$ azul (create$ rojo "verde" 1 platano))

	(member$ (create$ 1 2)(create$ 1 2 4 5))

;
;
;	CLIPS> (member$ platano (create$ rojo "verde" 1 platano))
;	4
;
;	CLIPS> (member$ 1 (create$ rojo "verde" 1 platano 1))
:	3
;
;	CLIPS> (member$ azul (create$ rojo "verde" 1 platano))
;	FALSE
;
;	CLIPS> (member$ (create$ 1 2)(create$ 1 2 4 5))
;	(1 2)
;
;
; (subsetp<expr-multicampo> <expr-multicampo>)__________________________________
;
;	· Devuelve TRUE si los elementos del primer campo multivaluado estan en
;	el segundo campo multivaluado independientemente del orden, y FALSE en caso
;	FALSE en caso contrario
;
;

	(subsetp (create$ verde 1) (create$ verde "rojo" 1 2 azul))

	(subsetp (create$ 2 3) (create$ verde "rojo" 1 2 azul))

;
;	CLIPS> (subsetp (create$ verde 1) (create$ verde "rojo" 1 2 azul))
;	TRUE
;
;	CLIPS> (subsetp (create$ 2 3) (create$ verde "rojo" 1 2 azul))
;	FALSE
;
;
; (subseq$<expr-multicampo> <exp-entera-inicio> <exp-entera-fin>)_______________
;
;	· Funciona de la misma manera que la funcion anterior solamente que en esta
;	funcion si importa el orden
;
;

	(subseq$ (create$ 1 2 3 4 5 6 7 8 9) 4 7)

;
;
;	CLIPS> (subseq$ (create$ 1 2 3 4 5 6 7 8 9) 4 7)
;	(4 5 6 7)
;
;



; (first$ <expr-multicampo>)____________________________________________________
;
;	· Devuelve el primer valor del campo multivaluado

	(first$ (create$ 1 2 3 4 5 5 6))


;
;	CLIPS> (first$ (create$ verde rojo azul amarillo negro))
;	(verde)
;
;
; (rest$ <expr-multicampo>)_____________________________________________________
;
;	· Es la funcion complementaria a first$, retorna todos valores restantes
;	menos el primero
;


	(rest$ (create$ 1 2 3 4 5 5 6))



;
;
;	CLIPS> (rest$ (create$ 1 2 3 4 5 5 6))
;	(2 3 4 5 5 6)
;
;
;
; (explode$ <expr-cadena>)______________________________________________________
;
;	· Convierte todo elemento de una cadena a valores de un multicampo, los
;	los simbolos, floats, enteros o nombres de variables son convertidos a
;	cadenas
;

	(explode$ "Esto es \"una\" pru)eba")

;
;	CLIPS> (explode$ "Esto es \"una\" pru)eba")
;	(Esto es "una" pru ")" eba)
;
;
; (implode$ <expr-multicampo>)__________________________________________________
;
;	· Convierte todos los valores del un multicampo en cadena
;

	(implode$ (create$ Esto es una prueba))

;
;
;	CLIPS> (implode$ (create$ Esto es una prueba))
;	"Esto es una prueba"
;
;
; (insert$<expr-multicampo> <exp-enteraN> <expresión>+)_________________________
;
;	· Inserta una expresion en la posicion indicada del multicampo, en caso de
;	que haya algun valor en dicha posicion lo desplaza a la posicion n+1
;


	(insert$ (create$ verde 1 "pan" ) 3 turbo)

;
;
;	CLIPS> (insert$ (create$ verde 1 "pan" ) 3 huevo)
;	(verde 1 huevo "pan")
;
;
;
; (replace$ <expr-multicampo> <exp-entera-inicio> <exp-entera-fin> <expresión>+)
;
;	· Reemplaza la expresion indicada en la posicion indicada del multicampo
;	(o rango de posiciones)
;
;

	(replace$ (create$ verde 1 "pan" ) 1 1 cambio) ; Cambia solamente la pos 1

	(replace$ (create$ verde 1 "pan" ) 1 2 cambio) ; Cambia la pos 1 y 2 por
										  ; cambio
;
;
;	CLIPS> (replace$ (create$ verde 1 "pan" ) 1 1 cambio)
;	(cambio 1 "pan")
;
;	CLIPS> (replace$ (create$ verde 1 "pan" ) 1 2 cambio)
;	(cambio "pan")
;
;
;
; (delete$ <expr-multicampo> <exp-entera-inicio> <exp-entera-fin>)______________
;
;	· Elimina elementos de un multicampo especificados previamente mediante un
;	rango
;


	(delete$ (create$ azul 1 pan "verde" coche vaca) 2 3)

	(delete$ (create$ azul 1 pan "verde" coche vaca) 2 4)

;
;	CLIPS> (delete$ (create$ azul 1 pan "verde" coche vaca) 2 3)
;	(azul "verde" coche vaca)
;
;	CLIPS> (delete$ (create$ azul 1 pan "verde" coche vaca) 2 4)
;	(azul coche vaca)
;
;
; (str-cat<expresión>*)_________________________________________________________
;
;	· Esta funcion concatena una 1 o mas cadenas, simbolos, etc. retornando
;	una cadena resultado de la concatenacion del resto.
;

	(str-cat "Esto es " "una " "Pr" "ue""ba")

	(str-cat "Esto es " "una " "Pr" 1 ba")


;
;	CLIPS> (str-cat "Esto es " "una " "Pr" "ue""ba")
;	"Esto es una Prueba"
;
;	CLIPS> (str-cat "Esto es " "una " "Pr" 1 "ba")
;	"Esto es una Pr1ba"
;
;
; (sym-cat<expresión>*)_________________________________________________________
;
;	· Realiza una concatenacion de 1 o mas cadenas, simbolos, etc. retornando
;	un dato de tipo simbolo.
;

	(sym-cat<expresión>*)

;
;	CLIPS> (sym-cat "Esto es " 1 "Pr" "ue" "ba")
;	Esto es una Prueba
;
;	CLIPS> (sym-cat "Esto es " 1 "Pr" "ue" "ba")
;	Esto es 1Prueba
;
;
; (str-length<expr-cadena-o-símbolo>)___________________________________________
;
;	· Retorna la longuitud de un elemento de cadena o simbolo
;

	(str-length "Cual es la longuitud de esta cadena?")

	(str-length Longuitud)

;
;	CLIPS> (str-length "Cual es la longuitud de esta cadena?")
;	36
;
;	CLIPS> (str-length Longuitud)
;	9
;
;
; (sub-string<expr-entera> <expr-entera> <expr-cadena>)_________________________
;
;	· Retorna una subcadena comprendida entre los extremos que se especifican
;
;

	(sub-string 3 7 "Esto es una cadena de prueba?")


;
;	CLIPS> (sub-string 3 7 "Esto es una cadena de prueba?")
;	"to es"
;
;
; (str-compare<expr-cadena-o-símbolo> <expr-cadena-o-símbolo>)__________________
;
;	· Compara letra a letra las dos cadenas, devolviendo 0 si son iguales, un
;	valor menor que 1 si la primera es mas corta que la segunda y un valor mayor
;	que 1 si la primera es mayor que la segunda
;


	(str-compare  "prueba" "prueba")

	(str-compare  "prueba" "pruebaaaa")

	(str-compare  "pruebaaaa" "prueba")

;
;	CLIPS> (str-compare  "prueba" "prueba")
;	0
;
;	CLIPS> (str-compare  "prueba" "pruebaaaa")
;	-1
;
;	CLIPS> (str-compare  "pruebaaaa" "prueba")
;	1
;
;
; Funciones de entrada y salida ************************************************
;
; (open<nombre-fichero> <nombre-lógico> <modo>)_________________________________
;
;	· Devuelve TRUE si el fichero en cuestión, se ha abierto correctamente y
;	FALSE en caso contrario (por ejemplo que no exista el archivo). Si se
;	trabaja en Windows hay que cambiar "\" por "/" a la hora de especificar la
;	ruta
;

	(open "nombreFichero.txt" file "r")

	(open "C:/Users/David/Google Drive/Universidad/1516/Sistemas Inteligentes/
	Practicas/Sesion 9_0505/EjemplosSIN0505.clp" file "r")

;
;	CLIPS> (open "nombreFichero.txt" file "r")
;	FALSE
;
;	CLIPS> (open "C:/Users/David/Google Drive/Universidad/1516/
;	Sistemas Inteligentes/Practicas/Sesion 9_0505/EjemplosSIN0505.clp" file "r")
;	TRUE
;
;
; (close[<nombre-lógico>])______________________________________________________
;
;	· Funcion que recibe el nombre del "puntero" del fichero que se ha abierto
;	previamente y cuya funcion es cerrarlo devolviendo TRUE si se ha cerrado
;	correctamente.
;

	(close file)

;
;
;	CLIPS> (open "C:/Users/David/Google Drive/Universidad/1516/
;	Sistemas Inteligentes/Practicas/Sesion 9_0505/EjemplosSIN0505.clp" file "r")
;	TRUE
;
;	CLIPS> (close file)
;	TRUE
;
;
; (printout <nombre-lógico> <expresión>*)________________________________________
;
;	· Escribe en el fichero la cadena pasada por parametro, se debe abrir el
;	fichero en cuestion en modo escritura o adicion
;

	(open "C:/Users/David/Google Drive/Universidad/1516/Sistemas Inteligentes/Practicas/Sesion 9_0505/ejemploFichero.clp" file "a")

	(printout file "Prueba N") ; ...

	(close file)

;
;	CLIPS> (open "C:/Users/David/Google Drive/Universidad/1516/Sistemas Inteligentes/Practicas/Sesion 9_0505/ejemploFichero.clp" file "a")
;	TRUE
;	CLIPS> (printout file "Prueba 1" crlf)
;	CLIPS> (printout file "Prueba 2" crlf)
;	CLIPS> (printout file "Prueba 3" crlf)
;	CLIPS> (printout file "Prueba 4" crlf)
;	CLIPS> (close file)
;	TRUE
;
;
; (read[nombre-lógico>])________________________________________________________
;
;	· Esta funcion lee del fichero abierto en modo lectura, cada llamada a la
;	funcion lee hasta el siguiente salto de linea / espacio, devuelve los
;	elementos por los cuales esta formado el texto y en caso de que llegue al
;	final del fichero, devolveria EOF.
;

	(read file)

;
;	CLIPS> (open "C:/Users/David/Google Drive/Universidad/1516/Sistemas Inteligentes/Practicas/Sesion 9_0505/ejemploFichero.clp" file "r")
;	TRUE
;	CLIPS> (read file)
;	Prueba1
;	CLIPS> (read file)
;	Prueba2
;	CLIPS> (read file)
;	Prueba3
;	CLIPS> (read file)
;	Prueba4
;	CLIPS> (read file)
;	EOF
;	CLIPS> (close file)
;	TRUE
;
;
;
; (readline[nombre-lógico>])____________________________________________________
;
;	· Dicha funcion devuelve la linea completa incluyendo espacios, para ello
;	abrimos el fichero en modo lectura y ejecutamos el comando readline hasta
;	que la salida sea EOF
;

	(readline file)

;
;	CLIPS> (open "C:/Users/David/Google Drive/Universidad/1516/Sistemas Inteligentes/Practicas/Sesion 9_0505/ejemploFichero.clp" file "r")
;	TRUE
;
;	CLIPS> (readline file)
;	"Prueba1 linea1"
;
;	CLIPS> (readline file)
;	"Prueba2 linea2"
;
;	CLIPS> (readline file)
;	"Prueba3 linea3"
;
;	CLIPS> (readline file)
;	"Prueba4 linea4"
;
;	CLIPS> (readline file)
;	EOF
;
;	CLIPS> (close file)
;	TRUE
;
;
; Funciones matemáticas ********************************************************
;
;
; (+ <expr-num> <expr-num>+)____________________________________________________
;
;	· Suma dos o mas numeros

	(+ 3 2)

;
;	CLIPS> (+ 3 2)
;	5
;
; (- <expr-num> <expr-num>+)_____________________________________________________
;
;	· Resta dos o mas numeros
;

	(- 3 2)

;
;	CLIPS> (- 3 2)
;	1
;
;
; (* <expr-num> <expr-num>+)____________________________________________________
;
;	· Multiplica dos o mas numeros
;

	(* 3 2)


;
;	CLIPS> (* 3 2)
;	6
;
;
; (/ <expr-num> <expr-num>+)____________________________________________________
;
;	· Divide dos o mas numeros (contempla la parte decimal)
;

	(/ 3 2)

;
;	CLIPS> (/ 3 2)
;	1.5
;
; (div <expr-num> <expr-num>+)__________________________________________________
;
;	· Divide 2 o mas numeros (devuelve la parte entera)
;

	(div 3 2)


;
;	CLIPS> (div 3 2)
;	1
;
;
; (mod<expr-num> <expr-num>)____________________________________________________
;
;	· Realiza la operacion modulo de dos numeros
;

	(mod 3 2)

;
;	CLIPS> (mod 3 2)
;	1
;
;
; (sqrt<expr-num>)______________________________________________________________
;
;	· Realiza la raiz cuadrada de un numero
;

	(sqrt 3)

;
;	CLIPS> (sqrt 3)
;	1.73205080756888
;
;
; (** <expr-num> <expr-num>)____________________________________________________
;
;	· Realiza la operacion exponente, hay que indicar base (expresion numerica
;	1) y exponente (expresion numerica 2)
;

	(** 3 2)

;
;	CLIPS> (** 3 2)
;	9.0
;
; (round<expr-num>)_____________________________________________________________
;
;	· Redondea dependiendo de la parte decimal, si la parte decimal esta entre
;	[0.0 , 0.5] redondea a la baja en el caso contrario, es decir, si la parte
;	decimal es mayor que 0.5 se redondea a la alza (0.5 , 0.9]


	(round (sqrt 3))


;
;
;	CLIPS> (round (sqrt 3)) 	; El valor de sqrt(3) es 1.73205080756888
;	2
;
; (abs<expr-num>)_______________________________________________________________
;
;	· Devuelve el valor absoluto del numero pasado a la funcion
;
;

	(abs -3)

;
;	CLIPS> (abs -3)
;	3
;
;
; (max<expr-num>+)______________________________________________________________
;
;	· Devuelve el valor maximo de un conjunto de valores
;


	(max 3 4 6 1 6 6 2 10)


;
;	CLIPS> (max 3 4 6 1 6 6 2 10)
;	10
;
;
; (min<expr-num>+)______________________________________________________________
;
;	· Devuelve el valor minimo de un conjunto de valores
;

	(min 3 4 6 1 6 6 2 10)

;
;	CLIPS> (min 3 4 6 1 6 6 2 10)
;	1
;
;
; Funciones procedurales********************************************************
;
; (bind<variable> <expresión>*)_________________________________________________
;
;	· Declara una variable y se le asigna uno o varios valores
;

	(bind ?variable "Esto es una prueba")

	(bind ?variable2 "Esto es una prueba" "Añadimos otra cadena mas")


;
;	CLIPS> (bind ?variable "Esto es una prueba")
;	"Esto es una prueba"
;	CLIPS> (printout t ?variable crlf)
;	Esto es una prueba
;
;	CLIPS> (bind ?variable2 "Esto es una prueba" "Añadimos otra cadena mas")
;	("Esto es una prueba" "Añadimos otra cadena mas")
;	CLIPS> (printout t ?variable2 crlf)
;	("Esto es una prueba" "Añadimos otra cadena mas")
;
;
; (if<expresión> then<acción>* [else<acción>*])_________________________________
;
;	· Estructura condicional if-else
;
;

	(deffunction esImpar (?numero)

	(if (oddp ?numero) then

		(printout t "El numero " ?numero " es impar" crlf)

	else

		(printout t "El numero " ?numero " es par" crlf)

	))


;
;	CLIPS> (esImpar 7)
;	El numero 7 es impar
;	CLIPS> (esImpar 8)
;	El numero 8 es par
;
;
;
; (switch <expr-prueba> <sentencia-caso> [<sentencia-defecto>])
;			<sentencia-caso> ::= (case <expr-comparación>then<acción>*)
;			<sentencia-defecto> ::= (default<acción>*)


	(deffunction foo (?val)
	(switch ?val
		(case 1 then (printout t "Este es el caso 1" crlf))
		(case 2 then (printout t "Este es el caso 2" crlf))
		(default (printout t "Este caso no esta contemplado" crlf)))
	)


;
;	CLIPS> Loading Selection...
;	Defining deffunction: foo
;	CLIPS> (foo 1)
;	Este es el caso 1
;	CLIPS> (foo 2)
;	Este es el caso 2
;	CLIPS> (foo 3)
;	Este caso no esta contemplado
;
;

; (while<expresión> [do] <acción>*)
; (loop-for-count<rango> [do] <acción>*)
;
;	<rango> ::=
;	<íncice-final> |
;	(<variable> <índice-final>) |
;	(<variable> <índice-inicio> <índice-final>)
;	<índice-inicio> ::= <expr-entera>
;	<índice-final> ::= <expr-entera>
;
; (return[<expresión>]) (break)_________________________________________________
;
;	· Bucle iterativo do-while
;

	(deffunction contadorSimple (?i)

		(while (> ?i 0)
		(printout t ?i crlf)
		(bind ?i (- ?i 1)))

	)


;
;	CLIPS> Loading Selection...
;	Defining deffunction: contadorSimple
;	CLIPS> (contadorSimple 5)
;	5
;	4
;	3
;	2
;	1
;	FALSE
;












;
