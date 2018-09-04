;ejercicio 18
 
(deftemplate planta
(slot nombre)
(multislot caracteristicas)
) (
deftemplate puede-plantarse
(slot planta)
) (
deffacts plantas
(planta (nombre hortensia) (caracteristicas sombra ciudad maceta crecer-rapido))
(planta (nombre adelfa) (caracteristicas ciudad maceta cuidado-facil crecer-rapido))
(planta (nombre laurel) (caracteristicas frio sombra sequedad suelo-humedo ciudad cuidado-facil crecer-rapido))
(planta (nombre madreselva) (caracteristicas ciudad maceta cuidado-facil crecer-rapido))
(planta (nombre gardenia) (caracteristicas sombra suelo-acido maceta))
(planta (nombre enebro) (caracteristicas frio sequedad suelo-acido ciudad cuidado-facil))
(planta (nombre pimentero) (caracteristicas frio sombra suelo-humedo suelo-acido cuidado-facil))
(planta (nombre escaramujo) (caracteristicas frio sombra suelo-humedo ciudad cuidado-facil))
(planta (nombre aucuba) (caracteristicas sombra sequedad maceta cuidado-facil))
(planta (nombre azalea) (caracteristicas sombra suelo-humedo suelo-acido maceta)))
(deffacts caracteristicas-deseadas
(caracteristica-deseada sombra)
(caracteristica-deseada ciudad)
(caracteristica-deseada maceta)
(caracteristica-deseada crecer-rapido)
)
(defrule comprobar-planta
(planta (nombre ?y))
(forall (caracteristica-deseada ?x)
(planta (nombre ?y) (caracteristicas $? ?x $?)) )
(not (exists (and (planta (nombre ?y) (caracteristicas $? ?a $? ))
(not (caracteristica-deseada ?a) )
)
))
=>
(printout t "La planta " ?y " cuenta con las caracteristicas indicadas" crlf)
)