#!/bin/bash -x

##### Install SSH Keys #####

cat <<- _EOF_ > /root/.ssh/github-radicalcompany-nestle_id_rsa
# Github key for radicalcompany-nestle user - allows automated access
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAsLBdIToeHzP0zBWs8+aPTbWLsmKHSslseYHUtoTy5a67KwZq
rK4RUz+RC0PHV+7eTD606GFVpRKdvjHvntqlzxnLygd92MBYLmD7jmLDfubpt6JY
qTXbvYhG/kp81Z/5Dk0INVe2NpCayG42rPWBoC4KxiwLevjXuXNzKHLjqYgJCluu
t9fkEWPXtUw6pAw6pgw+ALnXE0Y8uOsIPKkYrjKX9Dg1SsI/d9BAJ9ivm2WO3p+A
6igyioHqRZUXuCv0SaU50lgIPjJRP6wwWRw8f74Trd6m36DRS1wS3TVxuCREJCIr
tfgkJ4VaBG1GIYAPCSn2KHZJv59qELrJj+edBQIDAQABAoIBABmeyTJLOhjuML3z
GqwXL4pmG8aXEOUgRfFsiQqaRppVduBrQsadSvfWTNLkViCDC4rkwNi9XGzeQS9W
EFfpfoeERw+ZfH8UjPTUrUVdPtnE4/jzuoV2wNE/1IOFC4rycmvHcbxCZrKMz1Tm
3ljAFLbEVl2b/2IqeSVz/yvLVQW87VsI9NHkGKmoASQ8va0R0HOGt8/OogV8DKOj
+KBonM/dP1WcmkCz1K7ByrcyDgPs9jUb4sbwmF9gn8RI/CSPq34lgTeqITwPz2ud
Ajrm3Hb5aYbaB/UjMHLnM6THPzmXvXow4YC+K+lIYBEy+4DPaJcjPv2xqv/gcFbj
NVEsB+ECgYEA1/s3OMhuO3eHMM+4XUtcdks+dHvfYZLLlIpyk7lWPvSMS9ZqDJ6O
6nAo/83wOxT/67L5rOSOBhhp4s14+RRwKaNFxUVM2jntaoQnVbL280/jTa5PRXBN
rTgWr31cgk7u7SSvA9UtnoXVdvDMDXgNWtPvgalC/ZihaFMsL+atJ1kCgYEA0W1d
vJKxATWoh9tRKpXTGMWcpD+U4Wpw9KRyQILAYMHBsFUxfHG9rgUinl5AWdsltTe2
v7b1KigXyGhiXV2QGGaAOuWwqvsb1V9ZfJucLyQ4ZkAeFLVconFno8JCDPC2NqVp
FsFO75HkppxDKKpyekZP3jTin7O1gi0Ymj5TWY0CgYA99bqs1osREkQ9U4nvcbwv
z3w2TIcT5dnzXhhqmqPMYbmR1AwOXLphNRX99KVzPZ4BjxGjcNnxk7VktE99HUjk
GQveAPiALlgW05y5MCM6P/PUiCoDoKkYBVw0sgEE/QH8FCcFMXXp4TkQ6xmOz579
LImsJ9OpDs1XMW0evM112QKBgGCnHsm20aYDQ6Jfn5gNyXz3RpGvHmDiJPtjIa+Q
KIT/JwrgZpROUgIMMKvyR7SwpTh7XAYixAcOtdsyAaOhWK1KMQf9lYlzlqbk+IG/
t1cyWi0mjjt0cCowOGqlbqJWPWH++P8de/ao2GPkXkJYV7kC1j1xHt4hrDVF5sLY
3NLJAoGBANTfz6mvbrZBv8We1vheYt2HFF6qjfTVIiEKklIeBKowvwtDtfBVHB9J
FzvY/0RhCD8AM7khXyXHkWmgPIx92451WQxzytXqcqXT2ibSt4B4K1KSveCo0UrX
f0Qa5z2hRQKYSyZ/6kHTRPfrpOT/VHakvBcSALBJY98BricDxNtM
-----END RSA PRIVATE KEY-----
_EOF_

cat <<- _EOF_ > /root/.ssh/github-radicalcompany-nestle_id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwsF0hOh4fM/TMFazz5o9NtYuyYodKyWx5gdS2hPLlrrsrBmqsrhFTP5ELQ8dX7t5MPrToYVWlEp2+Me+e2qXPGcvKB33YwFguYPuOYsN+5um3olipNdu9iEb+SnzVn/kOTQg1V7Y2kJrIbjas9YGgLgrGLAt6+Ne5c3MocuOpiAkKW6631+QRY9e1TDqkDDqmDD4AudcTRjy46wg8qRiuMpf0ODVKwj930EAn2K+bZY7en4DqKDKKgepFlRe4K/RJpTnSWAg+MlE/rDBZHDx/vhOt3qbfoNFLXBLdNXG4JEQkIiu1+CQnhVoEbUYhgA8JKfYodkm/n2oQusmP550F github-radicalcompany-nestle
_EOF_

cat <<- _EOF_ >> /root/.ssh/config
Host github.com
  IdentityFile ~/.ssh/github-radicalcompany-nestle_id_rsa
_EOF_

ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts

chmod 600 /root/.ssh/*



##### Install Required Software #####

export EDITOR=vim

apt-get -y update
apt-get -y upgrade
apt-get -y install python-software-properties
apt-get -y install build-essential
apt-get -y install git-core

# install before nodejs
apt-get -y install npm
npm update
npm config set registry http://registry.npmjs.org/
npm install -g http://github.com/npm/npm/tarball/master
ln -sf /usr/local/bin/npm /usr/bin/npm

add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update

apt-get -y install nodejs
apt-get -y install mongodb
apt-get -y install supervisor
apt-get -y install bash-completion
apt-get -y install nmap
apt-get -y install curl
apt-get -y install nginx
apt-get -y install parallel
apt-get -y install ntp
apt-get -y autoremove
apt-get -y install imagemagick
apt-get -y install ruby-compass
npm install -g bower



##### Set Timezone to UTC #####
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
ntpdate && hwclock –w

##### Install NestleWellnessApp #####

git clone git@github.com:radicalcompany/NestleWellnessApp.git /var/www/NestleWellnessApp

cd /var/www/NestleWellnessApp/server
npm install

cd /var/www/NestleWellnessApp/website
yes | bower install --allow-root
npm install

cd /var/www/NestleWellnessApp/cronjobs
npm install


cat <<- _EOF_ > /etc/supervisor/conf.d/NestleWellnessAppServer.conf
[program:NestleWellnessAppServer]
environment=NODE_ENV=production
command=/usr/bin/node /var/www/NestleWellnessApp/server/WellnessCluster.js
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
_EOF_

cat <<- _EOF_ > /etc/supervisor/conf.d/NestleWellnessWebsite.conf
[program:NestleWellnessWebsite]
environment=NODE_ENV=production
command=/usr/bin/node /var/www/NestleWellnessApp/website/WellnessWebsite.js
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
_EOF_


cat <<- _EOF_ > /etc/supervisor/conf.d/NestleWellnessUrbanAirshipCron.conf
[program:NestleWellnessUrbanAirshipCron]
environment=NODE_ENV=production
command=/usr/bin/node /var/www/NestleWellnessApp/cronjobs/UrbanAirshipCron.js
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
_EOF_



rm -vf /etc/nginx/sites-enabled/default
cat <<- '_EOF_' > /etc/nginx/sites-enabled/nestlechoosewellness
upstream nestlechoosewellness {
    server 127.0.0.1:3000;
}
server_names_hash_bucket_size 64;

server {
    listen 80;
    server_name  nestle2.clientsofradical.com;
    access_log   /var/log/nginx/nestlechoosewellness-http.log;
    error_log    /var/log/nginx/nestlechoosewellness-http-error.log;

    proxy_set_header        Accept-Encoding   "";
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    add_header              Front-End-Https   on;

    location / {
        proxy_pass  http://127.0.0.1:3000;
    }
    proxy_redirect     off;
}
server {
    ssl    on;
    listen 443;
    server_name nestle2.clientsofradical.com;
    access_log  /var/log/nginx/nestlechoosewellness-https.log;
    error_log   /var/log/nginx/nestlechoosewellness-https-error.log;


    ### force timeouts if one of backend is died ##
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;

    ### Set headers ####
    proxy_set_header        Accept-Encoding   "";
    proxy_set_header        Host              $host;
    proxy_set_header        X-Real-IP         $remote_addr;
    proxy_set_header        X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    add_header              Front-End-Https   on;

    ### SSL cert files ###
    ssl_certificate      /var/www/NestleWellnessApp/server/sslcert/nestle.clientsofradical.com.crt;
    ssl_certificate_key  /var/www/NestleWellnessApp/server/sslcert/nestle.clientsofradical.com.key;

    ### Add SSL specific settings here ###
    ssl_protocols        SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers RC4:HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    keepalive_timeout    60;
    ssl_session_cache    shared:SSL:10m;
    ssl_session_timeout  10m;

    location / {
        proxy_pass  https://127.0.0.1:3001;
    }
    proxy_redirect     off;
}
server {
    listen 80;
    server_name  www.nestle2.clientsofradical.com;
    access_log   /var/log/nginx/nestlechoosewellness-website-http.log;
    error_log    /var/log/nginx/nestlechoosewellness-website-http-error.log;

    proxy_set_header        Accept-Encoding   "";
    proxy_set_header        Host              $host;
    proxy_set_header        X-Real-IP         $remote_addr;
    proxy_set_header        X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    add_header              Front-End-Https   on;

    location / {
        proxy_pass  http://127.0.0.1:4000;
    }
    proxy_redirect     off;
}
server {
    ssl    on;
    listen 443;
    server_name www.nestle2.clientsofradical.com;
    access_log  /var/log/nginx/nestlechoosewellness-website-https.log;
    error_log   /var/log/nginx/nestlechoosewellness-website-https-error.log;

    ### force timeouts if one of backend is died ##
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;

    ### Set headers ####
    proxy_set_header        Accept-Encoding   "";
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    add_header              Front-End-Https   on;

    ### SSL cert files ###
    ssl_certificate      /var/www/NestleWellnessApp/server/sslcert/nestle.clientsofradical.com.crt;
    ssl_certificate_key  /var/www/NestleWellnessApp/server/sslcert/nestle.clientsofradical.com.key;

    ### Add SSL specific settings here ###
    ssl_protocols        SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers RC4:HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    keepalive_timeout    60;
    ssl_session_cache    shared:SSL:10m;
    ssl_session_timeout  10m;


    location / {
        proxy_pass  https://127.0.0.1:4001;
    }
    proxy_redirect     off;
}
_EOF_
service nginx restart;

if [[ `ps aux | grep node | grep WellnessServer.js` ]]; then
    service supervisor stop && \
    sleep 10s
fi;

service supervisor start;



##### Test Server is actually up and running #####

sleep 5s
ps aux | grep node | grep WellnessServer.js
tail -n 20 /var/log/supervisor/*