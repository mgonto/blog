FROM jfromaniello/jekyll

EXPOSE 80

RUN \
  apt-get update && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

ADD nginx.conf /etc/nginx/nginx.conf

RUN gem install jekyll -v 1.5.1
RUN gem install psych -v 2.0.5
RUN gem install rdiscount -v 2.1.7.1
RUN gem install stringex -v  2.5.2

ADD . /data
WORKDIR /data

ENV JEKYLL_ENV production

RUN jekyll build

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
