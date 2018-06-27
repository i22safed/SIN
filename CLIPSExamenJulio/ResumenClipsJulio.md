

## Resumen CLIPS

### Tema 1. Introducción a los sistemas de producción

#### Sistemas de Producción

Las Reglas de Producción son reglas del tipo ***Si-Entonces***.

Las características de los Sistemas de producción:

* Se utilizan las reglas para examinar un conjunto de datos y solicitar nueva información hasta llegar a un diagnostico.
* También se denominan Sistemas basados en reglas

![Componentes de los Sistemas de Producción ](C:\Users\david\Documents\GitHub\SIN\CLIPSExamenJulio\ComponentesSP.PNG)

**Componentes**
* **Base de conocimientos**
  *Todos los hombres son animales*
  *Todos los animales respiran*
* **Base de afirmaciones**
  *Juan es un hombre*
* **Inferencia**
  *Juan respira*

**Reglas de producción**

La estructura general de las reglas son: ***Antecedente → Consecuente***. Donde:
* **Antecedente**: Contiene las claúsulas que deben de cumplirse  para que la regla pueda ejecutarse
* **Consecuente**: Indica las conclusiones que se deducen de las premisas o las acciones que el sistema debe realizar cuando ejecuta la regla.

**Inferencia**

* Una regla se ejecuta (dispara) cuando se cumple su antecedente
* Las reglas se ejecutan hacia adelante: **Si se satisface el antecedente se efectúan las acciones del consecuente**
* Tipos de encadenamiento de reglas:
  - Encadenamiento hacia adelante o **basado en datos**.
  - Encadenamiento hacia detrás o basado en objetivos.

**Control de Razonamiento**
Se encarga de seleccionar una regla cuando hay varias disponibles. Métodos de resolución de conflictos:
* Ordenación de reglas
* Añadir nuevas cláusulas relacionadas con las inferencias
* Control mediante *Agenda*
* Conjunto de Reglas [...]

### Tema 2. Visión general de CLIPS

#### Componentes de CLIPS

* Interprete
* Interfaz interactivo
* Facilidades para la depuración
* Elementos de la Shell
  + Lista de hechos
  + Base de conocimientos
  + Motor de inferencia
* Dirigido por datos: Las reglas pueden emparejar con objeto y hechos.

#### Tipos de datos primitivos

* Entero (*integer*)
* Reales (*float*)
* Simbolo (*symbol*)
* Cadena (*string*)
* Direccion externa (*external-address*)
* Direccion de hecho (*fact-address*)
* Nombre de instancia
* Direccion de instancia (*instance-address*)

##### Otros conceptos

* **Campo**: Valor que puede tomar una variable
* **Tipos de campos dependiendo del valor que puedan tomar**:
  + Monocampo: Tipos de datos primitvos
  + Multicampo: Varios valores uni-campo
* **Constante**
* **Variable**


#### Ejemplos

* ```?<nombre>``` → monocampo (ámbito local)
* ```$?<nombre>``` → multicampo (ámbito local)
* ```?*<nombre>*``` → ambos (ámbito global)



#### Funciones

* **Lenguaje externo**
  + Funciones definidas por el usuario
  + Funciones definidas por el sistema

* **Funciones de CLIPS**
  + Funciones
  + Funciones genericas

* **Tipos**
  + Órdenes: Ejecutan una acción
  + Funciones: Devuelven un valor

* **Notación prefija para llamada**
  + ((nombrefuncion argumentos) → ```(+(* 3 4) 8 )```)

#### Constructores

* **defmodule** → Define un módulo  
* **defrule** → Define una regla
* **deffacts** → Define un hecho o conjunto de estos
* **deftemplate** → Define una plantilla
* **defglobal** → Define una variable global
* **deffunction** → Define una función
* **defclass** → Define una clase
* **definstances** → Define una instancia
* [...]



### Tema 3. Representación de Hechos en CLIPS

#### Representación de la información

Mediante:
* **Hechos**: Ordenados y no ordenados. Indice y dirección.
* **Objetos**: POO. Instancias de objetos.
* **Variables globales**: Constructor defglobal.  

##### Hechos: Ordenes de uso
**Órdenes de utilización de hechos**:
* **assert** → Introduce datos en la base de hechos. *Se puede utilizar tambien deffacts*
* **facts** → Sirve para ver la base de hechos con formato ```f-índice (hecho)```
* **undefacts** → Suprime los hechos insertados por una orden *deffacts*
* **ppdefacts** → Muestra la definición de un hecho definido por la orden *deffacts*
* **list-defacts** → Muestra los hechos definidos con *deffacts*
* **retract** → Elimina hechos de la base de hechos, se debe especificar el nombre o el indice del hecho se pueden eliminar varios hechos de golpe (retrat hecho1 hecho 2 .. ) o eliminar todos con (retract \*)
* **modify** → Modifica un hecho de la base de hechos
* **duplicate** → Duplica un hecho de la base de hechos
* **deftemplate** → Define una plantilla
* **ppdeftemplate** → Muestra una plantilla definida
* **undeftemplate** → Elimina una plantilla definida
* **deffacts** → Define un conjunto de hechos
* **reset** → Añade cada hecho especificado con *deffacts* en la lista de hechos o factlist. Tambien añade el hecho *initial-fact*. Tambien dice que borra hechos e inserta hecho especial (?).
* **clear** → Limpia la base de hechos. Reinicializa el indice de hechos a 0 y elimina la base de conocimiento


##### Hechos: comandos
```
  (assert <hecho>+)
  (facts [<inicio> [<final> [máximo]]])
  (retract <índice>+ |*)
  (modify <índice> <nueva-casilla>+)
  (duplicate <índice> <nueva-casilla>+)
    <nueva-casilla>::= (<nombre> <valor>)
```

##### Hechos: Tipos y Ejemplos
* **Ordenados** → ```(casa calle-nueva 32)```
* **No ordenados (Realizados mediante plantillas)**: ```(coche (marca ford)(modelo fiesta))```
  + El orden de los campos no es importante
  + Se pueden modificar utilizando las órdenes (modify) y (duplicate)

##### Hechos: Dirección

```
(defrule comenzar
    ?h <- (iniciar-programa)
  =>
    retract(?h)
    (printout t "Iniciando..." crlf)
)
```

##### Hechos: Ejemplos de plantillas

```
  (deftemplate nombre-plantilla
      (slot nombre)
      (multislot apellidos)
      (slot DNI)
  )
```


### Tema 4. Hechos definidos a partir de plantillas

#### Sintaxis del constructor deftemplate

```
(deftemplate persona
  (slot nombre)
  (multislot apellidos)
  (slot DNI))
```
Y su respectivo hecho con el cual empareja

```
(persona (nombre Juan)(apellidos Perez Perez) (DNI 43765873B))
```

##### Propiedades de los slots

* default-attribute: puede tener la necesidad o no de que el hecho tenga que tener ese campo a huevos

  + ?NONE: no es necesario un argumento para ese campon
  + ?DERIVE: es obligatorio el argumento

```
(deftemplate dato
  (slot x (default ?NONE))
  (slot y (default ?DERIVE))
)

```

* type: reestriccion de tipo para los slots, es decir, dicho slot debe llevar una variable de un determinado tipo (SYMBOL, FLOAT, INTEGER, NUMBER, STRING, ...)

```
(deftemplate dato
  (slot x (type STRING))
  (slot y (type NUMBER))
)

```
Dentro de esta reestriccion se puede incluir otra mas severa, acotando mas el rango
```
(deftemplate dato
  (slot x (allowed-symbols Pepe))
  (slot y (allowed-integer 6 5 9))
  (slot z (allowed-values "Ricardo" rico 99 1.e9))
)
```
Siendo posible acotar para los distintos tipos existentes en CLIPS. Siendo posible especificar rangos como se indica en el siguiente ejemplo

```
(deftemplate dato
  (slot x (allowed-symbols Pepe))
  (slot y (type integer)(range 8 90))
)
```

### Tema 5. Reglas

El formato de una regla es *if-else*, es decir, si el antecedente es verdadero entonces se ejecuta el consecuente.

* Base de conocimiento: Conjunto de reglas que describen el problema a resolver
* Activación de reglas: Entidad patrón → hechos ordenados o plantillas, e instancias de clases
* Motor de inferencia: Comprueba el antecedente de las reglas y aplica el consecuente

#### Definición de reglas

Se realiza mediante el constructor defrule, y posee el siguiente formato:

```
(defrule regla1
  (frigorifico abierto)
  =>
  (comida mala)
)
```
* Consideraciones
  + En caso de que haya una regla con el mismo nombre, la última machaca a la anterior
  + No hay limite en el numero de elementos condicionales y acciones de una regla
  + Puede no haber ningún elemento condicional en el antecedente y se usa automaticamente como elemento condicional
  + Puede no haber ninguna acción en el consecuente, y la ejecución de la regla no tiene ninguna consecuencia

#### Ciclo de ejecución de reglas
* Las regla se ejecutan con el comando (run <máximo>)
* Si se ha alcanzado el numero máximo de disparos, se detiene la ejecución
* Se actualiza la agenda según la lista de hechos
* Se selecciona la instancia de regla a ejecutar de acuerdo a prioridades y estrategia de resolución de conflictos
* Se dispara la instancia seleccionada, se incrementa numero de disparos y se elimina de la agenda
* Volver al paso 2


#### Sintaxis del antecedente
El antecedente está compuesto por una serie de elementos condicionales. Son un conjunto de reestricciones que se usan para verificar si se cumple un campo o slot de una entidad patrón.
* EC patron
* EC test
* EC and
* EC or
* EC not
* EC exists
* EC forall
* EC logical

Las distintas reestricciones son:
* Literales → Define el valor exacto que debe de poseer el campo, solo posee constantes.
* Comodines → Indican que cualquier valor en esa posición en válido para emparejar con la regla
  + Comodín monocampo → ?
  + Comodín multicampo → $?
* Variables →
* Conectivas
* Predicados
* Valores devueltos
* Direcciones de hechos

Siendo el siguiente formato el obligatorio para realizar la comparacion

* Para hechos ordenados → (<restriccion1> ... <restriccionN>)
* Para hechos no ordenados → (<nombre-deftemplate> ... (<nombre-slot1><restriccion1>))
