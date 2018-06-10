



; Define una plantilla denominada persona que represente una relación de personas 
; con las siguientes cinco casillas simples: nombre, apellidos, colorojos, altura 
; y edad, indicando los tipos de cada campo (nombre y apellidos de tipo cadena, 
; color-ojos de tipo símbolo, altura de tipo float y edad de tipo entero) y un 
; valor por defecto para todos los campos excepto al nombre y a los apellidos.


(deftemplate persona 

	(slot nombre (type STRING))
	(slot apellidos (type STRING))
	(slot color-ojos (type SYMBOL)(default verdes))
	(slot altura (type FLOAT)(default 1.85))
	(slot edad (type INTEGER)(default 33))

) 

