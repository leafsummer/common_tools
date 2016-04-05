#!/bin/bash
docker run --name docker_dnsmasq -d -p 53:53/udp --privileged leafsummer/dnsmasq