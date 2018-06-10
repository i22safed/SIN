


; Define una plantilla que permita almacenar informaci�n sobre libros, definiendo 
; las restricciones que consideres adecuadas para los atributos. Inserta una 
; serie de hechos en base a esta plantilla acerca de algunos de los libros de 
; la bibliograf�a de la asignatura, como por ejemplo los siguientes: 


; a. Mira, J.; Delgado, A. E.; Boticario, J. G., D�ez, F. J. Aspectos B�sicos 
; de la Inteligencia Artificial. Editorial Sanz y Torres. 1995. 
; b. Gal�n, S. F.; Boticario, J. G., Mira, J. Problemas Resueltos de 
; Inteligencia Artificial Aplicada: B�squeda y Representaci�n. Editorial 
; Addison-Wesley Iberoamericana S. A. 1998. 
; c. Rich, E., Knight, K. Inteligencia Artificial. 2� edici�n. McGraw-Hill
; Interamericana. 1994.


(deftemplate libro

	(slot nombre (type STRING))
	(multislot autores (type SYMBOL))
	(slot anio (type INTEGER))

)

(deffacts libros

	(libro (nombre "Aspectos Inteligencia Artificial")(autores J.Mira A.Delgado E.Boticario J. G.Diez)(anio 1995)) 

)