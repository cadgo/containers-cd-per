#/bin/bash
POD_PORT=8089
POD_NAME=vulnapi
CONF_PATH=/etc/nginx/sites-enabled/api_app.conf
LPORT=8098
#VALIDATE IF DOCKER IS RUNNING TODO

#deploy docker 
docker run -tid --rm -p $POD_PORT:8081 --name $POD_NAME mkam/vulnerable-api-demo


cat << EOF > $CONF_PATH
server {
    listen $LPORT default_server;

#    ssl_certificate /etc/ngen/ssl/cert/cloud-ngen.crt;

#    ssl_certificate_key /etc/ngen/ssl/cert/cloud-ngen.key;

    location / {










        proxy_pass http://127.0.0.1:$POD_PORT;
    }
}
EOF
#Validate if Nginx restart correctly

nginx -t
service nginx restart

