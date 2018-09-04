; Ejercicio 1

; Define una plantilla denominada persona que represente una relación de 
; personas con las siguientes cinco casillas simples: nombre, apellidos, 
; color-ojos, altura y edad, indicando los tipos de cada campo (nombre y 
; apellidos de tipo cadena, color-ojos de tipo símbolo, altura de tipo 
; float y edad de tipo entero) y un valor por defecto para todos los 
; campos excepto al nombre y a los apellidos.


(deftemplate persona 
	
	(slot nombre(TYPE STRING))
	(slot apellidos(TYPE STRING))
	(slot color-ojos(TYPE SYMBOL)(default VERDES))
	(slot altura(TYPE FLOAT)(default 1.85))
	(slot edad(TYPE INTEGER)(default 22))

)