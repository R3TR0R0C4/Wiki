## Configuración mas simple de netplan:

[archivo](./ubuntu%20netplan%20config%20ipv4%20static.txt)

```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:
      addresses:
        - 192.168.0.31/24
      routes:
        - to: 0.0.0.0/0
          via: 192.168.0.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]

```