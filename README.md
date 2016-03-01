## Custom DDNS

This is a script might be usefull for some DynDNS services which is not available from WebUI.

### Installation

1. Log into router's SSH/telnet/serial console and download script:
```
wget --no-check-certificate -O - https://raw.githubusercontent.com/DontBeAPadavan/custom-ddns/master/etc/storage/ddns.sh > /etc/storage/ddns.sh
chmod +x /etc/storage/ddns.sh
```
2. Edit `/etc/storage/ddns.sh`. Find `User DDNS command should be placed here.` comment and place your own code. There is SMS sending as an example.
3. Now go to router WebUI, `Customization > Scripts` and add following string to `Run After WAN Up/Down Events` field:
```
/etc/storage/ddns.sh $1 $2 $3
```
