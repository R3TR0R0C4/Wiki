# Creación de un dominio AD

## Pasos previos

Nos aseguraremos de tener nuestros adaptadores de red configurados correctamente, "Ethernet0" actuara como un adaptador NAT que dará servicio a nuestro servidor, y lo mantendremos en DHCP, mientras que "Ethernet1" dará servicio a nuestra red interna y lo configuraremos con la IP '172.40.0.1/24', sin un DNS (por el momento), sin gateway, y con "IPv6" desactivado.


![](./img/01.png)

## Instalación

Para configurar un controlador de dominio usaremos "Agregar roles y características":

![](./img/02.png)

<br>

Seleccionaremos una instalación basada en características o roles:

![](./img/03.png)

<br>

Seleccionamos `Servicios de dominio de Active Directory`:

![](./img/04.png)

<br>

Comprobamos que instalamos los roles que queremos:

![](./img/05.png)

<br>

Y confirmamos que se instala sin problema:

![](./img/06.png)

<br>

## Configuración

Una vez terminada la instalación, en el apartado de avisos, podemos ver la opción para "Promover este servidor a controlador de dominio":

![](./img/07.png)

<br>

Seleccionaremos la opción "Agregar nuevo bosque":

![](./img/08.png)

<br>

Introducimos nuestra contraseña:

![](./img/09.png)

<br>

Revisamos las opciones, y, podemos descargar un script para, si en un futuro, queremos añadir un controlador secundario.

[Script](./scripts/script-promover-controlador.txt)

![](./img/10.png)

<br>

Comprobamos los requisitos previos, habrá algunos avisos que vamos a ignorar.

![](./img/11.png)

<br>

Y comprobamos que se han realizado los cambios:

![](./img/12.png)

<br>

Una vez reiniciado, podemos ver que nuestro usuario administrador se inicia sobre el dominio:

![](./img/13.png)

<br>

Y en el administrador de servidor, podemos ver un apartado para "AD DS" y "DNS" sin errores:

![](./img/14.png)
