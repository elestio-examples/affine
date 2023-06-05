pwd=$(pwd)

mv "$pwd"/.github/deployment/Dockerfile "$pwd"

cat << EOT > Dockerfile
FROM node:16-alpine as relocate
RUN yarn install
RUN yarn build
RUN cd apps/web && yarn install && npm run build && npm run export
RUN cd ..
RUN cd ..
WORKDIR /app
COPY ./apps/web/out ./dist
COPY ./.github/deployment/Caddyfile ./Caddyfile


FROM caddy:2.6.2-alpine
ARG API_SERVER
WORKDIR /app
COPY --from=relocate /app .

EXPOSE 3000
ENV API_SERVER=$API_SERVER
CMD ["caddy", "run"]
EOT

sed -i "s~:80~:3000~g" "$pwd"/.github/deployment/Caddyfile

docker build . --tag elestio4test/affine:latest;
TAG_TO_CHANGE