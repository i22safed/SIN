;Problema: Mostrar por pantalla un conjunto de comidas

;ELEMENTOS CONDICIONALES PATRÓN QUE USAN COMODINES
;Representación de la información mediante hechos ordenados

(deffacts hechos
  (comidas carne huevos pescado)
)
;Representación del conocimiento
(defrule r1
  (comidas $? ?x $? )
 =>
  (printout t ?x crlf)
) 


Problema: Valorar el uso en los elemento condicionales patrón conectores lógicos


(deftemplate datos-B
  (slot valor)
)
(deffacts h1
(datos-A verde) ;Hecho ordenado
(datos-A azul) ; Hecho definido a partir de una plantilla
(datos-B (valor rojo))
(datos-B (valor azul))
)

(defrule r1 (datos-A ~azul) => (printout t "Ha encajado con datos A verde" crlf))
(defrule r2 (datos-B (valor ~rojo&~verde)) => (printout t "No encaja con ninguno de los hechos" crlf))
(defrule r3 (datos-B (valor verde|rojo)) => (printout t "Ha encajado con cualquiera de los dos colores" crlf) )

 