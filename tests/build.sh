pwd=$(pwd)

mv "$pwd"/.github/deployment/Dockerfile "$pwd"

docker build . --tag elestio4test/affine:latest;
TAG_TO_CHANGE