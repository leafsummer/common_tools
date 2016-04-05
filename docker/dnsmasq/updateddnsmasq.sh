#!/bin/sh
cnlist() {                                                                      
    wget -4 -T 60  --no-check-certificate -O /etc/dnsmasq.d/accelerated-domains.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
    wget -4 -T 60  --no-check-certificate -O /etc/dnsmasq.d/bogus-nxdomain.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/bogus-nxdomain.china.conf
}
adblock() {
    wget -4 -T 60  --no-check-certificate -O - https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt | grep ^\|\|[^\*]*\^$ |
    sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' | uniq > /etc/dnsmasq.d/adblock.conf

    wget -4 -T 60  --no-check-certificate -O - https://raw.githubusercontent.com/kcschan/AdditionalAdblock/master/list.txt | 
    grep ^\|\|[^\*]*\^$ | 
    sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' >> /etc/dnsmasq.d/adblock.conf
}
cnlist
adblock