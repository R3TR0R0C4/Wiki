`sudo apt update && sudo apt install -y xdotool`


`sudo nano /opt/script.sh`

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

`chmod +x /opt/script.sh`

`xhost +local:`

`sudo crontab -e `

`0 * * * * /opt/script.sh`