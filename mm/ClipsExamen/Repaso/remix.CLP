

(deffacts hechos-b   

	(v 28 91 1 4 7 9))  

(defrule r2    

	(v $?antes ?x $?despues )  
	(not (v $?antes1 ?y&:(> ?y ?x) $?despues1))  
	
	=>    

	(printout t ?x crlf ))