FROM ubuntu:26.04@sha256:f144425ff09be612d6d9ad965196e9cdc23dae1f42110a8a11a3e9a8198759f7

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
