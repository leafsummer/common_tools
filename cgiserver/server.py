#!/usr/bin/evn python

#BaseHTTPServer provides us with a simple web server
import BaseHTTPServer
#CGIHTTPServer provides us with a request handler
import CGIHTTPServer
##The cgitb enables CGI error reporting
import cgitb

cgitb.enable()

#Create a server and a request handler
server = BaseHTTPServer.HTTPServer
handler = CGIHTTPServer.CGIHTTPRequestHandler
#Specifies an address for the server
server_address = ("0.0.0.0", 8000)
#Specifies where the CGI scripts will reside in relation to the 'server' directory
handler.cgi_directories = ["/"]
#Create our server
httpd = server(server_address, handler)
httpd.serve_forever()