## Passos previs
1. Instal·lar mdadm amb apt
2. Utilitzar lsblk per saber quins discs utilitzar:
3. Formatar el disc i crear una particio.

Amb una eina com fdisk necessitem esborrar la taula de particions actual i després crear una particio a cadascun dels discs que utilitzarem

`sudo fdisk /dev/sda`

Amb aquesta comanda obrirem la consola d'fdisk, aqui utlitzarem l'opció `g` per crear una taula de particions GPT, tot seguit creem una nova partició amb `n`, sel·leccionem l'espai que volem que utilitzi i després guardarem els canvis amb `w`.

## Creació d`un raid
1. Crear un raid (estructura bàsica)

`sudo mdadm --create --verbose /dev/md0`

* Amb `mdadm --create` indiquem que volem crear un array
* Amb `--verbose` indiquem que volem rebre informació del procés de creació
* Amb `/dev/md0` indiquem quin és el dispositiu virtual que crearà el raid

<br>

**És molt important utilitzar la primera particio de cadascun dels discs, si utilitzem només el disc base (per exemple /dev/sda) després de reiniciar el servidor no s'auràn guardat els canvis.**

- Raid 0

`sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sda1 /dev/sdb1`

- Raid 1

`sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1`

- Raid 5

`sudo mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/sda1 /dev/sdb1 /dev/sdc1`

**Una vegada creem el raid 5, cal comprobar l'estat de l'array amb `cat /etc/mdstat`, i asseguran-se de que s'ha acabat de construir l'array.**

Recordem que necessitem com a minim 3 discs

<br>

2. Guardar la configuració del array amb:
`sudo mdadm --detail --scan >> /etc/mdadm/mdadm.conf`

3. Crear un sistema de fitxers:
`sudo mkfs.ext4 -F /dev/md0`

4. Montar l'array
Primer de tot crear una carpeta on montar el disc:
`sudo mkdir /mnt/md0`

* Métode temporal
`sudo mount /dev/md0 /mnt/md0`

* Métode permanent
`sudo echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab`

5. Re-Generar initramfs

* Cal actualitzar la configuracio de initramfs per que el raid estigui disponible al boot i l'arxiu fstab pugui accedir-hi.
`sudo update-initramfs -u`

## Utilitzant un raid
1. Parar un array:
`sudo mdadm --stop /dev/md0`

2. Iniciar un array:
`sudo mdadm --run /dev/md0`
