# Server Docs

## Replace Disk in RAID

```shell
echo "idle" >  /sys/block/md0/md/sync_action 
mdadm --manage /dev/md0 --fail/dev/sdd
mdadm --manage /dev/md0 --remove/dev/sdd
mdadm --zero-superblock /dev/sdd
```

## Server hangs randomly

Its most likely about some C6 Power State
https://askubuntu.com/a/1321192

## UDM Pro VPN Rerouting

- Route traffic from vpn server to vpn client:
  - First we need to add a rule that will use the wgclient lookup table to forward traffic
  `ip rule add iif wgsrv1 lookup 211.wgclt1`
  - Optional: There however we have a line missing, which allows the network to go over the gateway back to the lan, this is only required if VPN client should be able to talk to each other
  `ip route add 192.168.150.0/24 dev wgsrv1 proto kernel scope link src 192.168.150.1 table 211.wgclt1`
  - And then again add a line to be able to go to the base network
  `ip route add 192.168.100.0/24 dev br0 proto kernel scope link src 192.168.100.1 table 211.wgclt1`

- To be able to have nextdns running with protonvpn change the dns server 192.168.150.1 in the wireguard config

## UDM Pro NextDNS Setup
- Install nextdns on udm pro
  `sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'`

## Install Wireguard Client and Connect to Server

- https://developerinsider.co/how-to-set-up-wireguard-client-on-ubuntu/

## Mount SMB Share on Ubuntu

- https://www.linode.com/docs/guides/linux-mount-smb-share/