






;MODULO MAIN ==================================================		

; Se define el módulo MAIN en el que exportamos los modulos 
; necesarios para el funcionamiento del programa 

(defmodule MAIN (export ?ALL))

; Se define una plantilla que posee dos campos (slots) 

(deftemplate 	MAIN::datos
   (slot x)
   (slot y)
)

; Definimos unos hechos para la plantilla anteriormente 
; definida

(deffacts MAIN::hechos
   (datos (x 3) (y 4))
)

; Definimos tres reglas (inicio/pedir-x/pedir-y) para 
; centrar el foco en los modulos y recoger el valor 
; de las variables por teclado 

(defrule MAIN::inicio 
     =>
     (printout t "Foco en MAIN" crlf)
     (focus SUMA PRODUCTO )
) 

(defrule pedir-x
   (not (x ?))
 =>
    (printout t "Entrar x: ")
   (assert (x (read)))
   (printout t " : " crlf)
)

(defrule pedir-y

   (not (y ?))
 =>
   (printout t "Entrar y: ")
   (assert (y (read)))
   (printout t " : " crlf)
   (assert (objetivo rellenar))
)



(defrule rellenar-datos
  (declare (salience 1))
 ?h1<- (x ?x)
  ?h2<-(y ?y)
  ?h3<-(objetivo rellenar)
 ?h<- (datos (x ?) (y ?))
  =>
  ;(retract ?h1 ?h2)
  (retract ?h3)
  (modify ?h (x ?x) (y ?y))
  )

(defrule MAIN::fin
    (declare (salience -2)) 
     =>
     (printout t "Programa finalizado" crlf)

) 


;MODULO SUMA ==================================================

(defmodule SUMA (import MAIN deftemplate datos initial-fact))

(defrule SUMA::suma
 (datos 
  (x ?x)
  (y ?y))
 
 =>
 (printout t "Foco en A" crlf)
 (assert (suma (+ ?x ?y)))
 ;(return) ;Probar cÃ³mo se abandona el mÃ³dulo
)

(defrule SUMA::presentarSuma
   (suma ?s)
=>

(printout t "suma: " ?s crlf)
)


;MODULO PRODUCTO ==============================================

(defmodule PRODUCTO (import MAIN deftemplate datos ))

(defrule PRODUCTO::producto
 (datos
  (x ?x)
  (y ?y))
 
    =>
   (printout t "Foco en PRODUCTO" crlf)
   (assert (producto (* ?x ?y)))
)

(defrule PRODUCTO::presentarProducto
   (producto ?p)
=>

(printout t "producto: " ?p crlf)

)

;===============================================================


