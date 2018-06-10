


; Describe la información representada en la figura, acerca de trayectos aéreos,
; mediante un conjunto de hechos no ordenados. Utiliza una única plantilla.


(deftemplate viaje
    (slot origen)
    (slot destino)
)

(deffacts viajes
     (viaje (origen Lisboa)(destino Paris))
     (viaje (origen Lisboa)(destino Madrid))
     (viaje (origen Paris)(destino Roma))
     (viaje (origen Estocolmo)(destino Paris))
     (viaje (origen Frankfurt)(destino Estocolmo))
     (viaje (origen Roma)(destino Frankfurt))
     (viaje (origen Roma)(destino Madrid))
     (viaje (origen Frankfurt)(destino Roma))
)
