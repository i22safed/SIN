


; Define una plantilla que permita almacenar información sobre libros, definiendo 
; las restricciones que consideres adecuadas para los atributos. Inserta una 
; serie de hechos en base a esta plantilla acerca de algunos de los libros de 
; la bibliografía de la asignatura, como por ejemplo los siguientes: 


; a. Mira, J.; Delgado, A. E.; Boticario, J. G., Díez, F. J. Aspectos Básicos 
; de la Inteligencia Artificial. Editorial Sanz y Torres. 1995. 
; b. Galán, S. F.; Boticario, J. G., Mira, J. Problemas Resueltos de 
; Inteligencia Artificial Aplicada: Búsqueda y Representación. Editorial 
; Addison-Wesley Iberoamericana S. A. 1998. 
; c. Rich, E., Knight, K. Inteligencia Artificial. 2ª edición. McGraw-Hill
; Interamericana. 1994.


(deftemplate libro

	(slot nombre (type STRING))
	(multislot autores (type SYMBOL))
	(slot anio (type INTEGER))

)

(deffacts libros

	(libro (nombre "Aspectos Inteligencia Artificial")(autores J.Mira A.Delgado E.Boticario J. G.Diez)(anio 1995)) 

)