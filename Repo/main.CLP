


; Definicion de modulos ------------------------------

(defmodule MAIN
	(export ?ALL)
)

(deftemplate MAIN::flag 
	(slot value (type INTEGER)(allowed-values 1)(default 1))
) 

(deftemplate MAIN::estado
      (slot j3
            (type INTEGER)
            (default 0))
      (slot j4
            (type INTEGER)
            (default 0))
      (slot padre
            (type FACT-ADDRESS SYMBOL)
            (allowed-symbols sin-padre)
            (default sin-padre))
      (slot nodo
            (type INTEGER)
            (default 0))
      (slot nivel
            (type INTEGER))
      (slot s-estado
            (type STRING))
)


(defmodule ANCHURA 
	(export ?ALL)
	(import MAIN deftemplate flag)
	(import MAIN deftemplate estado)

)
(defmodule PROFUNDIDAD 
	(export ?ALL)
	(import MAIN deftemplate flag)
	(import MAIN deftemplate estado)
)

; Definicion de plantillas ---------------------------

(deftemplate opcion 
	(slot op (type INTEGER)(allowed-values 1 2))
)


; Definicion de reglas -------------------------------

(defrule MAIN::elegir

	(declare (salience 1000))

=>
	(printout t crlf "Problema de las Jarras de Agua" crlf)
	(printout t crlf "Resolver mediante: " crlf)
	(printout t crlf "  1. Anchura " crlf)
	(printout t "  2. Profundidad " crlf)
	(printout t crlf " Opci�n: " ) 
	(assert (op (read)))
)



(defrule MAIN::seleccionaA  
	(op 1)
	=> 
	(printout t " Elegido el modulo A" crlf)
	(assert (flag (value 1)))
  	(focus ANCHURA)
)
  

(defrule MAIN::seleccionaB  	
	(op 2)
	=> 
	(printout t " Elegido el modulo B" crlf)
	(focus PROFUNDIDAD)
)
  
(defrule MAIN::errorSeleccion
	(not (or(op 1)(op 2)))
	=>
	(printout t " Error al elegir m�todo ... saliendo" crlf)
)


;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////



(defrule ANCHURA::inicial
      ?x <- (initial-fact)
=>
      (assert (estado (j3 0) (j4 0) (padre sin-padre) (nivel 0) (s-estado "[0:0]")))
      (assert (nodoactual 1))
      (assert (profundidad 0 0))
      (retract ?x)
)


;**************************************************************
;
;      regla baja-nivel
;
;      desciende un nivel en el arbol de busqueda,
;      tiene una prioridad un poco mas baja que las reglas de cambio
;      de estado, para que se active una vez que ya se han explorado
;      todas las posibilidades de un nivel
;      el hecho ancho-nivel controla que en el nivel actual se hayan
;      creado nuevos nodos, lo que evita que baje de nivel indefinidamente
;
;**************************************************************

(defrule baja-nivel
      (declare (salience 400))
      ?p <- (profundidad ?n ?l)
      ?nodo <- (nodoactual ?a)
      (test (> ?a ?l))
=>
      (assert (profundidad (+ ?n 1) ?a))
      (retract ?p)
)


;**************************************************************
;
;      regla llenar jarra de 4 litros
;
;**************************************************************


(defrule llena-jarra-4
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 0)(nivel ?nivel))
      (profundidad ?nivel ?)
=>
      (assert (estado (j3 ?c3) (j4 4) (padre ?hecho) (nivel (+ ?nivel 1)) (s-estado "[Llena J4]")))
)


;**************************************************************
;
;      regla llenar jarra de tres litros
;
;**************************************************************

(defrule llena-jarra-3
      (declare (salience 500))
      ?hecho <- (estado (j3 0) (j4 ?c4) (nivel ?nivel))
      (profundidad ?nivel ?)
      (test (neq ?c4 2))
=>
      (assert (estado (j3 3) (j4 ?c4) (padre ?hecho) (nivel (+ ?nivel 1)) (s-estado "[Llena J3]")))
)


;*************************************************************
;
;      regla vacia jarra de 4 litros
;
;*************************************************************

(defrule vacia-jarra-4
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c4 0))
      (test (neq ?c4 2))
=>
      (assert (estado (j3 ?c3) (j4 0) (padre ?hecho) (nivel (+ ?nivel 1))(s-estado "[Vacia J4]")))
)

;*************************************************************
;
;      regla vaciar jarra de 3 litros
;
;*************************************************************

(defrule vacia-jarra-3
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c3 0))
      (test (neq ?c4 2))
=>
      (assert (estado (j3 0) (j4 ?c4) (padre ?hecho)(nivel (+ ?nivel 1)) (s-estado "[Vacia J3]")))
)


;*************************************************************
;
;      regla vierte j4 sobre j3 (1)
;      (cabe mas de lo que se puede echar)
;
;*************************************************************

(defrule vierte-j4-sobre-j3-1
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c4 0))
      (test (< ?c3 3))
      (test (> (- 3 ?c3) ?c4))
      (test (neq ?c4 2))
=>
      (assert (estado (j3 (+ ?c3 ?c4)) (j4 0) (padre ?hecho) (nivel (+ ?nivel 1))(s-estado "[J4->J3]")))
)


;*************************************************************
;
;      regla vierte j4 sobre j3 (2)
;      (se puede echar mas de lo que cabe)
;
;*************************************************************

(defrule vierte-j4-sobre-j3-2
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3)(j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c4 0))
      (test (< ?c3 3))
      (test (< (- 3 ?c3) ?c4))
      (test (neq ?c4 2))
=>
      (bind ?cabe (- 3 ?c3))
      (assert (estado (j3 3) (j4 (- ?c4 ?cabe)) (padre ?hecho)(nivel (+ ?nivel 1)) (s-estado "[J4->J3]")))
)


;*************************************************************
;
;      regla vierte j3 sobre j4 (1)
;      (cabe mas de lo que se puede echar)
;
;*************************************************************

(defrule vierte-j3-sobre-j4
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c3 0))
      (test (< ?c4 4))
      (test (> (- 4 ?c4) ?c3))
      (test (neq ?c4 2))
=>
      (assert (estado (j3 0) (j4 (+ ?c4 ?c3)) (padre ?hecho) (nivel (+ ?nivel 1))(s-estado "[J3->J4]")))
)

;*************************************************************
;
;      regla vierte j3 sobre j4 (2)
;      (cabe menos de lo que se puede echar)
;
;*************************************************************

(defrule vierte-j3-sobre-j4-2
      (declare (salience 500))
      ?hecho <- (estado (j3 ?c3) (j4 ?c4)(nivel ?nivel))
      (profundidad ?nivel ?)
      (test (> ?c3 0))
      (test (< ?c4 4))
      (test (< (- 4 ?c4) ?c3))
      (test (neq ?c4 2))
=>
      (bind ?cabe (- 4 ?c4))
      (assert (estado (j3 (- ?c3 ?cabe)) (j4 4) (padre ?hecho) (nivel (+ ?nivel 1))(s-estado "[J3->J4]")))
)


;*************************************************************
;
;      incremento del contador de nodos
;
;*************************************************************

(defrule contador-nodos      
      (declare (salience 1000))
      ?estado <- (estado (nodo ?nodoestado))
      ?hechonodo <- (nodoactual ?contador)
      (test(= ?nodoestado 0))
=>
      (assert (nodoactual (+ 1 ?contador)))
      (modify ?estado (nodo ?contador))
      (retract ?hechonodo)
)


;*************************************************************
;
;      regla elimina estados repetidos (1)
;      el nodo recien creado (0) es de mayor profundidad
;
;*************************************************************

(defrule elimina-estados-repetidos-1
      (declare (salience 2000))
      ?hecho1 <- (estado (j4 ?c4-1) (j3 ?c3-1) (nodo ?n) (nivel ?n1) (padre ?p1))
      ?hecho2 <- (estado (j4 ?c4-2) (j3 ?c3-2) (nodo 0) (nivel ?n2) (padre ?p2))
      (test(= ?c4-1 ?c4-2))
      (test(= ?c3-1 ?c3-2))
      (test(>= ?n2 ?n1))
      (test(neq ?n 0))
=>
      (retract ?hecho2)
)    


;*************************************************************
;
;      regla elimina estados repetidos (2)
;      el nodo recien creado (0) es de menor profundidad
;
;*************************************************************

(defrule elimina-estados-repetidos-2
      (declare (salience 2000))
      ?hecho1 <- (estado (j4 ?c4-1) (j3 ?c3-1) (nodo ?n) (nivel ?n1) (padre ?p1))
      ?hecho2 <- (estado (j4 ?c4-2) (j3 ?c3-2) (nodo 0) (nivel ?n2) (padre ?p2) (s-estado ?accion))
      (test(= ?c4-1 ?c4-2))
      (test(= ?c3-1 ?c3-2))
      (test(> ?n1 ?n2))
      (test(neq ?n 0))
=>
      (modify ?hecho1 (padre ?p2) (nivel ?n2) (s-estado ?accion))
      (retract ?hecho2)
)    

;**************************************************************
;
;      regla reconstruye arbol
;
;**************************************************************

(defrule rehace-arbol
      (declare (salience 3000))
      ?padre <- (estado (nivel ?np))
      ?hijo <- (estado (nivel ?nh) (padre ?padre))
      (test (> (- ?nh ?np) 1))
=>
      (modify ?hijo (nivel (+ ?np 1)))
)    


;**************************************************************
;
;      regla meta alcanzada
;
;**************************************************************

(defrule objetivo
      (declare (salience 600))
      ?meta <- (estado (j4 2))
=>
      (printout t "Nodo objetivo: " crlf)
      (assert (recorre ?meta))
      (assert (camino))
)


;*************************************************************
;
;      regla contruye-camino
;
;*************************************************************

(defrule contruye-camino
      (declare (salience 2500))
      ?viejalista <- (camino $?seq)
      ?estado <- (estado (padre ?padre) (s-estado ?accion))
      ?viejoestado <- (recorre ?estado)
=>
      (assert (camino ?accion ?seq))
      (assert (recorre ?padre))
      (retract ?viejalista)
      (retract ?viejoestado)
)

;*************************************************************
;
;      regla terminado
;
;*************************************************************

(defrule terminado
      (declare (salience 2500))
      ?rec <- (recorre sin-padre)
      ?lista <- (camino $?secuencia)
=>
      (printout t "Solucion:" ?secuencia crlf)
      (retract ?rec ?lista)
)

;**************************************************************
;
;      regla informa nodos
;
;**************************************************************

(defrule informa-nodos
      (declare (salience 100))
      (nodoactual ?cuenta)
=>
      (printout t "Numero estados distintos: " (- ?cuenta  1) crlf)
)

;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////

