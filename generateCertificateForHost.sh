sudo openssl req -newkey rsa:2048 -nodes -batch -sha256 -config $1.conf -out $1.crt.csr -keyout $1.key
sudo openssl x509 -days 3650 -sha256 -req -in $1.crt.csr -out $1.crt -extensions v3_ext -extfile $1.conf -CA rootCA.crt -CAkey rootCA.key -CAcreateserial
