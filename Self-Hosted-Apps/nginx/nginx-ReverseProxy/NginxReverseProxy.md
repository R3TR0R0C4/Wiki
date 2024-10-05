# HTTP server
```
server {
    listen 80;
    server_name roca.home;

    location / {
        proxy_pass http://192.168.0.51:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

server {
    listen 80;
    server_name dns.roca.home;

    location / {
        proxy_pass http://192.168.0.51:81;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
