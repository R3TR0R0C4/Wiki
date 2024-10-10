# Automatización de xdotool y crontab

La idea de este script es lanzar un comando, por ejemplo un "Ctrl. + R" a una ventana de chrome. Para esto usaremos [xdotool](https://github.com/jordansissel/xdotool) para lanzar los comandos, y crontab para programar cuando se lanza el script.

## Previo

El sistema en el que se ha probado este script corre un Ubuntu 22.04, con Wayland como gestor de ventanas, xdotool no soporta plenamente este gestor de ventanas, pero en mi caso concreto no me ha dado problemas.

## Instalacion 

Los unicos paquetes requeridos son xdotool y crontab, que podemos instalar con el gestor de paquetes que queramos:

`sudo apt update && sudo apt install -y xdotool crontab`

## Script

Situaremos el script en `/opt/` con permisos al usuario root, los permisos 755 por defecto del archivo son suficientes para nuestro caso.

`sudo nano /opt/script.sh`

És necesario modificar el script en las partes:

* `export DISPLAY=:1`, el numero de pantalla lo obtendremos de la variable de sistema "DISPLAY", la podemos ver con `echo $DISPLAY`.
* `window_id=$(xdotool search --name "localhost")`, cambiaremos "localhost" por el nombre de la pestaña de chrome a buscar.
* `xdotool key ctrl+r`, podemos modificar "ctrl+r" para cambiar que teclas o combinación de estas se mandan a la pestaña.


```
#!/bin/bash

export DISPLAY=:"1"
export XAUTHORITY=/root/.Xauthority
{
window_id=$(xdotool search --name "localhost")

xdotool windowactivate $window_id
sleep 2

xdotool key ctrl+r
}
```

Una vez terminemos el script añadiremos permisos de ejecucion al usuario:

`chmod u+x /opt/script.sh`

Ya a todavia se ejecuta el servidor X de pantallas añadiremos el usuario actual para que pueda mandar comandos a este con el siguente comando:

`xhost +local:`

## Crontab

Añadiremos configuración a crontab, es importante hacer-lo en usuario root, o con sudo, y con la opción `-e` para editar la configuracion.

`sudo crontab -e `

*Nota:* Si es la primera vez que ejecutamos `crontab -e`, nos pedirà que seleccionemos nuestro editor predeterminado, usaremos nano (opcion 1).

Y esta és la configuración de crontab, basicamente ejecuta nuestro script a cada hora de cada dia en el minuto 0.

`0 * * * * /opt/script.sh`