# Looking for information on environment variables?
# We don't declare them here — take a look at our docs.
# https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md
# WE USE a dependencies image where the installed dependencies are cached, build using ./sidt.sh -u dependencies -c
FROM  ufp-swagger-proxy-app-dependencies:6  as build

WORKDIR /build

COPY ./ /build

# build swagger ui dist/ \
RUN npm run build
#  goto app-proxy which forwards requests and serves as file host for the swaggerui dist files

WORKDIR /build/app-proxy

# create dist file :)
RUN npm run dist


FROM node:8-slim    as final
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

COPY --from=build /build/dist/* /usr/share/nginx/html/
COPY --from=build /build/docker/run.sh /usr/share/nginx/
COPY --from=build /build/app-proxy/dist /usr/share/nginx/html/app-proxy
COPY --from=build /build/docker/configurator /usr/share/nginx/configurator

RUN chmod +x /usr/share/nginx/run.sh
EXPOSE 8080
RUN ls /usr/share/nginx/html/
CMD ["sh", "/usr/share/nginx/run.sh"]
