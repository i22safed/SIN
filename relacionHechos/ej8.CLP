

; 8. Imagina que quieres preparar para almorzar pisto (ingredientes: pimientos
; verdes, pimientos rojos, berenjenas, calabacines, cebollas, tomate triturado,
; sal y aceite) y una tortilla de patatas (ingredientes: huevos, patatas,
; cebollas, aceite y sal). De los ingredientes necesarios tienes sólo
; algunos en la cocina (pimientos verdes, pimientos rojos, cebollas, aceite),
; por lo que tienes que ir a comprar el resto. Refleja esta situación en la base
; de hechos indicando los productos con los que cuentas y los que debes ir a
; comprar.
;
; Supón ahora que ya has vuelto de la compra, después de comprar todos
; los ingredientes que te faltaban. Actualiza la base de hechos de manera que
; quede reflejada esta nueva situación.
;
; Por último, considera la situación en la que ya has terminado de preparar el
; almuerzo utilizando los productos necesarios, y que como consecuencia de ello,
; se te han agotado algunos de dichos productos (cebolla y tomate triturado).
; Refleja esta situación en la base de hechos.


(deftemplate ingredientes
	(multislot disponibles
		(type STRING))
	(multislot no-disponibles
		(type STRING))
)

(deffacts antes

     (ingredientes (disponibles "pimientos-verdes" "pimientos-rojos" "cebollas"
      "aceite")
     (no-disponibles "berenjenas" "calabacines" "tomate-triturado" "sal"
     "huevos" "patatas"))

)

(deffacts compra

     (ingredientes (disponibles "pimientos-verdes" "pimientos-rojos" "cebollas"
      "aceite" "berenjenas" "calabacines" "tomate-triturado" "sal" "huevos"
      "patatas"))

)

(deffacts despues

     (ingredientes
          (disponibles "pimientos-verdes" "pimientos-rojos" "aceite"
          "berenjenas" "calabacines" "sal" "huevos" "patatas")
     (no-disponibles "cebollas" "tomate-triturado"))

)
