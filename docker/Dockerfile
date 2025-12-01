FROM ubuntu:latest

ENV CONTRAST_HOME=/home/contrast

RUN groupadd -r contrast && \
 useradd -rm -d ${CONTRAST_HOME} -s /bin/bash -g contrast contrast
RUN chown -R contrast:contrast ${CONTRAST_HOME}

COPY /docker/contrast-orchestrator.sh ${CONTRAST_HOME}/contrast-orchestrator.sh
RUN chmod +x ${CONTRAST_HOME}/contrast-orchestrator.sh
RUN chown contrast:contrast ${CONTRAST_HOME}/contrast-orchestrator.sh

WORKDIR ${CONTRAST_HOME}
USER contrast

ENTRYPOINT ["/home/contrast/contrast-orchestrator.sh"]
