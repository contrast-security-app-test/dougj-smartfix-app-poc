FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl jq

ENV CONTRAST_HOME=/home/contrast

RUN groupadd -r contrast && \
 useradd -rm -d ${CONTRAST_HOME} -s /bin/bash -g contrast contrast
RUN chown -R contrast:contrast ${CONTRAST_HOME}

COPY /docker/sca-cli/contrast-sca-cli.sh ${CONTRAST_HOME}/contrast-sca-cli.sh
RUN chmod +x ${CONTRAST_HOME}/contrast-sca-cli.sh
RUN chown contrast:contrast ${CONTRAST_HOME}/contrast-sca-cli.sh

WORKDIR ${CONTRAST_HOME}
USER contrast

ENTRYPOINT ["/home/contrast/contrast-sca-cli.sh"]
