;Ej.- 1
(clear) ;Módulo actual MAIN
(defmodule A) ;Módulo actual A
(defmodule B) ;Módulo actual B
(defrule r1 =>)
(defrule A::r2 =>) ;Módulo actual A
;(list-defrules)
;(focus A)


;Ej.- 2
(clear)
(defmodule A)
(deftemplate A::datos (slot x))
(defmodule B)
(defrule B::r1 (datos (x 3)) =>)

(defrule B::r1
(datos (
CLIPS> (clear)
CLIPS> (defmodule A (export deftemplate datos))
CLIPS> (deftemplate A::datos (slot x))
CLIPS> (defmodule B (import A deftemplate datos))
CLIPS> (defrule B::r1 (datos (x 3)) =>)

EJ.- 3
(clear)
(defmodule A (export deftemplate datos data))
(deftemplate datos (slot x))
(deftemplate data (slot y))
(deffacts info (datos (x 1)) (data (y 2)))
(defmodule B (import A deftemplate datos))
(reset)
(facts A)


Ej. 4

;(clear) ;Cuidado con las plantillas implícitas
(defmodule A (export deftemplate ?ALL))
;(assert (datos 1))
;(facts)

(defmodule B (import A deftemplate ?ALL))
;(assert (datos 2) (data 3))



Ej. 5

;(clear)
(defmodule MAIN (export ?ALL))
(defrule ejemplo =>
  (printout t "Foco en MAIN" crlf)
  (focus A B)) ;Añade a la pila de dcha. a izda.

(defmodule A (import MAIN deftemplate initial-fact))
(defrule ejemplo =>
 (printout t "Foco en A" crlf))
 
(defmodule B (import MAIN deftemplate initial-fact))
(defrule ejemplo =>
  (printout t "Foco en B" crlf))
;(reset)
;(run)

Ej. 6. Efecto de return

;(clear)
(defmodule MAIN (export deftemplate initial-fact))
(defmodule A (import MAIN deftemplate initial-fact))
(defrule MAIN::inicio => (focus A))
(defrule A::r1 =>
  (return); Observar el efecto de return
  (printout t "No imprime" crlf))
(defrule A::r2 =>
  (return)
  (printout t "No imprime" crlf))


;Ej. 7
;======
;CLIPS> (watch rules)
;CLIPS> (watch focus)
; Ojo que el programa no acaba nunca
;(clear) 
(defmodule DETECCION)
(deffacts DETECCION::d1
  (detecta 0))
(defrule detecta
  ?h1<- (detecta ?x)
  =>
  (printout t "Detecta " ?x crlf)
  (retract ?h1)
  (assert (detecta (+ 1 ?x) ))
  (return); Sale de este módulo DETECCION
  )
  
(defmodule AISLAMIENTO)
(defmodule RECUPERACION)
(deffacts MAIN::informacion-control
  (secuencia-fases DETECCION AISLAMIENTO RECUPERACION))
(defrule MAIN::cambio-fase
   ?l <-(secuencia-fases ?siguiente $?resto)
=>
  (focus ?siguiente)
  (retract ?l)
  (assert (secuencia-fases $?resto ?siguiente)))








;Ejercicio de control de módulos
;===============================

;MODULO MAIN
(defmodule MAIN (export ?ALL))
(deftemplate 	MAIN::datos
   (slot x)
   (slot y)
)
(deffacts MAIN::hechos
   (datos (x 3) (y 4))
)

(defrule MAIN::inicio 
     =>
     (printout t "Foco en MAIN" crlf)
     (focus SUMA PRODUCTO RESTA)
) 

(defrule MAIN::fin
    (declare (salience -2)) 
     =>
     (printout t "Programa finalizado" crlf)

) 


;MODULO SUMA
(defmodule SUMA (import MAIN deftemplate datos initial-fact))

(defrule SUMA::suma
 (datos
  (x ?x)
  (y ?y)
)
 =>
 (printout t "Foco en A" crlf)
 (assert (suma (+ ?x ?y)))
 ;(return) ;Probar cómo se abandona el módulo
)

(defrule SUMA::presentarSuma
   (suma ?s)
=>

(printout t "suma: " ?s crlf)
)
;==========================================================================


;MODULO PRODUCTO
(defmodule PRODUCTO (import MAIN deftemplate datos ))

(defrule PRODUCTO::producto
 (datos
  (x ?x)
  (y ?y)
)
    =>
   (printout t "Foco en PRODUCTO" crlf)
   (assert (producto (* ?x ?y)))
)

(defrule PRODUCTO::presentarProducto
   (producto ?p)
=>

(printout t "producto: " ?p crlf)

)

;=========================================================================

;MODULO RESTA
(defmodule RESTA (import MAIN deftemplate datos ))

(defrule RESTA::resta

 (datos
  (x ?x)
  (y ?y)
)
    =>
   (printout t "Foco en RESTA" crlf)
   (assert (resta (* ?x ?y)))
)

(defrule RESTA::presentarResta
   (resta ?r)
=>

(printout t "resta: " ?r crlf)

)


;=========================================================================

; MODULO DE DIVISION 



;=========================================================================