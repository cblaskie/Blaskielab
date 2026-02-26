FROM ubuntu:22.04@sha256:3ba65aa20f86a0fad9df2b2c259c613df006b2e6d0bfcc8a146afb8c525a9751

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
