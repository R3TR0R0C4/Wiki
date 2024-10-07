# Cración de un dominio AD


## Pasos previos

Nos aseguraremos de tener nuestros adaptadores de red configurados correctamente, "Ethernet0" actuarà como un adaptador NAT que darà servicio a nuestro servidor, y lo mantedremos en DHCP, mientras que "Ethernet1" darà servicio a nuestra red interna y lo configuraremos con la ip `172.40.0.1/24`, sin un dns (por el momento), sin gateway, y con "IPv6" desactivado.

![](./img/01.png)

## Instalacion

Para configurar un controlador de dominio usaremos "Agregar roles y características":

![](./img/02.png)

<br>

Seleccionaremos una instalacion basada en caracteristicas o roles:

![](./img/03.png)

<br>

Seleccionamos `Servicios de dominio de Active Directory`:

![](./img/04.png)

<br>

Comprovamos que instalamos los roles que queremos:

![](./img/05.png)

<br>

Y confirmamos que se instala sin problema:

![](./img/06.png)

<br>

## Configuracion

Una vez terminada la instalacion, en el apartado de avisos, podemos ver la opción para "Promover este servidor a controlador de dominio":

![](./img/07.png)

<br>

Seleccionaremos la opcion "Agregar nuevo bosque:

![](./img/08.png)

<br>

Introducimos nuestra contraseña:

![](./img/09.png)

<br>

Revisamos las opciones, y, podemos descargar un script para, si en un futuro, queremos añadir un controlador secundario.

[Script](./scripts/script-promover-controlador.txt)

![](./img/10.png)

<br>

Comprovamos los requisitos previos, habrà algunos avisos que vamos a ignorar.

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