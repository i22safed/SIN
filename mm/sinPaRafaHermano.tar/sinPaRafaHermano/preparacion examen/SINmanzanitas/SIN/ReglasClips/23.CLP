;Ejercicio 23

(deftemplate producto 
 (slot nombre) 
 (slot pvp)) 

;almacena lo productos que quiere un cliente
(deftemplate compra 
 (slot productos)
 (slot unidades)) 

;productos que hay en la tienda
(deffacts product
	(producto(nombre pan)(pvp 1))
	(producto(nombre aceite)(pvp 2))
	(producto(nombre tomate)(pvp 3))
)

;producto que el cliente quiere
(deffacts cliente_compra
	(compra(productos pan) (unidades 1))
	(compra(productos aceite)(unidades 2))
	(compra(productos tomate)(unidades 2))
)
(deffacts precio 
	(precio )
)
;tengo que mirar el nombre y el producto que sean igual.
;cuando tengo el nombre de los productos iguales multiplico el pvp con el numero de unidades. 

(defrule trespordos
	(producto(nombre ?x)(pvp ?r))
	(compra(productos ?x)(unidades ?y))
	;compruebo que el numero de unidades es 2 para darle otra unidad (3x2)
	(compra(unidades ?y&:(= ?y 2)))
	=>
	(assert(..:LISTA DE LA COMPRA:..))
	(assert(tienes un 3x2 en ?x))
	(assert(producto: ?x --> precio (* ?y ?r)))
	)

(defrule compra
	;de esta forma estoy comparando que el nombre del producto y de la compra sea el mismo 
	(producto(nombre ?x)(pvp ?r))
	(compra(productos ?x)(unidades ?y))
	=>
	(assert(..:LISTA DE LA COMPRA:..))
	(assert(producto: ?x --> precio(* ?y ?r))
	)
	
)

	
	
	
	
	