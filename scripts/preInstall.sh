set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p -m 750 ./data

chown -R 1000:1000 ./data
