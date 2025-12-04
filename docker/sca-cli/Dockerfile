FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl jq

COPY /docker/sca-cli/contrast-sca-cli.sh contrast-sca-cli.sh
RUN chmod +x contrast-sca-cli.sh

ENTRYPOINT ["contrast-sca-cli.sh"]
