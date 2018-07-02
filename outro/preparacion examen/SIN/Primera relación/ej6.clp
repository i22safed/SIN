(deftemplate coche
	(slot tipo)
	(slot cc
		(type INTEGER))
	(slot combustible
		(type SYMBOL)
		(allowed-values gasolina diesel))
	(slot puertas
		(type INTEGER))
	(slot color))

(deftemplate venta
	(slot nombreVendedor)
	(slot coche)
	(slot fecha)
	(slot nombreCliente))

(deffacts hechos
(coche (tipo clio) (cc  1600) (combustible gasolina) (puertas 3) (color azul))
(coche (tipo clio) (cc  1800) (combustible diesel) (puertas 5) (color blanco))
(coche (tipo megane) (cc  1800) (combustible diesel) (puertas 5) (color dorado))
(coche (tipo megane) (cc  1600) (combustible gasolina) (puertas 5) (color gris))
(coche (tipo megane) (cc  1600) (combustible gasolina) (puertas 5) (color gris))
(coche (tipo laguna) (cc  2000) (combustible gasolina) (puertas 5) (color negro))
(venta (nombreVendedor "Juan Pérez") (coche megane) (fecha 10-10-2003) (nombreCliente "Esteban Losada"))
(venta (nombreVendedor "Ana Ballester") (coche laguna) (fecha 13-10-2003) (nombreCliente "Juan Cano")))