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
		(range 1 4)))