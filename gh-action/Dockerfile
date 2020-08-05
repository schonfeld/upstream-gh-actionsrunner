FROM alpine

WORKDIR /work

ENV K8S_VERSION=v1.17.0

RUN apk add --no-cache bash curl docker python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN pip3 --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(echo $K8S_VERSION)/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl

COPY entrypoint.sh /work/entrypoint.sh

ENTRYPOINT ["/work/entrypoint.sh"]
