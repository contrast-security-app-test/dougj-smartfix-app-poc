FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl jq

COPY /docker/sca-cli/contrast-sca-cli.sh /usr/local/bin/contrast-sca-cli.sh
RUN chmod +x /usr/local/bin/contrast-sca-cli.sh

ENTRYPOINT ["/usr/local/bin/contrast-sca-cli.sh"]
