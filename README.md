# wgscribe
This script lets you connect to Windscribe VPN servers through WireGuard. Heavily inspired by wgnord.

```
Usage: wgscribe [ l(ogin) | c(onnect) | d(isconnect) | a(ccount) | s(tatus) ]

login:
    wgscribe l /path/to/windscribe.conf
    Download a WireGuard config from windscribe.com/getconfig/wireguard
connect:
    wgscribe c us
    wgscribe c us atlanta
    -f            Force server list refresh
    -n            Don't connect, just generate config
    -o out.conf   Write config to different file
    -p port       Use specific port (default: 443)
disconnect:
    wgscribe d
account:
    wgscribe a
    Prints information about the imported credentials
status:
    wgscribe s
    Prints current VPN connection status

wgscribe's files are in /var/lib/wgscribe, edit template.conf to change WireGuard options
```

## Installation

Dependencies:

- jq
- curl
- wg-quick (wireguard-tools)
- openresolv (for DNS)

### Nix

```
nix build github:E-Allie/wgscribe
```

Or add to your flake:
```nix
inputs.wgscribe.url = "github:E-Allie/wgscribe";
```

### Manual installation

```
git clone https://github.com/E-Allie/wgscribe
cd wgscribe
install -Dm644 template.conf /var/lib/wgscribe/template.conf
install -Dm644 countries.txt /var/lib/wgscribe/countries.txt
sudo install -Dm755 wgscribe /usr/bin/wgscribe
```

## Usage

First, download a WireGuard config from [windscribe.com/getconfig/wireguard](https://windscribe.com/getconfig/wireguard) (requires a Windscribe Pro account).

Import the config (you only need to do this once):
```
sudo wgscribe l /path/to/downloaded.conf
```

Now you can connect to a server:
```
sudo wgscribe c us
```

Connect to a specific city:
```
sudo wgscribe c us atlanta
```

Use a specific port (default is 443):
```
sudo wgscribe c de -p 53
```

To disconnect:
```
sudo wgscribe d
```

Country names and codes are case-insensitive. See `countries.txt` for a list of available locations.

## Extra
This script includes a kill-switch because of the way wg-quick works. Connections will typically stay alive for multiple days, but if it dies you can reconnect by running another connect command.

## Note
This third-party project is in no way affiliated with Windscribe, nor wgnord.
