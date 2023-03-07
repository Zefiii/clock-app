FROM nginx:stable-alpine

RUN chown -R nginx: /etc/nginx/* && \
        chown -R nginx: /var/cache/nginx && \
        chown -R nginx: /var/log/nginx && \
        chown -R nginx: /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid
USER nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html
