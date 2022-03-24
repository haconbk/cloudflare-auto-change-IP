#!/bin/bash

#CHEN THONG TIN VAO DAY
DomainName=your-domain-name.com
## THONG TIN TAI KHOAN CLOUDFLARE ##
## GIU BI MAT CHI MINH BAN BIET ##
#EMAIL
cloudflare_auth_email=your-email@domain.com
#Global API Key
cloudflare_auth_key=123456789qwertyuiopasdfghjklzxcvbnm00
#LAY DIA CHI IP HIEN TAI CUA SERVER
ip=$(curl -s -X GET https://checkip.amazonaws.com)

echo "IP hien tai cua SERVER la $ip"
#KIEM TRA IP HIEN TAI CUA SERVER VOI A RECORD TREN CLOUDFLARE CO TRUNG NHAU KHONG
#NEU TRUNG THI KHONG CAN CAP NHAP
if host $DomainName 1.1.1.1 | grep "has address" | grep "$ip"; then
  echo "tren SERVER $DomainName hien tai co IP la $ip; khong can thay doi"
  exit
fi
#NEU KHONG TRUNG TIEN HANH CAP NHAP
#LAY Zoneid CUA DOMAIN
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DomainName&status=active" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" | grep -Po '(?<="id":")[^"]*' | head -1)
#HIEN THI LEN DE DEBUG, HOAT DONG TOT COMMENT LAI
echo "Zoneid cua $DomainName la $zoneid"
#LAY DNS A RECORD HIEN TAI
dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$DomainName" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" | grep -Po '(?<="id":")[^"]*' | head -1)
#HIEN THI LEN DE DEBUG, HOAT DONG TOT COMMENT LAI
echo "DNSrecordid cua $dnsrecord la $dnsrecordid"
#CAP NHAP DNS A RECORD MOI
echo "Dia chi IP moi da duoc cap nhap!"
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":false}" | grep -Po '(?<="content":")[^"]*' | head -1
