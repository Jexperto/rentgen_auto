To get it running, just copy & paste the snippet below in your terminal:

```bash
sudo docker build -t xtls-reality .
sudo docker run -d --rm -p 443:443 -v xtls-config:/opt/xray/config --name xtls-reality xtls-reality
```
or
```bash
sudo docker build -t xtls-reality .
sudo docker-compose up -d
```

### Container commands

After container was run using `docker run` or `docker compose up` command, it's possible to execute additional commands using `docker exec` command. For example, `sudo docker exec xtls-reality bash scripts/get-client-qr.sh`. See table below to get the full list of supported commands.

|                   Command                   |                                                               Description                                                                 | 
|:-------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:| 
|    `scripts/get-client-qr.sh <short_id>`    | Outputs a QR-code with client settings. You can scan this code by a mobile application (for example, v2rayNG) and get a quick connection. | 
| `scripts/get-client-settings.sh <short_id>` |                                                  Outputs a client settings in text form                                                   | 
|         `scripts/reload-config.sh`          |                                            Restarts xray inside container with config refresh                                             | 
|          `scripts/list-clients.sh`          |                                 Shows all existing clients - primarily used for getting desired short_id                                  | 
|  `scripts/add-client.sh --nickname <name>`  |                                  Adds a new client with an optional nickname for better identification                                    | 



