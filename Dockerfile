FROM amazonlinux:2022.0.20221101.0

RUN dnf install -y \
      make \
      && \
    dnf clean all && \
    rm -rf /var/cache/dnf

ARG VERSION_JENKINS
ARG USER

COPY docker/Makefile /tmp/Makefile

RUN make -C /tmp install && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    rm -rf /tmp/Makefile

# ENV TINI_VERSION 0.14.0
# ENV TINI_SHA 6c41ec7d33e857d4779f14d9c74924cab0c7973485d2972419a3b7c7620ff5fd
#
# # Use tini as subreaper in Docker container to adopt zombie processes 
# RUN curl -fsSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static-amd64 -o /bin/tini && chmod +x /bin/tini \
#   && echo "$TINI_SHA  /bin/tini" | sha256sum -c -
#
# COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

# ENV JENKINS_UC https://updates.jenkins.io
# ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
# RUN chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref

VOLUME /var/jenkins_home

USER $USER

# COPY jenkins-support /usr/local/bin/jenkins-support
# COPY jenkins.sh /usr/local/bin/jenkins.sh
# ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
#
# # from a derived Dockerfile, can use `RUN plugins.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
# COPY plugins.sh /usr/local/bin/plugins.sh
# COPY install-plugins.sh /usr/local/bin/install-plugins.sh
# Fo
