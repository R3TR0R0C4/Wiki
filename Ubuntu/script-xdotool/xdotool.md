# Automatización de xdotool y crontab

La idea de este script es lanzar un comando, por ejemplo un "Ctrl. + R" a una ventana de Chrome. Para esto usaremos [xdotool](https://github.com/jordansissel/xdotool) para lanzar los comandos, y crontab para programar cuando se lanza el script.

<br>

## Previo

El sistema en el que se ha probado este script corre un Ubuntu 22.04, con Wayland como gestor de ventanas, xdotool no soporta plenamente este gestor de ventanas, pero en mi caso concreto no me ha dado problemas.

<br>

## Instalación 

Los únicos paquetes requeridos son xdotool y crontab, que podemos instalar con el gestor de paquetes que queramos:

`sudo apt update && sudo apt install -y xdotool crontab`

<br>

## Script

Situaremos el script en `/opt/` con permisos al usuario root, los permisos 755 por defecto del archivo son suficientes para nuestro caso.

`sudo nano /opt/script.sh`

Es necesario modificar el script en las partes:

* `export DISPLAY=:1`, el número de pantalla lo obtendremos de la variable de sistema "DISPLAY", la podemos ver con `echo $DISPLAY`.
* `window_id=$(xdotool search --name "localhost")`, cambiaremos "localhost" por el nombre de la pestaña de Chrome a buscar.
* `xdotool key ctrl+r`, podemos modificar "ctrl+r" para cambiar que teclas o combinación de estas se mandan a la pestaña.

<br>

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

Una vez terminemos el script añadiremos permisos de ejecución al usuario:

`chmod u+x /opt/script.sh`

Ya a todavía se ejecuta el servidor X de pantallas añadiremos el usuario actual para que pueda mandar comandos a este con el siguiente comando:

`xhost +local:`

`xhost +si:localuser:root`

<br>

## Crontab

Añadiremos configuración a crontab, es importante hacer-lo en usuario root, o con sudo, y con la opción '-e' para editar la configuración.

`sudo crontab -e `

*Nota:* Si es la primera vez que ejecutamos 'crontab -e', nos pedirá que seleccionemos nuestro editor predeterminado, usaremos nano (opcion 1).

Y esta es la configuración de crontab, básicamente ejecuta nuestro script a cada hora de cada día en el minuto 0.   

`0 * * * * /opt/script.sh`
