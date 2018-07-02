(deftemplate libro
	(slot nombre
		(type STRING)
		(default ?NONE))
	(slot editorial)
	(slot año
		(type INTEGER)
		(default ?NONE))
	(multislot autores
		(type STRING)
		(default ?NONE))
	(slot edicion))

(deffacts hechos
(libro (nombre "Aspectos-Basicos-De-La-Inteligencia-Artificial") (editorial "Sanz-y-Torres") (año 1995) (autores "F.J-Diez" "J.Mira" "E.A" "J.G-Boticario"))
(libro (nombre "ProblemasResueltosDeInteligenciaArtificialAplicada") (editorial "Addison-Wesley-Iberoamericana") (año 1998) (autores "J.Mira" "S.Galan" "J.G-Boticario"))
(libro (nombre "Inteligencia-Artificial") (editorial "McGraw-Hill-Americana") (año 1994) (autores "K.Knight" "E.Rich")))