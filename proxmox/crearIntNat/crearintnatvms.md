## Crear una interfaz NAT para las Máquinas Virtuales

Es necesario contar con una conexión a internet. Por defecto, las instalaciones de Proxmox crean un Linux Bridge en la interfaz seleccionada durante la instalación, generalmente llamada `vmbr0`. En este caso, vamos a crear una nueva interfaz, `vmbr1`, que no estará vinculada a ninguna de las interfaces físicas y usará iptables para realizar NAT. De esta manera, las máquinas virtuales podrán utilizar la IP del host Proxmox.


Esta és la configuración de la interfaz `vmbr0`:

![](./img/)

Debajo de esta crearemos la configuración de `vmbr1`:

```
auto vmbr1
iface vmbr1 inet static

```

Despues editamos `/etc/` y añadimos:


Y por ultimo aplicamos las reglas de iptables:

Las haremos persistentes, instalando `apt install iptables-persistent`

$ sudo iptables-save > /etc/iptables/rules.v4
