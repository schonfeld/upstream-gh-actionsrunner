FROM python:3-stretch

WORKDIR /work

ENV DOCKER_VERSION=18.06.1-ce
ENV K8S_VERSION=v1.12.7

RUN apt-get update && \
  apt-get install -y --no-install-recommends curl groff jq && \
  apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
  curl -fsSLO https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 && \
  mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator && \
  chmod +x /usr/local/bin/aws-iam-authenticator && \
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
  tar xzvf docker-${DOCKER_VERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKER_VERSION}.tgz && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install setuptools awscli

RUN curl -LO curl -LO https://storage.googleapis.com/kubernetes-release/release/$(echo $K8S_VERSION)/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl

COPY entrypoint.sh /work/entrypoint.sh

ENTRYPOINT ["/work/entrypoint.sh"]
