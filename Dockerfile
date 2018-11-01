# Looking for information on environment variables?
# We don't declare them here — take a look at our docs.
# https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md

FROM node:8-slim    as build

#RUN apk add nodejs

LABEL maintainer="fehguy"

ENV API_KEY "**None**"
ENV OAUTH_CLIENT_ID "**None**"
ENV OAUTH_CLIENT_SECRET "**None**"
ENV OAUTH_REALM "**None**"
ENV OAUTH_APP_NAME "**None**"
ENV OAUTH_ADDITIONAL_PARAMS "**None**"
ENV SWAGGER_JSON "/app/swagger.json"
ENV PORT 8080
ENV BASE_URL ""

#COPY ./docker/nginx.conf /etc/nginx/

# copy swagger files to the `/js` folder
COPY ./dist/* /usr/share/nginx/html/
#COPY ./dist/index.html /usr/share/nginx/html/dist/index.original.html
COPY ./docker/run.sh /usr/share/nginx/


COPY ./app-proxy/dist /usr/share/nginx/html/app-proxy


COPY ./docker/configurator /usr/share/nginx/configurator

RUN chmod +x /usr/share/nginx/run.sh

EXPOSE 8080
#WORKDIR  /usr/share/nginx/html

#RUN ls node_modules
RUN ls /usr/share/nginx/html/

CMD ["sh", "/usr/share/nginx/run.sh"]
#CMD [ "node","server"]
