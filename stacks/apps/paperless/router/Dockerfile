FROM ubuntu:26.04@sha256:19fcd1bf268f02b60aca3bd30bd8a6d9a11759a430e32921833e65f16d87348a

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      imagemagick \
      inotify-tools \
      libheif1 \
      libheif-examples && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY router.sh /router.sh
RUN chmod +x /router.sh

ENTRYPOINT ["/router.sh"]
