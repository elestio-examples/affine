pwd=$(pwd)

mv "$pwd"/.github/deployment/Dockerfile "$pwd"

sleep 30s;

cd "$pwd"/apps/web

echo "Installing"
yarn install;
echo "Building"
npm run build;
echo "Exporting"
npm run export;

cd "$pwd"

sed -i "s~COPY ./apps/web/out ./dist~COPY $pwd/apps/web/out ./dist~g" ./Dockerfile
sed -i "s~COPY ./.github/deployment/Caddyfile ./Caddyfile~COPY $pwd/.github/deployment/Caddyfile ./Caddyfile~g" ./Dockerfile
sed -i "s~EXPOSE 80~EXPOSE 3000~g" ./Dockerfile
sed -i "s~:80~:3000~g" "$pwd"/.github/deployment/Caddyfile

docker build . --tag elestio4test/affine:latest;
TAG_TO_CHANGE