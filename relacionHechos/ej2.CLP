

; 2. Representa mediante hechos no ordenados, los datos de varios pacientes de
; un médico (nombre, apellidos, dni y seguro médico) y las visitas que éstos
; realizan al médico (fecha, síntomas, pruebas y medicación).

; Ejercicio 2

(deftemplate pacientes
     (slot nombre)
     (multislot apellidos)
     (slot dni)
     (slot seguro-medico)
)

(deftemplate visitas
     (slot fecha)
     (multislot sintomas)
     (multislot pruebas)
     (slot medicacion)
     (slot dni)
)

(deffacts hechos

	(pacientes (nombre Juan) (apellidos Gomez Sanchez) (dni 495416512) (seguro-medico si))
	(pacientes (apellidos Mora Ojeda)(nombre Carlos)(dni 56473937)(seguro-medico no))
     	(pacientes (seguro-medico si)(nombre Alberto)(apellidos Perez Martinez)(dni 198749128))
     	(visitas (fecha 25-5-2005)(sintomas somnolencia inmovilidad)(pruebas las-justas y-necesarias)(medicacion gelocatil))
        (visitas (medicacion paracetamol)(fecha 25-6-2005)(sintomas migrana tugrana)(pruebas las-justas y-necesarias))
     
)
