#!/bin/bash -x
# @link http://techbrahmana.blogspot.co.uk/2013/10/creating-wildcard-self-signed.html

# NOTE: Copies of of certs have been copied to /puppet/modules/sslcerts/files

cd    "$(dirname "$0")"

# Set Params
Country=GB
State=London
City=London
Organization="Crystalline Technologies"
Section=""
FQDN=jamesmcguigan.com
Email=james.mcguigan@gmail.com


## Generate Private Key
openssl genrsa -des3 -passout pass:foobar -out jamesmcguigan.san.key.password 2048

##  Convert the private key to an unencrypted format
openssl rsa -passin pass:foobar -in jamesmcguigan.san.key.password -out jamesmcguigan.san.key

##  Create the certificate signing request
openssl req -new -key jamesmcguigan.san.key -out jamesmcguigan.san.csr <<EOF
$Country
$State
$City
$Organization
$Section
$FQDN
$Email
.
.
EOF

## Sign the certificate with extensions
openssl x509 -req -extensions v3_req -days 365 -in jamesmcguigan.san.csr -signkey jamesmcguigan.san.key -out jamesmcguigan.san.crt -extfile jamesmcguigan.san.conf
#    -CA ../rootCA/jamesmcguigan.rootCA.crt -CAkey ../rootCA/jamesmcguigan.rootCA.key -CAcreateserial

#
#openssl genrsa             -out jamesmcguigan.san.key 2048
#openssl req    -new -nodes -out jamesmcguigan.san.csr -config jamesmcguigan.san.conf
#openssl x509   -req -CA ../rootCA/jamesmcguigan.rootCA.pem -CAkey ../rootCA/jamesmcguigan.rootCA.key -CAcreateserial -in jamesmcguigan.san.csr -out jamesmcguigan.san.crt -days 3650
##end
