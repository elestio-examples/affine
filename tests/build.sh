pwd=$(pwd)

mv "$pwd"/.github/deployment/Dockerfile "$pwd"

sed -i "s~COPY ./apps/web/out ./dist~COPY ./apps/web ./dist~g" ./Dockerfile

docker build . --tag elestio4test/affine:latest;
TAG_TO_CHANGE