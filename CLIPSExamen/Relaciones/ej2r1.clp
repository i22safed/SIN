




; Representa mediante hechos no ordenados, los datos de varios pacientes 
; de un m�dico (nombre, apellidos, dni y seguro m�dico) y las visitas que 
; �stos realizan al m�dico (fecha, s�ntomas, pruebas y medicaci�n).


(deftemplate paciente

	(slot nombre)
	(slot apellidos)
	(slot DNI)
	(slot seguro-medico)

)

(deftemplate visita

	(slot fecha)
	(slot sintomas)
	(slot pruebas)
	(slot medicacion)

)

(deffacts visita-032 
	(paciente (nombre Pepi)(apellidos Suarez)(DNI 335566448) (seguro-medico si)) 
	(visita (fecha 28-07-18)(sintomas vomitos)(pruebas no)(medicacion viagra))
)
