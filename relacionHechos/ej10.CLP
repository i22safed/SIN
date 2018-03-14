


; 10. Un profesor hace 2 exámenes durante el curso a sus alumnos. Además, los
; alumnos deben formar grupos para elaborar un trabajo que deberán exponer
; durante el curso, trabajo que será evaluado también mediante una nota.
;
; Define las plantillas necesarias para representar información sobre:
;
;   •  Apellidos del alumno.
;   •  Nombre del alumno.
;   •  Cuáles son los miembros de cada grupo.
;   •  Nota de cada uno de los exámenes, nota media de ambos y nota del trabajo.
;
; Además, deben contemplarse las siguientes restricciones:
;
;   •  El usuario debe dar siempre valor a los atributos correspondientes a
;   apellidos y nombre.
;   •  Las notas deben tomar valores entre 0 y 10.
;   •  Un grupo puede estar formado por un máximo de 4 personas.

(deftemplate alumno
	(slot nombre
		(type STRING)
		(default ?NONE))
	(multislot apellidos
		(type STRING)
		(default ?NONE))
	(slot grupo
		(default ?NONE))
	(slot notaExamen1
		(range 0 10))
	(slot notaExamen2
		(range 0 10))
	(slot notaMedia
		(range 0 10))
	(slot notaTrabajo
		(range 0 10))
)

(deftemplate grupo
	(multislot nombreParticipantes)
	(slot numParticipantes
		(range 1 4))

)
