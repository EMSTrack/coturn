# Coturn docker file

## Build

docker build -t emstrack:coturn .

## Run

docker run --name coturn --network=host --env-file settings.env emstrack:coturn
