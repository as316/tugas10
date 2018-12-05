FROM nginx:latest
RUN apk apt-get update -q && apt-get dist-upgrade -y && apt-get clean && apt-get autoclean && apt-get install openssl -y \
	mkdir -p $WWW_PATH && chown nginx:nginx $WWW_PATH \
	printf "user:$(openssl passwd -1 $PASSWORD)\n" >> $WWW_PATH/.htpasswd \
        rm /etc/nginx/conf.d/default.conf \
        mkdir -p /tmp/nginx/

COPY etc/nginx/conf.d/main.conf /etc/nginx/conf.d/
COPY usr/share/www/html/ /usr/share/www/html/
ADD files/index.html /usr/share/nginx/

# Environment Variables
ENV WWW_PATH /usr/share/www/html

EXPOSE 80/tcp

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
