# HW - OS Hardening Script.

## Descripción.
Script en bash para la hardenización de SO, el cual lo que va haciendo lo manda a un archivo log que lo almacena en /var/log, paso a paso. 

Las configuraciones que realiza son:
* Actualizacion de paquetes del sistema.
* Politicas de usuarios.
* Configuraciones de redes y conexiones.
* Inicios de sesións.

Este script necesita de 2 argumentos:
1. Matrícula.
2. Nombre

A continuación te muestro como se correría el script:
`$ ./HardeningOS.sh <Matricula> <Nombre>`
