(deftemplate familiar
	(slot nombre)
	(slot padre)
	(slot madre)
	(multislot hermanos)
	(multislot hijos))

(deffacts hechos
(familiar (nombre Pepe) (padre Jose) (madre Pilar) (hermanos Paco Luis))
(familiar (nombre Paco) (padre Jose) (madre Pilar) (hermanos Pepe Luis))
(familiar (nombre Luis) (padre Jose) (madre Pilar) (hermanos Paco Pepe))
(familiar (nombre Jose) (padre Antonio) (madre Antonia) (hijos Pepe Paco Luis)(hermanos Pedro))
(familiar (nombre Pilar) (padre Angel) (madre Angela) (hijos Pepe Paco Luis)))