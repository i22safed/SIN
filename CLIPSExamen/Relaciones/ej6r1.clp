



; Define las plantillas necesarias para almacenar la información relativa a los 
; coches disponibles en un concesionario de coches y a las ventas que hace cada 
; vendedor. El concesionario (de la casa Renault) dispone de los siguientes coches
; y ha realizado dos ventas: 
; • 1 Clio 1.600 gasolina 3 puertas color azul. 
; • 1 Clio diesel 1.800 5 puertas color blanco. 
; • 1 Megane diesel 1.800 5 puertas color dorado. 
; • 2 Megane gasolina 1.600 5 puertas color gris. 
; • 1 Laguna gasolina 2.000 5 puertas color negro. 
; • Juan Pérez vendió un Megane el 10/10/2003 al cliente Esteban Losada. 
; • Ana Ballester vendió un Laguna el 13/10/2003 al cliente Juan Cano. 

(deftemplate coche 

	(slot modelo)
	(slot cilindrada)
	(slot combustible)
	(slot color)
	(slot puertas (allowed-values 3 5))

)

(deftemplate venta 

	(multislot comprador)
	(multislot vendedor)
	(slot modelo)
	(slot fecha)

)

(deffacts hechos 

	(coche (modelo Clio)(cilindrada 1600)(combustible  gasolina )(puertas 3)(color  azul ))
	(coche (modelo  Clio)(cilindrada 1800)(combustible  diesel )(puertas 5)(color  blanco ))
	(coche (modelo  Megane )(cilindrada 1800)(combustible  diesel )(puertas 5)(color  dorado ))
	(coche (modelo  Megane )(cilindrada 1600)(combustible  gasolina )(puertas 5)(color  gris ))
	(coche (modelo  Laguna )(cilindrada 2000)(combustible  gasolina )(puertas 5)(color  negro ))
	(venta (comprador Esteban Losada)(vendedor  Juan Perez)(modelo Megane)(fecha 10-10-2003))
	(venta (comprador  Juan Cano)(vendedor  Ana Ballester)(modelo Laguna)(fecha 13-10-2003))

)


