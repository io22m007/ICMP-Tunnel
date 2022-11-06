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



# sources

https://en.wikipedia.org/wiki/IPv4

https://www.elektronik-kompendium.de/sites/net/2011241.htm

https://homepages.uc.edu/~thomam/Net1/Packet_Formats/icmp.html

https://www.ionos.at/digitalguide/server/knowhow/was-ist-das-icmp-protokoll-und-wie-funktioniert-es/

https://www.elektronik-kompendium.de/sites/net/0901011.htm

https://www.javatpoint.com/computer-network-tcp-ip-model

https://www.rfc-editor.org/rfc/rfc792
