## Configuracion mas simple de apache2

[ApacheConfig](./simpleHTTPconfig/apache2%20default%20simplest%20html%20port%2080%20config.txt)

```
<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```