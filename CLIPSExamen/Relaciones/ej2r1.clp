




; Representa mediante hechos no ordenados, los datos de varios pacientes 
; de un médico (nombre, apellidos, dni y seguro médico) y las visitas que 
; éstos realizan al médico (fecha, síntomas, pruebas y medicación).


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
