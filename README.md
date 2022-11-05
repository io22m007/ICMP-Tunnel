# Basics

ICMP (or the Internet Control Message Protocol) is a upper layer 3 protocol.


It is commonly used for diagnostic purposes (ping and traceroute).


ICMP for IPv4 is specified in rfc792 and ICMP for IPv6 (ICMPv6) ist specified in rfc4443.

![ICMP over IPv4 structure](https://homepages.uc.edu/~thomam/Net1/Diagrams/ip_icmp_pdu.png)

20 Byte IPv4 Header + 8 Byte ICMP fields + data (optional depending on the ICMP message type)

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

