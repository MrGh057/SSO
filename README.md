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

NOTA: si se presenta un error como el siguiente: "./HardeningScript_SSO.sh: línea 39: $'\r': orden no encontrada." se debe a que la el script fue desarrollado en windows, por tanto toma una arquitectura en windows, hay que mover el formato utilizando el siguiente comando:

`dos2unix HardeningScript_SSO.sh`

O utilizar el siguiente comando:

`sed -i 's/\r//' HardeningScript_SSO.sh`