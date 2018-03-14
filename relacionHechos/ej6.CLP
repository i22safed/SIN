

; 6. Define las plantillas necesarias para almacenar la información relativa a
; los coches disponibles en un concesionario de coches y a las ventas que hace
; cada vendedor. El concesionario (de la casa Renault) dispone de los siguientes
; coches y ha realizado dos ventas:
;   - 1 Clio 1.600 gasolina 3 puertas color azul.
;   - 1 Clio diesel 1.800 5 puertas color blanco.
;   - 1 Megane diesel 1.800 5 puertas color dorado.
;   - 2 Megane gasolina 1.600 5 puertas color gris.
;   - 1 Laguna gasolina 2.000 5 puertas color negro.
;   - Juan Pérez vendió un Megane el 10/10/2003 al cliente Esteban Losada.
;   - Ana Ballester vendió un Laguna el 13/10/2003 al cliente Juan Cano.


(deftemplate coche
	(slot tipo)
	(slot cc
		(type INTEGER))
	(slot combustible
		(type SYMBOL)
		(allowed-values gasolina diesel))
	(slot puertas
		(type INTEGER))
	(slot color)
)

(deftemplate venta
	(slot nombreVendedor)
	(slot coche)
	(slot fecha)
	(slot nombreCliente)
)

(deffacts hechos

     (coche (tipo clio) (cc  1600)
     (combustible gasolina)
     (puertas 3)
     (color azul))

     (coche (tipo clio)
     (cc  1800)
     (combustible diesel)
     (puertas 5)
     (color blanco))

     (coche (tipo megane)
     (cc  1800)
     (combustible diesel)
     (puertas 5)
     (color dorado))

     (coche (tipo megane)
     (cc  1600)
     (combustible gasolina)
     (puertas 5)
     (color gris))

     (coche (tipo megane)
     (cc  1600)
     (combustible gasolina)
     (puertas 5)
     (color gris))

     (coche (tipo laguna)
     (cc  2000)
     (combustible gasolina)
     (puertas 5)
     (color negro))

     (venta (nombreVendedor "Juan Pérez")
     (coche megane)
     (fecha 10-10-2003)
     (nombreCliente "Esteban Losada"))

     (venta (nombreVendedor "Ana Ballester")
     (coche laguna)
     (fecha 13-10-2003)
     (nombreCliente "Juan Cano"))

)
