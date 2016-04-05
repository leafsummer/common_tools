#!/bin/bash
docker run --name docker_dnsmasq  -d -p 53:53 -p 22:22 leafsummer/dnsmasq