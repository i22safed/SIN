(deftemplate ingredientes
	(multislot disponibles
		(type STRING))
	(multislot no-disponibles
		(type STRING))
)

(deffacts antes
(ingredientes (disponibles "pimientos-verdes" "pimientos-rojos" "cebollas" "aceite") 
(no-disponibles "berenjenas" "calabacines" "tomate-triturado" "sal" "huevos" "patatas")))

(deffacts compra
(ingredientes (disponibles "pimientos-verdes" "pimientos-rojos" "cebollas" "aceite" "berenjenas" "calabacines" "tomate-triturado" "sal" "huevos" "patatas")))

(deffacts despues
(ingredientes 
(disponibles "pimientos-verdes" "pimientos-rojos" "aceite" "berenjenas" "calabacines" "sal" "huevos" "patatas") 
(no-disponibles "cebollas" "tomate-triturado")))