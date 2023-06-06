pwd=$(pwd)

mv "$pwd"/.github/deployment/Dockerfile "$pwd"

cd "$pwd"/apps/web

echo "Installing"
yarn install;
echo "Building"
npm run build;
echo "Exporting"
npm run export;

cd "$pwd"

sed -i "s~EXPOSE 80~EXPOSE 3000~g" ./Dockerfile
sed -i "s~:80~:3000~g" "$pwd"/.github/deployment/Caddyfile

docker build . --tag elestio4test/affine:latest;
TAG_TO_CHANGE