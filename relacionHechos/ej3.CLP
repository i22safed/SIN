

; 3. Describe la información representada en la figura, acerca de trayectos
; aéreos, mediante un conjunto de hechos no ordenados. Utiliza una única
; plantilla.


(deftemplate viaje

	(multislot origenes)
	(slot actual)
	(multislot destinos)

)

(deffacts hechos

     (viaje (destinos Paris Madrid) (actual Lisboa) (origenes Roma))
     (viaje (destinos Roma) (actual Paris) (origenes Lisboa Estocolmo))
     (viaje (destinos Paris) (actual Estocolmo) (origenes Frankfurt))
     (viaje (destinos Estocolmo) (actual Frankfurt) (origenes Roma))
     (viaje (destinos Madrid Lisboa) (actual Roma) (origenes Frankfurt Paris))
     (viaje (actual Madrid) (origenes Roma Lisboa))

)
