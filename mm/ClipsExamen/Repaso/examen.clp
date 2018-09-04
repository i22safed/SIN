



; Consiste en meter en un vector los datos sin borrarlos para luego 


	(deftemplate datos 
		
		( multislot values (type INTEGER))) 	; Declaramos un vector para cada uno de los values que tenemos en la base de hechos

	(deftemplate todos-los-datos 
		
		( multislot values (type INTEGER)))	; Vector final donde tendremos todos los elementos ordenados 


	(deffacts hechos

		( datos ( values 3 5 10 11)) 
		( datos ( values 1 4 5 10))) 


; Declaramos las reglas con las que actuaram sobre el vector que seran pasar las variables al vector, concatenar y ordenar



	(defrule pasarAVector 
	
		( datos ( values $?ant ?x $siguiente)) 	; Seria como el indice del vector 
		(not  ( todos-los-datos ( values ?x)))	; 

		=>

		(assert (todos-los-datos (values ?x)))	