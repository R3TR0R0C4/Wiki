### Heimdall Install

- Actualizar repositorios:

`sudo apt update`

- Instalar PHP, dependencias de PHP y git:

`sudo apt install php8.1 php8.1-sqlite3 php8.1-zip git`

- Crear carpeta que contendra heimdall:

`sudo mkdir /var/www/heimdall`

- Clonamos con git el repositorio de heimdall y descargamos en la carpeta que creamos anteriormente:

`sudo git clone https://github.com/linuxserver/Heimdall.git /var/www/heimdall`

- Entramos a la carpeta:

`cd /var/www/heimdall`

- Usamos [artisian](https://laravel.com/docs/10.x/artisan) para configurar la API:

`sudo php artisan key:generate`

- Cambiamos el usuario y grupo propietario de heimdall a "www-data":

`sudo chown -R www-data:www-data /var/www/heimdall`

- Cambiamos los permisos a 755 para la carpeta:

`sudo chmod -R 755 /var/www/heimdall/` <br>



### Apache config

- Creamos el archivo `/etc/apache2/sites-available/heimdall.conf` con el contenido de [heimdall.conf](heimdall.conf)

`sudo nano /etc/apache2/sites-available/heimdall.conf`

- Habilitamos el modulo rewrite para que las URLs del servicio funcionen correctamente:

`sudo a2enmod rewrite`

- Habilitamos la configuración de heimdall de apache:

`sudo a2ensite heimdall.conf`

- Y por ultimo reiniciamos y vemos el estado de apache:
  
`sudo systemctl restart apache2.service && sudo systemctl status apache2.service`
