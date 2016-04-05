#!/bin/bash

# Write stdin to /etc/addn-hosts.
cat > /etc/dnsmasq.host

# Cause our /etc/addn-hosts file to be reloaded, yay.
kill -HUP `pgrep dnsmasq`