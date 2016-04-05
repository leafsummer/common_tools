#!/bin/bash
docker run --name docker_dnsmasq -d -p 53:53/udp -p 53:53/tcp leafsummer/dnsmasq
