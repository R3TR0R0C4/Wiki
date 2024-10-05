## Instalación de paquetes

- Instalamos "bind9" y "dnsutils" con apt:

`sudo apt install bind9 dnsutils`

![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/e2926197-5867-44ba-82be-a2619781f121)


## Configuraciónes
Hay varias formas de configurar bind9, puede ser como un servidor caché, servidor primario o servidor secundario:

- [Como servidor caché](bind9install.md#configuración-como-servidor-caché), bind9 guardará la información de las consultas que se hacen a servidores externos (como 1.1.1.1, o 8.8.8.8).
- [Como servidor primario](bind9install.md#configuración-como-servidor-primario), El servidor leerá los datos de una zona (ej. 192.168.0.0/24) a partir de un archivo host y será autoritario de dicha zona.
- [Como servidor secundario](bind9install.md#configuración-como-servidor-secundario), El servidor obtendrá los datos de zona desde otro servidor DNS que sea autoritario de dicha zona (un servidor primario).


### Configuración como servidor caché
Para configurar el servidor como dns caché, necesitaremos dns-forwarders, estos son los servidores que se consultarán para la primera vez que se consulte un dominio.

* Para configurar el servicio necesitamos editar el archivo `/etc/bind/named.conf.options` con un editor de texto:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/0c57181c-c063-4eb7-81c9-80a777864955)

  Y necesitaremos quitar los comentarios de las líneas de forwarders de abrir a cerrar:

  [Archivo named.conf.options](named.conf.options/named.conf.options)

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/b32316b9-dc60-405c-978f-5446b249e582)
<br>
  Para comprobar que funciona correctamente usaremos nslookup, podemos ver que si indicamos el servidor local quien nos responde es 192.168.0.31, podemos ver que nos responde correctamente:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/8c750418-cd8c-4ab4-b212-5004b210cd34)

<br>
<br>

---

### Configuración como servidor primario

#### Configuración archivos de zona directa

  Para configurar un servidor DNS primario, necesitaremos establecer los forwarders también como en la [configuración anterior](bind9install.md#configuración-como-servidor-caché)

  Necesitaremos crear una zona en el directorio, lo más fácil es usar el archivo `/etc/bind/db.empty` como plantilla no debemos borrar este archivo así que usaremos la orden cp:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/2ffebbef-7021-40fd-bfaf-002681fee48d)

  Después editaremos el archivo con un editor de texto:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/a69588d0-2d9e-471d-ac99-f4c4b55dc09c)

  Este es un ejemplo de configuración: [db.roca.home](configZonas/zonadb.roca.home)

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/c1c2c372-4f45-4496-8550-e43fa2d50c34)

  Necesitaremos cambiar `localhost.` por nuestro dominio, en mi caso `roca.home` (en el caso de configurar servidores secundarios, este campo suele rellenarse con ns1.dominio.tld) y luego el FQDN que pasará de ser `root.localhost.` a `root.roca.home.`

  Y añadiremos una línea nueva por cada registro.

#### Configuración de zonas

  Después necesitamos editar `/etc/bind/named.conf.local`

  Por cada zona nueva necesitaremos añadir un nuevo "bloque" de configuración, donde indicaremos el dominio y la ubicación del archivo de zona:
  
  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/9307d096-6b6e-41e3-9149-17d41554bfc5)

  Aqui podemos ver cómo responde a los subdominios de roca.home:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/b04c6fa6-45ee-4914-85e1-bb3991f83217)
  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/2a70832e-35b1-4091-a1d2-06f3198f2f90)

<br>

#### Configuración archivos de zona inversa

  Necesitaremos crear una zona inversa en el directorio, lo más fácil és usar el archivo `/etc/bind/db.127` como plantilla, no debemos borrar este archivo así que usaremos la orden cp:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/1087068d-aac6-422b-ab21-26d20c0c6bb1)

Esta es la configuración que usaremos para la zona inversa, al igual que antes, necesitaremos cambiar `localhost.` por nuestro dominio, en mi caso `roca.home` (en el caso de configurar servidores secundarios, este campo suele rellenarse con ns1.dominio.tld) y luego el FQDN que pasará de ser `root.localhost.` a `root.roca.home.`

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/d98adccc-b996-4183-9e80-3838977f921c)

  Después declararemos los PTR (pointers), estos en el primer campo tendrán en el primer campo el último octeto de la ip (31 en este caso) IN y PTR para indicar que es una entrada que apunta a un dominio y después el FQDN que vamos a visitar:
  
  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/e0da7173-038b-4831-95be-d638743394fd)

  Después editaremos el archivo `/etc/bind/named.conf.local` y añadimos el siguiente bloque de configuración, tenemos que cambiar "0.168.192." por la IP de nuestra red, y "/etc/bind/db.192.168.0" por el nombre del archivo de la zona inversa:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/99abb2fc-438b-4f16-9b15-eb1aedadddfa)

  Este es un ejemplo de configuración: [db.192.168.0](configZonas/db.192.168.0)

  Y podemos ver que el servidor nos responde los dominios de las IPs:

  ![image](https://github.com/R3TR0R0C4/Useful-Self-Hosted/assets/95719205/dec0f790-b99d-49f3-b06e-8a4ade1c9b2f)


---

### Configuración como servidor secundario
