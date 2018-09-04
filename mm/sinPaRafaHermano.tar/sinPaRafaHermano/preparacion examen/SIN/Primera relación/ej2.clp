(deftemplate paciente
	(slot nombre)
	(multislot apellidos)
	(slot dni)
	(slot seguro-medico))

(deftemplate visitas
	(slot fecha)
	(multislot sintomas)
	(multislot pruebas)
	(slot medicacion))

(deffacts hechos
(paciente (nombre Juan)(apellidos Gomez Sanchez)(dni 495416512)(seguro-medico si))

(paciente (apellidos Mora Ojeda)(nombre Carlos)(dni 56473937)(seguro-medico no))

(paciente (seguro-medico si)(nombre Alberto)(apellidos Perez Martinez)(dni 198749128))

(visitas (fecha 25-5-2005)(sintomas somnolencia inmovilidad)(pruebas las-justas y-necesarias) (medicacion gelocatil))

(visitas (medicacion paracetamol)(fecha 25-6-2005)(sintomas migraña tugraña)(pruebas las-justas y-necesarias)))